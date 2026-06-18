local propsPropsList = {}
local pma = exports["pma-voice"]
local areCrosseHitsDisabled = false
local scoot = false
local driftmode = false
local previewPropMenu = nil
local distance = -1
local player = nil
local facturessss = {}
local isintestdrive = false
cloneInterface = true
cinemamode = false
hudhide = true
menumap = true
casque = true
moto = false
crosshairactive = true
fighthand = true
covermod = false
isHudDisabled = false
silenceTimeIndexSingle = 1
silenceTimeIndexSingleVotes = 1
silenceTimeList = {
    "5 minutes",
    "10 minutes",
    "15 minutes",
    "20 minutes",
    "25 minutes",
    "30 minutes",
    "1 heure",
}
--coupdecrossmv = false
--rouladeMGL = true
    Citizen.CreateThread(function()
        while not crosshairactive do
            HideHudComponentThisFrame(14)
            Citizen.Wait(0)
        end
    end)
    function crosshair()
        HideHudComponentThisFrame(14)
    end
    Citizen.CreateThread(function()
        while not fighthand do
            local sleepTime = 750
            if Player.weapon == `WEAPON_UNARMED` then
                sleepTime = 0
                DisableControlAction(0, 24)
                DisableControlAction(0, 140)
            end
            Citizen.Wait(sleepTime)
        end
    end)
Citizen.CreateThread(function()
     while covermod do
        DisableControlAction(0, 44)
        Citizen.Wait(0)
        end
    end)
function ChangePedModel(pedIndex, skinModel)
    if GetSafeZone() then
    local ped = PlayerPedId()
    if DoesEntityExist(ped) then
        RequestModel(skinModel)
        while not HasModelLoaded(skinModel) do
            Wait(1)
        end
        SetPlayerModel(PlayerId(), skinModel)
        SetPedDefaultComponentVariation(ped)
        SetModelAsNoLongerNeeded(skinModel)
        end
    end
end
Citizen.CreateThread(function()
    Citizen.Wait(1000) 
    fetchNumberOfSocieties()
end)
local vip_plates = {}

exports('activeCloneInterface', function()
    return cloneInterface
end)

local weaponTint = {
    {id = 0, name = "Normal"},
    {id = 1, name = "Vert"},
    {id = 2, name = "Or"},
    {id = 3, name = "Rose"},
    {id = 4, name = "Armée"},
    {id = 5, name = "LSPD"},
    {id = 6, name = "Orange"},
    {id = 7, name = "Platine"},
}

local posjob = {
    ['taxi'] = {z = 73.4714, x = 916.642, y= -170.5425},
    ['ambulance'] = {z = 43.28411, x = 306.8368, y = -601.4506},
    ['gouvernement'] = {z = 43.28411, x = 306.8368, y = -601.4506},
    ['starpizza'] = {z = -1352.5557861328126, x = -1352.5557861328126, y = -1055.9505615234376},
    ['bcso'] = {z = -1352.5557861328126, x = -437.8479614257813, y = 6011.97412109375},
    ['airdealer'] = {z = -1352.5557861328126, x = -900.5676879882813, y = 19.84539794921875},
    ['police'] = {z = -1352.5557861328126, x = 438.5268, y = -982.1306},
    ['motodealer'] = {z = -1352.5557861328126, x = 955.5384521484376, y = -118.72398376464844},
    ['boatdealer'] = {z = -1352.5557861328126, x = -805.7225341796875, y = -1368.7467041015626},
    ['cardealer'] = {z = -1352.5557861328126, x = -23.51351356506347, y = -1102.084716796875},
}


local fetchedNumberOfSocieties = false
local NumberSocietyStatus = 0

local societyStatusCache = {
    open = {},
    closed = {},
    dirty = true,
    lastCount = 0,
    lastAttempt = 0
}

local societyCacheRetryDelay = 750

local societyStatusBlacklist = {
    -- ['vigne'] = true
}

local societyStatusView = {
    perPage = 12,
    pagination = {
        open = {index = 1, total = 1, labels = {'Page 1/1'}},
        closed = {index = 1, total = 1, labels = {'Page 1/1'}}
    }
}

local function getCurrentXpLevel()
    if type(XNL_GetCurrentPlayerLevel) == 'function' then
        local level = XNL_GetCurrentPlayerLevel()
        if level then
            return math.floor(level + 0.0)
        end
    end

    local ok, level = pcall(function()
        return exports['core']:Exp_XNL_GetCurrentPlayerLevel()
    end)

    if ok and level then
        return math.floor(level + 0.0)
    end

    return 0
end

local function clearArray(t)
    for i = #t, 1, -1 do
        t[i] = nil
    end
end

local function sortSocietyStatus(list)
    if #list > 1 then
        table.sort(list, function(a, b)
            return (a.label or a.name) < (b.label or b.name)
        end)
    end
end

local function rebuildSocietyStatusCache()
    societyStatusCache.lastAttempt = GetGameTimer()

    if not Society or not Society.List or next(Society.List) == nil then
        return false
    end

    clearArray(societyStatusCache.open)
    clearArray(societyStatusCache.closed)

    local total = 0

    for name, data in pairs(Society.List) do
        if type(data) == 'table' then
            total += 1

            local entry = {
                name = name,
                label = data.label or name,
                value = data.state and '~g~Ouvert~s~' or '~r~Fermé~s~',
                blips = data.blips
            }

            if data.state then
                societyStatusCache.open[#societyStatusCache.open + 1] = entry
            else
                societyStatusCache.closed[#societyStatusCache.closed + 1] = entry
            end
        end
    end

    sortSocietyStatus(societyStatusCache.open)
    sortSocietyStatus(societyStatusCache.closed)

    societyStatusCache.lastCount = total

    if total > 0 then
        NumberSocietyStatus = total
    end

    societyStatusCache.dirty = false

    return true
end

local function getSocietyStatusLists()
    return societyStatusCache.open, societyStatusCache.closed
end

local function markSocietyStatusCacheDirty()
    societyStatusCache.dirty = true
end

local function setSocietyWaypoint(entry)
    if entry.blips and entry.blips.position then
        SetNewWaypoint(entry.blips.position.x, entry.blips.position.y)
        return true
    elseif posjob[entry.name] then
        SetNewWaypoint(posjob[entry.name].x, posjob[entry.name].y)
        return true
    end

    return false
end

local function ensurePagination(meta, totalEntries)
    local perPage = societyStatusView.perPage
    local totalPages = math.max(1, math.ceil(totalEntries / perPage))

    if meta.index > totalPages then
        meta.index = totalPages
    elseif meta.index < 1 then
        meta.index = 1
    end

    if not meta.labels or #meta.labels ~= totalPages then
        meta.labels = {}
        for i = 1, totalPages do
            meta.labels[i] = ('Page %d/%d'):format(i, totalPages)
        end
    end

    meta.total = totalPages
end

RegisterNetEvent('sunny:society:sendList', function()
    markSocietyStatusCacheDirty()
end)

RegisterNetEvent('sunny:society:setSocietyState', function()
    markSocietyStatusCacheDirty()
end)

RegisterNetEvent('sunny:society:updateWithSocietyName', function()
    markSocietyStatusCacheDirty()
end)

RegisterNetEvent('sunny:society:add', function()
    markSocietyStatusCacheDirty()
end)

Citizen.CreateThread(function()
    while true do
        if societyStatusCache.dirty then
            local delta = GetGameTimer() - societyStatusCache.lastAttempt
            if delta >= societyCacheRetryDelay then
                rebuildSocietyStatusCache()
            end
            Citizen.Wait(100)
        else
            Citizen.Wait(1000)
        end
    end
end)

function fetchNumberOfSocieties()
    if not fetchedNumberOfSocieties then
        ESX.TriggerServerCallback('sunny:getNumberOfSocieties', function(numberOfSocieties)
            NumberSocietyStatus = numberOfSocieties
            fetchedNumberOfSocieties = true

            -- print('Nombre de sociétés récupéré:', NumberSocietyStatus)
        end)
    end
end


IndexAim = 1

local cross = true
local self = {}
self.radioEnabled = false
self.radioChannel = 0 
self.showVolume = false
self.radioTick = false
self.volumeRadio = 1

function openPersonnalMenu()

    if getIsDead() then return end

    local main = RageUI.CreateMenu('', 'Actions Disponibles')

    local vipMenu = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')

    local petMenu = RageUI.CreateSubMenu(vipMenu, '', 'Actions Disponibles')

    local permanentAnimalsMenu = RageUI.CreateSubMenu(vipMenu, '', 'Actions Disponibles')

    local animalAdoptMenu = RageUI.CreateSubMenu(permanentAnimalsMenu, '', 'Choisissez votre animal')

    local openVipPeds = RageUI.CreateSubMenu(vipMenu, '', 'Actions Disponibles')

    local selectedWeaponTint = RageUI.CreateSubMenu(vipMenu, '', 'Actions Disponibles')

    local selectedAnimals1 = RageUI.CreateSubMenu(vipMenu, '', 'Actions Disponibles')

    local vipPlates = RageUI.CreateSubMenu(vipMenu, '', 'Actions Disponibles')
    
    local vipPlateGestion = RageUI.CreateSubMenu(vipMenu, '', 'Actions Disponibles')

    local Portefeuille = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    local CustomMenu = RageUI.CreateSubMenu(vipMenu, '', 'Actions Disponibles')
    local CustomMenuSelected = RageUI.CreateSubMenu(CustomMenu, '', 'Actions Disponibles')

    local radioMenu = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')

    local VehicleOption = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')

    local EntrepriseOption = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')

    local OptionsVisuels = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    
    local visualconfig = RageUI.CreateSubMenu(OptionsVisuels, '', 'Actions Disponibles')

    local Notifmeny = RageUI.CreateSubMenu(visualconfig, '', 'Actions Disponibles')

    local OptiMenu = RageUI.CreateSubMenu(visualconfig, '', 'Actions Disponibles')

    local ModifMenu = RageUI.CreateSubMenu(visualconfig, '', 'Actions Disponibles')

    local OpenReportFast = RageUI.CreateSubMenu(OptionsVisuels, '', 'Actions Disponibles')
    
    local weaponsAnimationsMenu = RageUI.CreateSubMenu(FightModif, '', 'Actions Disponibles')
    
    local carconfig = RageUI.CreateSubMenu(OptionsVisuels, '', 'Actions Disponibles')

    local FightModif = RageUI.CreateSubMenu(OptionsVisuels, '', 'Actions Disponibles')

    local weaponsBind = RageUI.CreateSubMenu(OptionsVisuels, '', 'Actions Disponibles')

    local weaponsBindList = RageUI.CreateSubMenu(weaponsBind, '', 'Actions Disponibles')

    local stautinfo = RageUI.CreateSubMenu(OptionsVisuels, '', 'Actions Disponibles')
    
    local walksList = RageUI.CreateSubMenu(OptionsVisuels, '', 'Actions Disponibles')

    local openSocietyList = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')

    local propsMenu = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')

    local clothesMenu = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')

    local clothesMenu2 = RageUI.CreateSubMenu(clothesMenu, '', 'Actions Disponibles')

    local factures = RageUI.CreateSubMenu(Portefeuille, '', 'Actions Disponibles')

    local guids = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')

    local gestionlicense = RageUI.CreateSubMenu(Portefeuille, '', 'Actions Disponibles')

    local infojob = RageUI.CreateSubMenu(Portefeuille, '', 'Actions Disponibles')

    local infojob2 = RageUI.CreateSubMenu(Portefeuille, '', 'Actions Disponibles')

    local drugsmod = RageUI.CreateSubMenu(main, '', 'Actions Disponibles') 
    local territoryMenu = RageUI.CreateSubMenu(main, "", "Tableau des Territoires")
    
    local territoryData = nil
    RegisterNetEvent('cDrugs:refreshDashboard')
    AddEventHandler('cDrugs:refreshDashboard', function()
        ESX.TriggerServerCallback('cDrugs:getDashboardData', function(data)
            territoryData = data
        end)
    end) 

    local manageAnimalMenu = RageUI.CreateSubMenu(permanentAnimalsMenu, '', 'Gestion de votre animal')


    propsMenu.Closed = function()
        if DoesEntityExist(previewPropMenu) then
            DeleteEntity(previewPropMenu)
        end
    end
    radioMenu.EnableMouse = true
    RageUI.Visible(main, not RageUI.Visible(main))
    
    -- Helper for date formatting
    local function FormatDate(timestamp)
        if not timestamp then return "Inconnu" end
        -- If timestamp is a string (SQL date), return as is or parse
        return tostring(timestamp) 
    end
    
    while main do 
        Wait(1)
        RageUI.IsVisible(main, function()
            if SunnyConfigServ.RageUI.Header == true then
            RageUI.Separator(string.format("%s: %s", "ID Unique", Player.UniqueID))
            end
            --RageUI.Info(("%sInformations Personnel~s~"):format(UTILS.COLORCODE), {"ID Unique", "Entreprise", "Groupe Illégal", "Argent Propre", "Argent en Banque", "Argent Sale"}, {Player.UniqueID, ('%s (%s)'):format(Player.job.label, Player.job.grade_label), ('%s (%s)'):format(Player.job2.label, Player.job2.grade_label), ("~g~%s$~s~"):format(ESX.getAccountMoney("cash")), (SunnyConfigServ.GTACOLOR.."%s$~s~"):format(ESX.getAccountMoney("bank")), ("~r~%s$~s~"):format(ESX.getAccountMoney("black_money"))})
            RageUI.Separator(string.format("%s: %s", "ID Unique", Player.UniqueID))
            RageUI.Button("Portefeuille", "Votre Portefeuille", {RightLabel = "→"}, true, {
            onSelected = function()
                
            end
            }, Portefeuille)
            RageUI.Button(('Statut des entreprises (%s)'):format(NumberSocietyStatus), nil, {RightLabel = "→"}, true, {
            onSelected = function() 
                TriggerEvent('sunny:society:openMenu') -- Assuming this opens the society list, keeping original behavior if needed or just empty as in source
            end
            }, openSocietyList)

            -- Territory Dashboard Integration
            if Player.job2 and Player.job2.name ~= 'unemployed' and Player.job2.name ~= 'aucun' then
                RageUI.Button("Territoires", "Gérer et voir les territoires", {RightLabel = "→"}, true, {
                    onSelected = function()
                       TriggerEvent('cDrugs:refreshDashboard')
                    end
                }, territoryMenu)
            end
            
            if IsPedSittingInAnyVehicle(Player.playerPed) then 
            RageUI.Button('Gestion véhicule', 'Actions sur le véhicule', {RightLabel = "→"}, true, {}, VehicleOption)
            end
            RageUI.Button('Objets', nil, {RightLabel = "→"}, true, {
            onSelected = function()
                TriggerServerEvent('sunny:personalmenu:getpropspropss')

                RageUI.Visible(propsMenu, true)
            end
            })
            RageUI.Button("Radio", "Accéder à la radio", {RightLabel = "→"}, true, {
            onSelected = function()

            end
            }, radioMenu)
            RageUI.Button("Préférences", "Définissez vos préférences", {RightLabel = '→'}, true, {
            onSelected = function()
                
            end
            }, OptionsVisuels)
            RageUI.Button('Guide', nil, {RightLabel = "→"}, true, {
            onSelected = function()
                
            end
            }, guids)
            
            RageUI.Button('Menu ~y~VIP~s~', nil, {RightBadge = VIP.haveVip() and RageUI.BadgeStyle.Star or RageUI.BadgeStyle.Lock}, VIP.haveVip(), {
            onSelected = function()
                if not VIP.haveVip() then
                ESX.ShowNotification('~r~Vous devez avoir le VIP pour accéder à ce menu')
                return
                end
            end
            }, vipMenu)
        end)

        RageUI.IsVisible(guids, function()
            for k,v in pairs(Config.Personalmenu.guids) do
                RageUI.Button(v[1], nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = v[2]}, true, {
                    onSelected = function()
                        
                    end
                })
            end
        end)
        
        RageUI.IsVisible(vipMenu, function()
    if not VIP.haveVip() then
        RageUI.CloseAll()
        return
    end

    RageUI.Separator('~y~VIP Actif~s~')
    RageUI.Separator(('Temps restant: ~y~%s Heure(s)~s~'):format(VIP.data.time))
    RageUI.Line()

    if Config.VIP.IsFeatureEnabled('RecupererArme') then
        RageUI.Button("Récuperer l'arme", nil, {RightBadge = RageUI.BadgeStyle.Star}, true, {
            onSelected = function()
                TriggerServerEvent('sunny:vip:recieveArme', Config.VIP.GetValue('Rewards', 'WeaponName'), Config.VIP.GetValue('Rewards', 'WeaponAmmo'))
            end
        })
    end

    if Config.VIP.IsFeatureEnabled('RecupererArgent') then
        RageUI.Button("Récuperer l'argent", nil, {}, true, {
            onSelected = function()
                TriggerServerEvent('sunny:vip:recieveMoney', Config.VIP.GetValue('Rewards', 'Money'))
            end
        })
    end

    if Config.VIP.IsFeatureEnabled('SortirScooter') then 
        RageUI.Button("Sortir un scooter d'urgence", nil, {}, true, {
            onSelected = function()
                if scoot then
                    ESX.ShowNotification('~r~Vous avez déja sorti un scooter !')
                else
                    local coords = GetEntityCoords(PlayerPedId())
                    ESX.Game.SpawnVehicle(Config.VIP.GetValue('Vehicles', 'ScooterModel'), coords, 180.0, function(vehicle)
                        scoot = true
                    end)
                end
            end
        })
    end

    if Config.VIP.IsFeatureEnabled('ModeDrift') then
        RageUI.Checkbox('Mode drift', nil, driftmode, {}, {
            onChecked = function()
                driftmode = true
                TriggerEvent('sunny:drift:setMode', true)
            end,
            onUnChecked = function()
                driftmode = false
                TriggerEvent('sunny:drift:setMode', false)
            end
        })
    end

    if Config.VIP.IsFeatureEnabled('TeintesArmes') then
        local tints = Config.VIP.GetValue('Values', 'WeaponTints') or {}
        local tintName = 'Aucun'
        if type(tints) == 'table' then
            for _, tint in pairs(tints) do
                if tint.id == getWeaponTint() then
                    tintName = tint.label
                    break
                end
            end
        end
        RageUI.Button('Teinte d\'arme', nil, {RightLabel = tintName}, true, {}, selectedWeaponTint)
    end

    if Config.VIP.IsFeatureEnabled('CustomArmes') then
        RageUI.Button('Customisations d\'arme', nil, {}, true, {}, CustomMenu)
    end

    if Config.VIP.IsFeatureEnabled('AnimauxTemporaires') or Config.VIP.IsFeatureEnabled('AnimauxPermanents') then
        RageUI.Button('Animaux', nil, {RightLabel = "→"}, true, {}, selectedAnimals1)
    end

    RageUI.Button('Récupérer mon apparence', "Permet de reprendre votre personnage d'origine", {RightBadge = RageUI.BadgeStyle.Star}, true, {
        onSelected = function()
            if GetSafeZone() then
                local lastCooldown = GetGameTimer()
                if (GetGameTimer() - lastCooldown) < 10000 then
                    ESX.ShowNotification("~r~Veuillez patienter avant de pouvoir réutiliser cette fonction")
                    return
                end
                
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                    ESX.ShowNotification("~g~Vous avez récupéré votre apparence")
                    lastCooldown = GetGameTimer()
                end)
            else
                ESX.ShowNotification("~r~Vous devez être dans une SafeZone pour récupérer votre apparence")
            end
        end
    })

    if Config.VIP.IsFeatureEnabled('ChangementPed') then
        RageUI.Button('Peds', nil, {}, true, {}, openVipPeds)
    end
end)

RageUI.IsVisible(selectedWeaponTint, function()
    for i = 1, #weaponTint do 
        RageUI.Button(weaponTint[i].name, nil, {}, true, {
            onSelected = function() 
                local weaponHash = GetSelectedPedWeapon(PlayerPedId())
                if weaponHash ~= GetHashKey("WEAPON_UNARMED") then
                    SetPedWeaponTintIndex(PlayerPedId(), weaponHash, weaponTint[i].id)
                    ESX.ShowNotification("Teinte d'arme appliquée : " .. weaponTint[i].name)
                else
                    ESX.ShowNotification("Vous devez tenir une arme en main pour appliquer une teinte.")
                end
            end
        })
    end
end)

RageUI.IsVisible(selectedAnimals1, function()
    RageUI.Button('Animaux temporaire', nil, {RightLabel = "→"}, true, {
    onSelected = function()
        RageUI.Visible(petMenu, true)
    end
    }, petMenu)
end)

RageUI.IsVisible(CustomMenu, function()
    local playerPed = PlayerPedId()
    local currentWeapon = GetSelectedPedWeapon(playerPed)
    
    if currentWeapon ~= GetHashKey("WEAPON_UNARMED") then
    local weaponList = ESX.GetWeaponList()
    local selectedWeapon = nil

    for _, weapon in pairs(weaponList) do
        if GetHashKey(weapon.name) == currentWeapon then
        selectedWeapon = weapon
        break
        end
    end

    if selectedWeapon and selectedWeapon.components then
        for i, v in pairs(selectedWeapon.components) do
        local hasComponent = HasPedGotWeaponComponent(playerPed, currentWeapon, v.hash) 

        RageUI.Button(v.label, nil, { RightLabel = hasComponent and "(Equipé)" or ""}, true, {
            onSelected = function()
            if hasComponent then
                RemoveWeaponComponentFromPed(playerPed, currentWeapon, v.hash)
                ESX.ShowNotification(v.label .. ' a été retiré de votre arme')
            else
                TriggerServerEvent('tebex:on-process-checkout-weapon-custom', selectedWeapon.name, v.hash)
                ESX.ShowNotification('Vous avez acheté ' .. v.label)
                GiveWeaponComponentToPed(playerPed, currentWeapon, v.hash)
            end
            end,
        })
        end
    else
        RageUI.Separator("Aucune personnalisation disponible")
    end
    else
    RageUI.Separator("Vous n'avez pas d'arme dans vos mains")
    end
end)

RageUI.IsVisible(openVipPeds, function()
    local pedList = GetPedList() or {}
    
    if pedList and pedList.normal and type(pedList.normal) == "table" then
    for i = 1, #pedList.normal do 
        local pedIndex = i
        RageUI.Button(pedList.normal[i].label, "~b~Vous devez etre en safezone !~s~", {}, true, {
        onSelected = function()
            local healthBeforePed = GetEntityHealth(PlayerPedId())

            if healthBeforePed < 199 then
            ESX.ShowNotification("Vous devez avoir toute votre vie pour reprendre votre personnage.")
            else
            local skinModel = pedList.normal[pedIndex].model
            ChangePedModel(pedIndex, skinModel)
            end
        end
        })
    end
    else
    RageUI.Separator("~r~Aucun ped disponible")
    RageUI.Separator("Veuillez contacter un administrateur")
    end
end)

        RageUI.IsVisible(vipPlates, function()
            RageUI.Separator(("Vous avez %s plaque(s) modifier"):format(ESX.Table.SizeOf(vip_plates)))
            RageUI.Separator("Vous devez être dans un véhicule qui vous appartient")
            if ESX.Table.SizeOf(vip_plates) >= 1 then
                RageUI.Button('Voir mes plaques modifié', nil, {RightLabel = "→"}, true, {
                    onSelected = function() 
                        
                    end
                }, vipPlateGestion)
            end
            RageUI.Button('Modifier la plaque', nil, {RightLabel = "→"}, Player.isInVehicle, {
                onSelected = function()
                    local input = ESX.GetTextInput("Quelle plaque voulez-vous? (8 caractères maximum)")
                    if input == nil then
                        return ESX.ShowNotification("~r~La plaque ne peut pas être nulle")
                    end

                    if #input > 8 then
                        return ESX.ShowNotification("~r~La plaque ne doit pas dépasser 8 caractères")
                    end
                    if not IsPedSittingInAnyVehicle(Player.playerPed) then ESX.ShowNotification("Vous n'etes pas dans un véhicule !") return end
                    TriggerServerEvent("Sunny:vip:changePlate", NetworkGetNetworkIdFromEntity(Player.vehicle), input)
                end
            })
        end)

        RageUI.IsVisible(vipPlateGestion, function()
            for k,v in pairs(vip_plates) do 
                RageUI.Button(("Véhiculé N*%s | Plaque : %s"):format(k, v.plate), "Appuyer sur ENTRER réinitialisera la plaque du véhicule", {}, true, {
                    onSelected = function() 
                        TriggerServerEvent("Sunny:vip:resetPlate", k)
                    end
                })
            end
        end)
        RageUI.IsVisible(selectedWeaponTint, function()
            for i = 1, #weaponTint do 
                RageUI.Button(weaponTint[i].name, nil, {}, true, {
                    onSelected = function() 
                        local weaponHash = GetSelectedPedWeapon(PlayerPedId())
                        if weaponHash ~= GetHashKey("WEAPON_UNARMED") then
                            SetPedWeaponTintIndex(PlayerPedId(), weaponHash, weaponTint[i].id)
                            ESX.ShowNotification("Teinte d'arme appliquée : " .. weaponTint[i].name)
                        else
                            ESX.ShowNotification("Vous devez tenir une arme en main pour appliquer une teinte.")
                        end
                    end
                })
            end
        end)

        RageUI.IsVisible(selectedAnimals1, function()
            RageUI.Button('Animaux temporaire', nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    RageUI.Visible(petMenu, true)
                end
            }, petMenu)
        end)

        RageUI.IsVisible(CustomMenu, function()
            local playerPed = PlayerPedId()
            local currentWeapon = GetSelectedPedWeapon(playerPed)
            
            if currentWeapon ~= GetHashKey("WEAPON_UNARMED") then
                local weaponList = ESX.GetWeaponList()
                local selectedWeapon = nil
        
                for _, weapon in pairs(weaponList) do
                    if GetHashKey(weapon.name) == currentWeapon then
                        selectedWeapon = weapon
                        break
                    end
                end
        
                if selectedWeapon and selectedWeapon.components then
                    for i, v in pairs(selectedWeapon.components) do
                        local hasComponent = HasPedGotWeaponComponent(playerPed, currentWeapon, v.hash) 
        
                        RageUI.Button(v.label, nil, { RightLabel = hasComponent and "(Equipé)" or ""}, true, {
                            onSelected = function()
                                if hasComponent then
                                    RemoveWeaponComponentFromPed(playerPed, currentWeapon, v.hash)
                                    ESX.ShowNotification(v.label .. ' a été retiré de votre arme')
                                else
                                    TriggerServerEvent('tebex:on-process-checkout-weapon-custom', selectedWeapon.name, v.hash)
                                    ESX.ShowNotification('Vous avez acheté ' .. v.label)
                                    GiveWeaponComponentToPed(playerPed, currentWeapon, v.hash)
                                end
                            end,
                        })
                    end
                else
                    RageUI.Separator("Aucune personnalisation disponible")
                end
            else
                RageUI.Separator("Vous n'avez pas d'arme dans vos mains")
            end
        end)
        
        RageUI.IsVisible(openVipPeds, function()
            local pedList = GetPedList()
        
            for i = 1, #pedList.normal do 
                local pedIndex = i
                RageUI.Button(pedList.normal[i].label, "~b~Vous devez etre en safezone !~s~", {}, true, {
                    onSelected = function()
                        local healthBeforePed = GetEntityHealth(PlayerPedId())
        
                        if healthBeforePed < 199 then
                            ESX.ShowNotification("Vous devez avoir toute votre vie pour reprendre votre personnage.")
                        else
                            local skinModel = pedList.normal[pedIndex].model
                            ChangePedModel(pedIndex, skinModel)
                        end
                    end
                })
            end
        end)
        
        RageUI.IsVisible(territoryMenu, function()
            if territoryData then
                RageUI.Separator("Date du prochain Reset")
                local dateStr = territoryData.resetDate or "Inconnu"
                
                RageUI.Separator("Date: " .. dateStr)
                
                RageUI.Line()
                RageUI.Separator("Liste des Territoires")
                
                local sorted = {}
                for k, v in pairs(territoryData.territories) do
                    table.insert(sorted, {name = k, data = v})
                end
                table.sort(sorted, function(a,b) return (a.data.score or 0) > (b.data.score or 0) end)
                
                if #sorted == 0 then
                    RageUI.Separator("Aucun territoire actif")
                end
                
                for _, item in ipairs(sorted) do
                    local owner = item.data.name or "Aucun"
                    local score = item.data.score or 0
                    local label = string.format("~b~%s~s~ | Score: ~g~%s~s~", owner, score)
                    RageUI.Button(item.name, nil, {RightLabel = label}, true, {})
                end
            else
                RageUI.Separator("Chargement des données...")
            end
        end)

        RageUI.IsVisible(petMenu, function()
            local animalList = GetPedList()
            if VIP.entity.sorted == true then
                RageUI.Button('Rentrer mon animal', nil, {RigthBadge = RageUI.BadgeStyle.Star}, true, {
                    onSelected = function()
                        TriggerEvent('sunny:vip:animals:remove')
                    end
                })
                RageUI.Button('Demander de s\'asseoir', nil, {RigthBadge = RageUI.BadgeStyle.Star}, not VIP.entity.sitting, {
                    onSelected = function()
                        local entity = VIP.entity.entityid -- Utiliser l'entité de l'animal
                        local entityCoords = GetEntityCoords(entity)
        
                        local dist = #(GetEntityCoords(PlayerPedId()) - entityCoords)
        
                        if dist > 10 then
                            ESX.ShowNotification('🐕 Votre animal est trop éloigné de vous')
                            return
                        end
        
                        if not VIP.entity.sitting then
                            loadDict("creatures@rottweiler@amb@world_dog_sitting@base")
                            TaskPlayAnim(entity, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 8.0, -8, -1, 1, 0, false, false, false)
                            VIP.entity.sitting = true
                        else
                            ClearPedTasks(entity)
                            VIP.entity.sitting = false
                        end
                    end
                })
                if VIP.entity.sitting then
                    RageUI.Button('Demander de lever', nil, {RigthBadge = RageUI.BadgeStyle.Star}, VIP.entity.sitting, {
                        onSelected = function()
                            local entity = VIP.entity.entityid -- Utiliser l'entité de l'animal
                            local entityCoords = GetEntityCoords(entity)
        
                            local dist = #(GetEntityCoords(PlayerPedId()) - entityCoords)
        
                            if dist > 3 then
                                ESX.ShowNotification('🐕 Votre animal est trop éloigné de vous')
                                return
                            end
        
                            ClearPedTasks(entity)
                            VIP.entity.sitting = false
                        end
                    })
                end
        
                RageUI.Button('Demander de me suivre', nil, {RigthBadge = RageUI.BadgeStyle.Star}, not VIP.entity.followMe, {
                    onSelected = function()
                        local entity = VIP.entity.entityid -- Utiliser l'entité de l'animal
                        local entityCoords = GetEntityCoords(entity)
        
                        local dist = #(GetEntityCoords(PlayerPedId()) - entityCoords)
        
                        if dist > 10 then
                            ESX.ShowNotification('🐕 Votre animal est trop éloigné de vous')
                            return
                        end
        
                        TriggerEvent('sunny:vip:animals:followMe')
                    end
                })
                if VIP.entity.followMe == true then
                    RageUI.Button('Demander d\'arrêter me suivre', nil, {RigthBadge = RageUI.BadgeStyle.Star}, VIP.entity.followMe, {
                        onSelected = function()
                            VIP.entity.followMe = false
        
                            SetTimeout(2000, function()
                                local entity = VIP.entity.entityid -- Utiliser l'entité de l'animal
        
                                loadDict("creatures@rottweiler@amb@world_dog_sitting@base")
                                TaskPlayAnim(entity, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 8.0, -8, -1, 1, 0, false, false, false)
                                VIP.entity.sitting = true
                            end)
                        end
                    })
                end
                RageUI.Button('Donner un nom à mon animal', nil, {RigthBadge = RageUI.BadgeStyle.Star}, VIP.entity.nameActive == false, {
                    onSelected = function()
                        KeyboardUtils.use('Nom de l\'animal', function(data)
                            if data == nil or data == '' then return end
        
                            TriggerServerEvent('sunny:vip:animals:setName', VIP.entity.entityid, data)
        
                            VIP.entity.nameActive = true
                        end)
                    end
                })
                if VIP.entity.nameActive ~= false then
                    RageUI.Button('Changer le nom de mon animal', nil, {RigthBadge = RageUI.BadgeStyle.Star}, true, {
                        onSelected = function()
                            KeyboardUtils.use('Nouveau nom', function(data)
                                if data == nil or data == '' then return end
        
                                TriggerServerEvent('sunny:vip:animals:editName', VIP.entity.entityid, data)
                            end)
                        end
                    })
                    RageUI.Button('Retirer le nom de mon animal', nil, {Color = {BackgroundColor = {255,0,0,100}}}, true, {
                        onSelected = function()
                            TriggerServerEvent('sunny:vip:animals:removeName', VIP.entity.entityid)
                            VIP.entity.nameActive = false
                        end
                    })
                end
                RageUI.Line()
            end
            for k,v in ipairs(animalList.animals) do
                RageUI.Button(('%s (%s)'):format(v.label, v.model), nil, {RightLabel = ''}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName,
                            'Voulez-vous sortir votre animal ?',
                            '',
                            function(response)
                                if response then -- Oui
                                    if VIP.entity.sorted == true then
                                        ESX.ShowNotification('🐕 Vous avez déjà un animal de sorti')
                                    else
                                        TriggerServerEvent('sunny:ips:animals:createPed', GetEntityCoords(PlayerPedId()), v.model)
                                    end
                                else -- Non
                                    ESX.ShowNotification("Action annulée")
                                end
                            end
                        )
                    end
                })
                
            end
        end)

        -- ANIMAUX PERMA
        local adoptionData = {prenom = nil, model = nil} -- Stockage temporaire sécurisé

        local hasAnimal = false -- Stocke si le joueur a déjà un animal

        local hasAnimal = false -- Stocke si le joueur a déjà un animal

-- Fonction pour vérifier si le joueur possède déjà un animal
function checkIfPlayerHasAnimal()
    ESX.TriggerServerCallback('sunny:vip:animals:hasAnimal', function(result)
        hasAnimal = result
        print("DEBUG CLIENT: Le joueur a un animal ? -> " .. tostring(hasAnimal))
    end)
end

-- Fonction pour faire spawn l'animal adopté
function spawnAdoptedAnimal(model)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    -- Charger le modèle de l'animal
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(500)
    end

    -- Créer l'animal à côté du joueur
    local animal = CreatePed(28, model, playerCoords.x + 1.5, playerCoords.y, playerCoords.z, 0.0, true, false)
    SetEntityAsMissionEntity(animal, true, true)
    TaskFollowToOffsetOfEntity(animal, playerPed, 1.0, 1.0, 0.0, 1.0, -1, 0.5, true)
    ESX.ShowNotification("🐾 Votre animal vous suit maintenant !")
end



-- Vérification lorsque le menu principal s'ouvre
RageUI.IsVisible(permanentAnimalsMenu, function()
    -- Bouton pour adopter un animal
    RageUI.Button('Adopter un animal de compagnie', nil, {RightLabel = "→"}, not hasAnimal, {
        onSelected = function()
            if not hasAnimal then
                KeyboardUtils.use('Entrez le prénom de votre animal', function(data)
                    if data and data ~= "" then
                        adoptionData.prenom = data
                        print("DEBUG CLIENT: Prénom enregistré -> " .. tostring(adoptionData.prenom))

                        -- Envoi immédiat du prénom au serveur
                        TriggerServerEvent('sunny:vip:animals:saveName', adoptionData.prenom)

                        -- Ouvre le menu de sélection après stockage
                        ESX.SetTimeout(100, function()
                            RageUI.Visible(animalAdoptMenu, true)
                        end)
                    else
                        ESX.ShowNotification("🐾 Vous devez entrer un prénom valide.")
                    end
                end)
            end
        end
    })

    -- Bouton toujours visible pour gérer son animal
    RageUI.Button('Gestion de mon animal de compagnie', nil, {RightLabel = "→"}, true, {
        onSelected = function()
            RageUI.Visible(manageAnimalMenu, true)
        end
    })
end)

-- Sous-menu pour gérer son animal (les données sont appelées DIRECTEMENT ici)
RageUI.IsVisible(manageAnimalMenu, function()
    if not RageUI.Visible(manageAnimalMenu) then
        return -- Empêche l'exécution si le menu n'est pas visible
    end

    -- Appelle le serveur une seule fois et garde les données
    ESX.TriggerServerCallback('sunny:vip:animals:getAnimalData', function(prenom, model)
        -- Sécurisation des valeurs
        prenom = prenom or "Aucun nom"
        model = model or "Aucun modèle"

        -- Affichage unique des informations sans rafraîchissement excessif
        RageUI.Separator("📋 Informations de votre animal")
        RageUI.Separator("🐾 Nom : ~y~" .. prenom)
        RageUI.Separator("📌 Modèle : ~y~" .. model)

        print("DEBUG CLIENT: Prénom -> " .. prenom .. " | Modèle -> " .. model)
    end)
end)




-- Sous-menu : Choisir le type d’animal (Chien ou Chat)
RageUI.IsVisible(animalAdoptMenu, function()
    RageUI.Separator("🐶 Sélectionnez votre compagnon 🐱")

    if adoptionData.prenom then
        RageUI.Separator("🐾 Nom choisi : ~y~" .. adoptionData.prenom)
    else
        RageUI.Separator("❌ ~r~Erreur: Prénom non enregistré")
    end

    -- Option pour adopter un chien
    RageUI.Button('Adopter un Chien', nil, {RightLabel = "🐶"}, true, {
        onSelected = function()
            adoptionData.model = "a_c_rottweiler"
            print("DEBUG CLIENT: Envoi au serveur -> Prénom: " .. tostring(adoptionData.prenom) .. " | Modèle: " .. tostring(adoptionData.model))
            TriggerServerEvent('sunny:vip:animals:updateModel', adoptionData.model)

            ESX.ShowNotification("🐶 Félicitations ! Vous avez adopté un Chien !")
            spawnAdoptedAnimal(adoptionData.model) -- Spawn l'animal après adoption
        end
    })

    -- Option pour adopter un chat
    RageUI.Button('Adopter un Chat', nil, {RightLabel = "🐱"}, true, {
        onSelected = function()
            adoptionData.model = "a_c_cat_01"
            print("DEBUG CLIENT: Envoi au serveur -> Prénom: " .. tostring(adoptionData.prenom) .. " | Modèle: " .. tostring(adoptionData.model))
            TriggerServerEvent('sunny:vip:animals:updateModel', adoptionData.model)

            ESX.ShowNotification("🐱 Félicitations ! Vous avez adopté un Chat !")
            spawnAdoptedAnimal(adoptionData.model) -- Spawn l'animal après adoption
        end
    })
end)



        


        RageUI.IsVisible(clothesMenu, function()
            for k,v in pairs(
                {{ name = "Tenue", ask = '' },
                { name = "Torse", ask = ''},
                { name = "T-Shirt", ask = ''},
                { name = "Bras", ask = ''},
                { name = "Pantalons", ask = ''},
                { name = "Chaussures", ask = ''},
                { name = "Masque", ask = ''},
                { name = "Gillet par balles", ask = ''},
                { name = "Chaine", ask = ''},
                { name = "Chapeau", ask = ''},
                { name = "Lunettes", ask = ''},
                { name = "Montres", ask = ''},
                { name = "Bracelets", ask = ''},
                { name = "Sacs", ask = ''},}
            ) do
                RageUI.Button(v.name, nil, {RightLabel = v.ask}, true, {
                    onSelected = function()
                        RageUI.Visible(clothesMenu2, true)
                    end
                })
            end
        end)

        RageUI.IsVisible(clothesMenu2, function()
            
        end)

        RageUI.IsVisible(propsMenu, function()
            for k,v in pairs(propsPropsList) do
                local label = v.label or v.name or "Objet inconnu"
                RageUI.Button(label, nil, {RightLabel = 'x'..v.count}, true, {
                    onActive = function()
                        -- if DoesEntityExist(previewPropMenu) and GetHashKey(GetEntityModel(previewPropMenu)) ~= v.name or not DoesEntityExist(previewPropMenu) then
                        --     DeleteEntity(previewPropMenu)
                            
                        --     local coords, forward = Player.coords, GetEntityForwardVector(Player.playerPed)
                        --     local objectCoords = (coords + forward * 3.0)
        
                        --     ESX.Streaming.RequestModel(v.name)
                        --     previewPropMenu = CreateObjectNoOffset(v.name, objectCoords.x, objectCoords.y, objectCoords.z, false, false, false)
                        --     SetModelAsNoLongerNeeded(v.nale)
                        --     SetEntityCollision(previewPropMenu, false, false)
                        --     SetCanClimbOnEntity(previewPropMenu, false)
                        --     FreezeEntityPosition(previewPropMenu, true)
                        -- else

                        -- end
                    end,
                    onSelected = function()
                        TriggerEvent('sunny:props:place', v)
                    end
                })
            end
        end)

        RageUI.IsVisible(Portefeuille, function()
    local player, closestplayer = ESX.Game.GetClosestPlayer()
    local cashAmount = ESX.PlayerData.money
    local bankAmount = 0
    local blackMoneyAmount = 0

   RageUI.Separator('Information Compte')

   for i = 1, #ESX.PlayerData.accounts, 1 do
    if ESX.PlayerData.accounts[i].name == 'bank' then
        RageUI.Button('Argent en Banque: ~b~'..ESX.PlayerData.accounts[i].money.."$", nil, { RightLabel = "→" }, true, {})
    end
end

for i = 1, #ESX.PlayerData.accounts, 1 do
    if ESX.PlayerData.accounts[i].name == 'cash' then
        RageUI.Button('Argent en Liquide: ~g~'..ESX.PlayerData.accounts[i].money.."$", nil, { RightLabel = "→" }, true, {
            onActive = function()
                --local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
               -- if closestDistance ~= -1 and closestDistance <= 3 then
                --    PlayerMakrer(closestPlayer)
              --  end
            end
        })
    end
end

for i = 1, #ESX.PlayerData.accounts, 1 do
    if ESX.PlayerData.accounts[i].name == 'black_money' then
        RageUI.Button('Argent Sale: ~r~'..ESX.PlayerData.accounts[i].money.."$", nil, { RightLabel = "→" }, true, {
            onActive = function()
               -- local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
             --   if closestDistance ~= -1 and closestDistance <= 3 then
               --     PlayerMakrer(closestPlayer)
              --  end
            end
        })
    end
end

for i = 1, #ESX.PlayerData.accounts, 1 do
    if ESX.PlayerData.accounts[i].name == 'pesos' then
        RageUI.Button('Peso: ~y~'..ESX.PlayerData.accounts[i].money.."P", nil, { RightLabel = "→" }, true, {
            onActive = function()
               -- local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
             --   if closestDistance ~= -1 and closestDistance <= 3 then
               --     PlayerMakrer(closestPlayer)
              --  end
            end
        })
    end
end

            RageUI.Button('Factures', nil, {RightLabel = ''}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('esx_billing:getBills', function(cb)
                        facturessss = cb
                        RageUI.Visible(factures, true)
                    end)
                end
            })
            RageUI.Button("Quitter son Emploie", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Confirmez votre démission',
                        '',
                        function(response)
                            if response then -- Oui
                                TriggerServerEvent("Sunny:job:leave")
                                ESX.ShowNotification("~r~Vous avez quitter votre Job")
                            else -- Non
                                ESX.ShowNotification("Vous n'avez pas quitter votre job") 
                            end
                        end
                    )
                end
            })

            RageUI.Button("Quitter son Groupe", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Confirmez votre démission', 
                        '',
                        function(response)
                            if response then -- Oui
                                TriggerServerEvent("Sunny:job2:leave")
                                ESX.ShowNotification("~r~Vous avez quitter votre Groupe")
                            else -- Non 
                                ESX.ShowNotification("Vous n'avez pas quitter votre Groupe")
                            end
                        end
                    )
                end
            })


            RageUI.Separator("Information Personnelles")
            local playerLevel = getCurrentXpLevel()
            RageUI.Button('Niveau', nil, {RightLabel = ("~y~%s"):format(playerLevel)}, true, {
                onSelected = function()
                end
            })
            
            RageUI.Button('Nom Complet ', nil, {RightLabel = ESX.PlayerData.firstname.." "..ESX.PlayerData.lastname}, true, {
                onSelected = function()
                end
            })
            
            RageUI.Button("Gestion License", nil, {RightLabel = '→'}, true, {}, gestionlicense)
                                     
            RageUI.Button("Information Métier", "Accéder aux information de votre métier", {RightLabel = "→"}, true, {onSelected = function() end}, infojob)

            RageUI.Button("Information Organisation", "Accéder aux information de votre organisation", {RightLabel = "→"}, true, {onSelected = function() end}, infojob2)

        end)

        RageUI.IsVisible(infojob, function()
            ESX.PlayerData = ESX.GetPlayerData()

            RageUI.Button("Votre Métier :", nil, {RightLabel = SunnyConfigServ.GTACOLOR..""..ESX.PlayerData.job.label}, true, {})
            RageUI.Button("Votre Grade :", nil, {RightLabel = SunnyConfigServ.GTACOLOR..""..ESX.PlayerData.job.grade_label}, true, {})
        end)


        RageUI.IsVisible(infojob2, function()
            RageUI.Button("Votre Organisation :", nil, {RightLabel = SunnyConfigServ.GTACOLOR..""..ESX.PlayerData.job2.label}, true, {})
            RageUI.Button("Votre Rang :", nil, {RightLabel = SunnyConfigServ.GTACOLOR..""..ESX.PlayerData.job2.grade_label}, true, {})
        end)

        RageUI.IsVisible(factures, function()
            for k,v in pairs(facturessss) do
                RageUI.Button(v.label, nil, {RightLabel = v.amount}, true, {
                    onSelected = function()
                        v.target = string.gsub(v.target, 'society_', '')

                        TriggerServerEvent('sunny:bill:pay', v)

                        RageUI.GoBack()
                    end
                })
            end
        end)
        RageUI.IsVisible(gestionlicense, function()
            
                    RageUI.Info(SunnyConfigServ.GTACOLOR.."Informations License", {"Pour obtenir votre carte d'intentité dans votre inventaire veuillez", "vous rendre a la ~p~Préfécture ~w~!"}, 
                                                    {})
            RageUI.Separator(('%s↓ Permis de pêche ↓~s~'):format(UTILS.COLORCODE))
            RageUI.Button('Regarder', nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'fishing')
                end
            })
            RageUI.Button('Montrer', nil, {}, true, {
                onSelected = function()
                    if distance == -1 or distance > 3  then return ESX.ShowNotification('Personne aux alentours') end

                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'fishing')
                end
            })
            RageUI.Separator(('%s↓ Permis de conduire ↓~s~'):format(UTILS.COLORCODE))
            RageUI.Button('Regarder', nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                end
            })
            RageUI.Button('Montrer', nil, {}, true, {
                onSelected = function()
                    if distance == -1 or distance > 3  then return ESX.ShowNotification('Personne aux alentours') end

                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
                end
            })
            RageUI.Separator(('%s↓ Permis de Port D\'arme ↓~s~'):format(UTILS.COLORCODE))
            RageUI.Button('Regarder', nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
                end
            })
            RageUI.Button('Montrer', nil, {}, true, {
                onSelected = function()
                    if distance == -1 or distance > 3  then return ESX.ShowNotification('Personne aux alentours') end

                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
                end
            })
    
            end, function()
            end)
        RageUI.IsVisible(VehicleOption, function()
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            
            local pVeh = GetVehiclePedIsUsing(Player.playerPed)

            local vModel = GetEntityModel(pVeh)
            if IsPedInAnyVehicle(Player.playerPed, true) then 
                local vPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(Player.playerPed), false)
                local vName = GetDisplayNameFromVehicleModel(vModel) --Avoir le nom du véhicule
                local Essence = GetVehicleFuelLevel(pVeh)
                RageUI.Separator('[Plaque]   '..vPlate ..'')
                RageUI.Separator('[Modèle]   '..vName..'')
                RageUI.Separator('[Essence]   '..ESX.Math.Round(Essence, 0)..'%')
                SetPlayerCanDoDriveBy(Player.playerId, false)
            else
                RageUI.Separator('[Plaque]   '.."Non défini" ..'')
                RageUI.Separator('[Modèle]   '.."Non défini"..'')
                RageUI.Separator('[Essence]   '.."Non défini"..'')
                RageUI.Separator('[Moteur]    '.."Non défini")
            end
            RageUI.Button("Allumer / Eteindre le moteur", nil, {RightLabel = Config.Personalmenu.Statut}, true, {
                onSelected = function()
                    if GetIsVehicleEngineRunning(vehicle) then
                        Config.Personalmenu.Statut = "~r~Eteint"

                        SetVehicleEngineOn(vehicle, false, false, true)
                        SetVehicleUndriveable(vehicle, true)
                    elseif not GetIsVehicleEngineRunning(vehicle) then
                        Config.Personalmenu.Statut = "~g~Allumé"

                        SetVehicleEngineOn(vehicle, true, false, true)
                        SetVehicleUndriveable(vehicle, false)
                    end
                end
            })

            RageUI.List("Ouvrir / Fermer porte", {"Avant gauche", "Avant Droite", "Arrière Gauche", "Arrière Droite", "Capot", "Coffre"}, Config.Personalmenu.Indexdoor, nil, {}, true, {
                onListChange = function(index)
                    Config.Personalmenu.Indexdoor = index 
                end,
                onSelected = function(index)
                    
                    if index == 1 then
                        if not Config.Personalmenu.DoorState.FrontLeft then
                            Config.Personalmenu.DoorState.FrontLeft = true
                            SetVehicleDoorOpen(vehicle, 0, false, false)
                        elseif Config.Personalmenu.DoorState.FrontLeft then
                            Config.Personalmenu.DoorState.FrontLeft = false
                            SetVehicleDoorShut(vehicle, 0, false, false)
                        end
                    elseif index == 2 then
                        if not Config.Personalmenu.DoorState.FrontRight then
                            Config.Personalmenu.DoorState.FrontRight = true
                            SetVehicleDoorOpen(vehicle, 1, false, false)
                        elseif Config.Personalmenu.DoorState.FrontRight then
                            Config.Personalmenu.DoorState.FrontRight = false
                            SetVehicleDoorShut(vehicle, 1, false, false)
                        end
                    elseif index == 3 then
                        if not Config.Personalmenu.DoorState.BackLeft then
                            Config.Personalmenu.DoorState.BackLeft = true
                            SetVehicleDoorOpen(vehicle, 2, false, false)
                        elseif Config.Personalmenu.DoorState.BackLeft then
                            Config.Personalmenu.DoorState.BackLeft = false
                            SetVehicleDoorShut(vehicle, 2, false, false)
                        end
                    elseif index == 4 then
                        if not Config.Personalmenu.DoorState.BackRight then
                            Config.Personalmenu.DoorState.BackRight = true
                            SetVehicleDoorOpen(vehicle, 3, false, false)
                        elseif Config.Personalmenu.DoorState.BackRight then
                            Config.Personalmenu.DoorState.BackRight = false
                            SetVehicleDoorShut(vehicle, 3, false, false)
                        end
                    elseif index == 5 then 
                        if not Config.Personalmenu.DoorState.Hood then
                            Config.Personalmenu.DoorState.Hood = true
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        elseif Config.Personalmenu.DoorState.Hood then
                            Config.Personalmenu.DoorState.Hood = false
                            SetVehicleDoorShut(vehicle, 4, false, false)
                        end
                    elseif index == 6 then 
                        if not Config.Personalmenu.DoorState.Trunk then
                            Config.Personalmenu.DoorState.Trunk = true
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        elseif Config.Personalmenu.DoorState.Trunk then
                            Config.Personalmenu.DoorState.Trunk = false
                            SetVehicleDoorShut(vehicle, 5, false, false)
                        end
                    end
                end
            })

            RageUI.Button("Fermer toutes les portes", nil, {RightLabel =  ''}, true, {
                onSelected = function ()
                    for door = 0, 7 do
                        SetVehicleDoorShut(vehicle, door, false)
                    end
                end
            })
            RageUI.Button("Ouvrir la radio", nil, {RightLabel =  ''}, true, {
                onSelected = function ()
                    ExecuteCommand("carplay")
                end
            })
            if not isintestdrive then
             RageUI.List("Limitateur", Config.Personalmenu.voiture_limite, Config.Personalmenu.LimitateurIndex, nil, {}, true, {
                 onListChange = function(i, item)
                     Config.Personalmenu.LimitateurIndex = i
                 end,

                 onSelected = function(i, item)
                     if i == 1 then
                         SetEntityMaxSpeed(GetVehiclePedIsIn(Player.playerPed, false), 50.0/3.6)
                         ESX.ShowNotification("Limitateur de vitesse défini sur ~p~50 km/h")
                     elseif i == 2 then  
                         SetEntityMaxSpeed(GetVehiclePedIsIn(Player.playerPed, false), 80.0/3.6)
                         ESX.ShowNotification("Limitateur de vitesse défini sur ~p~80 km/h")
                     elseif i == 3  then
                         SetEntityMaxSpeed(GetVehiclePedIsIn(Player.playerPed, false), 130.0/3.6)
                         ESX.ShowNotification("Limitateur de vitesse défini sur ~p~130 km/h")
                     elseif i == 4 then
                         KeyboardUtils.use('Indiquer la viteese', function(speed)
                             if speed ~= nil or speed ~= tostring("") then 
                                 SetEntityMaxSpeed(GetVehiclePedIsIn(Player.playerPed, false), ESX.Math.Round(speed, 1)/3.6)
                                 ESX.ShowNotification("Limitateur de vitesse défini sur ~p~"..speed..'km/h')
                             else
                                 return
                             end
                         end)
                     elseif i == 5 then 
                         SetEntityMaxSpeed(GetVehiclePedIsIn(Player.playerPed, false), 10000.0/3.6)    
                         ESX.ShowNotification("Limitateur de vitesse désactivé")
                     end
                 end
             })
            end
        end)

        RageUI.IsVisible(EntrepriseOption, function()
            RageUI.Button('Argent de la société: '..Society.List[ESX.PlayerData.job.name].coffre['accounts'].society, nil, {}, true, {
                onSelected = function()
                end
            })
            RageUI.Button("Recruter un employé", nil, {RightLabel = ''}, true, {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        TriggerServerEvent("sunny:entreprise:Boss_recruterplayer", GetPlayerServerId(closestPlayer), ESX.PlayerData.job.name)
                    else
                        ESX.ShowNotification("Aucun joueur à proximité")
                    end
                end
            })

            RageUI.Button("Virer un employé", nil, {RightLabel = ''}, true, {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        TriggerServerEvent("sunny:entreprise:Boss_virerplayer", GetPlayerServerId(closestPlayer))
                    else
                        ESX.ShowNotification("Aucun joueur à proximité")
                    end
                end
            })

            RageUI.Button("Promouvroir un employé", nil, {RightLabel = ''}, true, {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        TriggerServerEvent("sunny:entreprise:Boss_promouvoirplayer", GetPlayerServerId(closestPlayer))
                    else
                        ESX.ShowNotification("Aucun joueur à proximité")
                    end
                end
            })

            RageUI.Button("Rétrograder un employé", nil, {RightLabel = ''}, true, {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        TriggerServerEvent("sunny:entreprise:Boss_destituerplayer", GetPlayerServerId(closestPlayer))
                    else
                        ESX.ShowNotification("Aucun joueur à proximité")
                    end
                end
            })
        end)
        RageUI.IsVisible(OpenReportFast, function()
            RageUI.Button("Signalé un FreeKill", nil, {RightLabel = "⚠️"}, true, {
                onSelected = function()
                    ExecuteCommand("report J'ai besoin d'aide par apport à une FreeKill")
                end
            })
            RageUI.Button("Signalé un FreePunch", nil, {RightLabel = "⚠️"}, true, {
                onSelected = function()
                    ExecuteCommand("report J'ai besoin d'aide par apport à une FreePunch")
                end
            })
            RageUI.Button("Signalé un FreeTaze", nil, {RightLabel = "⚠️"}, true, {
                onSelected = function()
                    ExecuteCommand("report J'ai besoin d'aide par apport à une FreeTaze")
                end
            })
            RageUI.Button("Signalé un MassRP", nil, {RightLabel = "⚠️"}, true, {
                onSelected = function()
                    ExecuteCommand("report J'ai besoin d'aide par apport à un MassRP")
                end
            })
            RageUI.Button("Signalé un PowerGaming", nil, {RightLabel = "⚠️"}, true, {
                onSelected = function()
                    ExecuteCommand("report J'ai besoin d'aide par apport à un PowerGaming")
                end
            })
            RageUI.Button("Signalé un MetaGaming", nil, {RightLabel = "⚠️"}, true, {
                onSelected = function()
                    ExecuteCommand("report J'ai besoin d'aide par apport à un MetaGaming")
                end
            })
            RageUI.Button("Signalé un FreeLoot", nil, {RightLabel = "⚠️"}, true, {
                onSelected = function()
                    ExecuteCommand("report J'ai besoin d'aide par apport à un FreeLoot")
                end
            })
            RageUI.Button("Demander une aide général", nil, {RightLabel = "⚠️"}, true, {
                onSelected = function()
                    ExecuteCommand("report J'ai besoin d'aide s'il vous plait !")
                end
            })

        end)
        RageUI.IsVisible(OptionsVisuels, function()
            if HasKevlar() then
                RageUI.Button('Déséquiper mon Kevlar', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        TriggerServerEvent('sunny:RemoveKevlar')
                    end
                })
                RageUI.Line()
            end
            RageUI.Button('Affichage', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                end
            }, visualconfig)
            RageUI.Button('Véhicules', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                end
            }, carconfig)
            RageUI.Button('Combat', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                end
            }, FightModif)
            RageUI.Button("Signalement Rapide", nil, {RightLabel = '→'}, true, {
                onSelected = function()
                
                end
            }, OpenReportFast)
            RageUI.Button('Démarche', nil, {RightLabel = getWalkStyle()..'→'}, true, {
                onSelected = function()
                end
            }, walksList)
            for _,z in ipairs(Config.Personalmenu.preferData) do
                v = Config.Personalmenu.preferences[z.name]
                if v.type == 'checkbox' then
                    RageUI.Checkbox(v.label, v.desc, v.active, {}, {
                        onChecked = function()
                            v.action(true)

                            v.active = true

                            TriggerServerEvent('sunny:preferences:add', z.name)
                        end,
                        onUnChecked = function()
                            v.action(false)

                            v.active = false

                            TriggerServerEvent('sunny:preferences:remove', z.name)
                        end
                    })
                elseif v.type == "menu" then
                    RageUI.Button(v.label, v.desc, {RightLabel = '→'}, true, {
                        onSelected = function()
                            v.action()
                        end
                    })
                end
            end
            
                RageUI.Button('Mode vente de Drogue', "Activer/Desactiver le mode vente de drogue", {}, true, {
                    onSelected = function()
                        if Config.Personalmenu.blackListedRole[ESX.GetPlayerData().job.name] then return ESX.ShowNotification('~r~Vous ne pouvez pas vendre de la drogue en étant dans une entreprise public~s~') end

                        ExecuteCommand('drogue')
                    end
                })

                local showTerritoriesState = exports['nv_drugs']:GetCitizenTerritoriesState() or false

                RageUI.Checkbox('Afficher les territoires sur la carte', "Voir les zones de gang sur la carte", showTerritoriesState, {}, {
                    onChecked = function()
                        exports['nv_drugs']:ToggleCitizenTerritories(true)
                        ESX.ShowNotification('~g~Affichage des territoires activé')
                    end,
                    onUnChecked = function()
                        exports['nv_drugs']:ToggleCitizenTerritories(false)
                        ESX.ShowNotification('~r~Affichage des territoires désactivé')
                    end,
                    onSelected = function(Index)
                    end
                })

                local areCrosseHitsDisabled = false
                local isDrugSaleModeActive = false

                RageUI.Checkbox('Désactiver les coups de crosse', "Activer/Désactiver les coups de crosse", areCrosseHitsDisabled, {}, {
                    onChecked = function()
                        areCrosseHitsDisabled = true
                        DisableCrosseHits()
                        ESX.ShowNotification('~g~Les coups de crosse ont été désactivés.')
                    end,
                    onUnChecked = function()
                        areCrosseHitsDisabled = false
                        EnableCrosseHits()
                        ESX.ShowNotification('~r~Les coups de crosse ont été activés.')
                    end,
                    onSelected = function(Index)
                    end
                })                
        end)

function DisableCrosseHits()
    areCrosseHitsDisabled = true
    Citizen.CreateThread(function()
        while areCrosseHitsDisabled do
            Citizen.Wait(0)
            DisableControlAction(0, 140, true) -- Désactiver coup de crosse (R)
            DisableControlAction(0, 141, true) -- Désactiver attaque secondaire
            DisableControlAction(0, 142, true) -- Désactiver autres attaques
        end
    end)
end

function EnableCrosseHits()
    areCrosseHitsDisabled = false
end

        RageUI.IsVisible(walksList, function()
            for k,v in pairs(Config.Personalmenu.WalkStyle) do 
                RageUI.Button(('%s'):format(k), nil, {}, true, {
                    onSelected = function()
                        RageUI.GoBack()
                        setNewWalkStyle(k)
                        Wait(150)
                        StartWykzWalkezjdhajzehdaz()
                    end
                })
            end
        end)
            RageUI.IsVisible(visualconfig, function()
                --RageUI.Button("Notifications", nil, {RightLabel = "→"}, true, {
                --    onSelected = function()
    
                --    end
                --}, Notifmeny)
                -- if SunnyConfigServ.RageUI.IgEdit == true then
                -- RageUI.Button("Modifications Menu", nil, {RightLabel = "→"}, true, {
                --     onSelected = function()
    
                --     end
                -- }, ModifMenu)
                -- end
                RageUI.Button("Optimisation", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
    
                    end
                }, OptiMenu)
                RageUI.Button("Voir mon Niveau", nil, {RightLabel = ''}, true, {
                    onSelected = function()
                        ExecuteCommand('XpStats')
                    end
                })
                -- RageUI.Button("Modifier HUD", nil, {RightLabel = ''}, true, {
                --     onSelected = function()
                --         ExecuteCommand('hudsettings')
                --         RageUI.CloseAll()
                --     end
                -- })
                RageUI.Checkbox("Afficher / Désactiver la map", nil, menumap, {RighLabel = ""}, { 
                        onChecked = function()
                            menumap = true
                            DisplayRadar(true)
                        end,
                        onUnChecked = function()
                            menumap = false
                            DisplayRadar(false)
                        end
                    })
                RageUI.Checkbox("Afficher / Désactiver le HUD", nil, isHudDisabled, {RighLabel = ""}, { 
                        onChecked = function()
                            isHudDisabled = true
                            DisplayHud(false)
                            TriggerEvent('hud:hide')
                            TriggerEvent("lyozz::Hud::StateHud", false)
                            TriggerEvent("lyozz:Hud:StateStatus", false)
                            pcall(function() exports.zhud:toggle(false) end)
                            pcall(function() exports.core_nui:SetHudVisible(false) end)
                            pcall(function() exports.hud:ToggleVisible(false) end)
                        end,
                        onUnChecked = function()
                            isHudDisabled = false
                            DisplayHud(true)
                            TriggerEvent('hud:show')
                            TriggerEvent("lyozz::Hud::StateHud", true)
                            TriggerEvent("lyozz:Hud:StateStatus", true)
                            pcall(function() exports.zhud:toggle(true) end)
                            pcall(function() exports.core_nui:SetHudVisible(true) end)
                            pcall(function() exports.hud:ToggleVisible(true) end)
                        end
                    })
                RageUI.Checkbox('Mode cinématique', nil, cinemamode, {}, {
                    onChecked = function()
                        cinemamode = true
                        ExecuteCommand('noir')
                    end,
                    onUnChecked = function()
                        cinemamode = false
                        ExecuteCommand('noir')
                    end,
                })
                RageUI.Button("Rockstar Editor", nil, {RightLabel = ''}, true, {
                    onSelected = function()
                        ExecuteCommand('rec')
                    end
                })
             end)

             RageUI.IsVisible(ModifMenu, function()
                RageUI.Checkbox("Banniere du Menu", nil, SunnyConfigServ.RageUI.Header, {RighLabel = ""}, { 
                    onChecked = function()
                        SunnyConfigServ.RageUI.Header = true
                    end,
                    onUnChecked = function()
                        SunnyConfigServ.RageUI.Header = false
                    end
                })
                RageUI.Checkbox("Globe du Menu", nil, SunnyConfigServ.RageUI.Glare, {RighLabel = ""}, { 
                    onChecked = function()
                        SunnyConfigServ.RageUI.Glare = true
                    end,
                    onUnChecked = function()
                        SunnyConfigServ.RageUI.Glare = false
                    end
                })
                RageUI.Checkbox("Sous-Titre du Menu", nil, SunnyConfigServ.RageUI.Subtitle, {RighLabel = ""}, { 
                    onChecked = function()
                        SunnyConfigServ.RageUI.Subtitle = true
                    end,
                    onUnChecked = function()
                        SunnyConfigServ.RageUI.Subtitle = false
                    end
                })
                RageUI.Checkbox("Background du Menu", nil, SunnyConfigServ.RageUI.Background, {RighLabel = ""}, { 
                    onChecked = function()
                        SunnyConfigServ.RageUI.Background = true
                    end,
                    onUnChecked = function()
                        SunnyConfigServ.RageUI.Background = false
                    end
                })
                RageUI.Checkbox("Navigation du Menu", nil, SunnyConfigServ.RageUI.Navigation, {RighLabel = ""}, { 
                    onChecked = function()
                        SunnyConfigServ.RageUI.Navigation = true
                    end,
                    onUnChecked = function()
                        SunnyConfigServ.RageUI.Navigation = false
                    end
                })
                RageUI.Checkbox("Instruction du Menu", nil, SunnyConfigServ.RageUI.InstructionalButton, {RighLabel = ""}, { 
                    onChecked = function()
                        SunnyConfigServ.RageUI.InstructionalButton = true
                    end,
                    onUnChecked = function()
                        SunnyConfigServ.RageUI.InstructionalButton = false
                    end
                })
                RageUI.Checkbox("Page du Menu", nil, SunnyConfigServ.RageUI.PageCounter, {RighLabel = ""}, { 
                    onChecked = function()
                        SunnyConfigServ.RageUI.PageCounter = true
                    end,
                    onUnChecked = function()
                        SunnyConfigServ.RageUI.PageCounter = false
                    end
                })
             end)

             RageUI.IsVisible(Notifmeny, function()

                RageUI.List('Ne pas recevoir de notifications', silenceTimeList, silenceTimeIndexSingle, nil, {}, true, {
                    onListChange = function(Index, Items)
                        ESX.ShowNotification("~g~Vous ne recevrez plus de notifications pendant "..silenceTimeList[silenceTimeIndexSingle])
                        ESX.MuteNotification(curr.silenceTimeIndex[silenceTimeIndexSingle])
                    end
                })

                if exports["es_extended"]:silplyEr() then
                    RageUI.Button("Réactiver les notifications", nil, {RightLabel = ''}, true, {
                        onSelected = function()
                            exports["es_extended"]:DisableNotif()
                            ESX.ShowNotification("~r~Les notifications seront désormais affichées de nouveau")
                        end
                    })
                end

                RageUI.List('Ne pas recevoir de notifications de votes', silenceTimeList, silenceTimeIndexSingleVotes, nil, {}, true, {
                    onListChange = function(Index, Items)
                        ESX.ShowNotification("~g~Vous ne recevrez plus de notifications pendant "..silenceTimeList[silenceTimeIndexSingleVotes])
                        ESX.MuteNotification(curr.silenceTimeIndex[silenceTimeIndexSingleVotes])
                    end
                })

                if exports["es_extended"]:SilVotePly() then
                    RageUI.Button("Réactiver les notifications de votes", nil, {RightLabel = ''}, true, {
                        onSelected = function()
                            exports["es_extended"]:DisableNotifVote()
                            ESX.ShowNotification("~r~Les notifications seront désormais affichées de nouveau")
                        end
                    })
                end

                RageUI.List("Position des nofitications", notifPosList, notifPosIndex, nil, {}, true, {
                    onListChange = function(Index, Items)
                        TriggerEvent("bulletin:savePosition", notifPosListIndex[notifPosIndex])
                        ESX.ShowNotification("~g~Position des nofitications '"..notifPosList[notifPosIndex].."' sauvegardée avec succès")
                    end
                })
            end)

                RageUI.IsVisible(carconfig, function()
                    RageUI.Checkbox("Casque moto", "Activer le fait d\'équiper un casque de moto automatiquement", casque, {RighLabel = ""}, { 
                        onChecked = function()
                            casque = true
                            SetPedConfigFlag(Player.playerPed, 35, true)
                        end,
                        onUnChecked = function()
                            casque = false
                            SetPedConfigFlag(Player.playerPed, 35, false)
                        end
                    })

                            RageUI.Checkbox("Conduite décontracté moto", 'Activer le style de conduite décontracté en moto', moto, {RighLabel = ""}, { 
                        onChecked = function()
                            moto = true
                            SetPedConfigFlag(PlayerPedId(), 424, true)
                        end,
                        onUnChecked = function()
                            moto = false
                            SetPedConfigFlag(PlayerPedId(), 424, false)
                        end
                    })
        end)
        RageUI.IsVisible(OptiMenu, function()
            RageUI.Button("Faire une optimisation légère", nil, {RightLabel = "📈"}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName, 
                        'Confirmer l\'optimisation légère',
                        '',
                        function(response)
                            if response then -- Oui
                                CascadeShadowsClearShadowSampleType()
                                CascadeShadowsSetAircraftMode(false)
                                CascadeShadowsEnableEntityTracker(true)
                                CascadeShadowsSetDynamicDepthMode(false)
                                CascadeShadowsSetEntityTrackerScale(5.0)
                                CascadeShadowsSetDynamicDepthValue(3.0)
                                CascadeShadowsSetCascadeBoundsScale(3.0)
                                
                                SetFlashLightFadeDistance(3.0)
                                SetLightsCutoffDistanceTweak(3.0)
                                DistantCopCarSirens(false)
                                SetArtificialLightsState(false)
                            else -- Non
                                ESX.ShowNotification("Optimisation annulée")
                            end
                        end
                    )
                end
            })
            

            
            RageUI.Button("Faire une optimisation médium", nil, {RightLabel = "🖥️"}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Confirmer l\'optimisation médium',
                        '',
                        function(response)
                            if response then -- Oui
                                CascadeShadowsClearShadowSampleType()
                                CascadeShadowsSetAircraftMode(false)
                                CascadeShadowsEnableEntityTracker(true)
                                CascadeShadowsSetDynamicDepthMode(false)
                                CascadeShadowsSetEntityTrackerScale(0.0)
                                CascadeShadowsSetDynamicDepthValue(0.0)
                                CascadeShadowsSetCascadeBoundsScale(0.0)
                                                    
                                SetFlashLightFadeDistance(2.0)
                                SetLightsCutoffDistanceTweak(0.0)
                                DistantCopCarSirens(false)
                                SetArtificialLightsState(false)
                            else -- Non
                                ESX.ShowNotification("Optimisation annulée")
                            end
                        end
                    )
                end
            })

            RageUI.Button("Faire une optimisation grosse", nil, {RightLabel = "⚡"}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Confirmer la grosse optimisation',
                        '',
                        function(response)
                            if response then -- Oui
                                SetTimecycleModifier('tunnel')
                                RopeDrawShadowEnabled(false)
                
                                CascadeShadowsClearShadowSampleType()
                                CascadeShadowsSetAircraftMode(false)
                                CascadeShadowsEnableEntityTracker(true)
                                CascadeShadowsSetDynamicDepthMode(false)
                                CascadeShadowsSetEntityTrackerScale(0.0)
                                CascadeShadowsSetDynamicDepthValue(0.0)
                                CascadeShadowsSetCascadeBoundsScale(0.0)
                
                                SetFlashLightFadeDistance(5.0)
                                SetLightsCutoffDistanceTweak(5.0)
                                DistantCopCarSirens(false)
                            else -- Non
                                ESX.ShowNotification("Optimisation annulée")
                            end
                        end
                    )
                end
            })
            

        end, function()
        end)
        RageUI.IsVisible(FightModif, function()
            -- RageUI.Button("Animation d'arme", nil, {RightLabel = ''}, true, {
            -- }, weaponsAnimationsMenu)
            RageUI.Button("Raccourcis d'armes", nil, {RightLabel = ''}, true, {
            }, weaponsBind)
            RageUI.Checkbox("Viseur", 'Afficher le viseur en mode tir', crosshairactive, {RighLabel = ""}, { 
                onChecked = function()
                    crosshairactive = true
                    crosshair()
                end,
                onUnChecked = function()
                    crosshairactive = false
                    crosshair()
                end
            })
            RageUI.Checkbox("Coup de poings", 'Activer l\'attaque par coups de poings', fighthand, {RighLabel = ""}, { 
                onChecked = function()
                    fighthand = true
                end,
                onUnChecked = function()
                    fighthand = false
                end
            })

            RageUI.Checkbox("Coup de Crosse", 'Permet d\'activer, désactiver les coup de crosse', coupdecrossmv, {RighLabel = ""}, { 
                onChecked = function()
                    coupdecrossmv = true
                end,
                onUnChecked = function()
                    coupdecrossmv = false
                end
            })
            RageUI.Checkbox("Roulades", "Permet d'activer/désactiver les roulades", rouladeMGL, {RighLabel = ""}, { 
                onChecked = function()
                    rouladeMGL = true
                end,
                onUnChecked = function()
                    rouladeMGL = false
                end
            })
        end)

        RageUI.IsVisible(weaponsBind, function()
            for i = 1, #Config.WeaponsBinds do
                RageUI.Button(('%s'):format(Config.WeaponsBinds[i].label), nil, {RightLabel = getWeaponKeybind(Config.WeaponsBinds[i].id).label}, true, {
                    onSelected = function()
                        weaponBindSelected = Config.WeaponsBinds[i].id
                    end
                }, weaponsBindList)
            end
        end)

        RageUI.IsVisible(weaponsBindList, function()

            RageUI.Button("Supprimer le raccourci", nil, {}, true, {
                onSelected = function()
                    setWeaponKeybind(weaponBindSelected, `WEAPON_UNARMED`, 'Aucun')
                    ESX.ShowNotification("Vous avez défini une nouvelle arme sur votre raccourci")
                    RageUI.GoBack()
                end
            })
        
            RageUI.Line()
        
            if #ESX.PlayerData.loadout > 0 then 
                for k, v in pairs(ESX.PlayerData.loadout) do 
                    RageUI.Button(('%s'):format(v.label), nil, {}, true, {
                        onSelected = function()
                            setWeaponKeybind(weaponBindSelected, v.name, v.label)
                            ESX.ShowNotification("Vous avez défini une nouvelle arme sur votre raccourci")
                            RageUI.GoBack()
                        end
                    })
                end
            else
                RageUI.Separator("Vous n'avez pas d'arme")
            end
        
        end)
        

        RageUI.IsVisible(drugsmod, function()
            if SunnyDrugs.sell.InSell then
                RageUI.Separator(('~r~Ventre de drogue (%s)~s~'):format(DrgusList[drugsIndex]))
            else
                RageUI.Separator('~r~Ventre de drogue~s~')
            end
            RageUI.List('Type de drogue', DrgusList, drugsIndex, nil, {}, not SunnyDrugs.sell.InSell, {
                onListChange = function(Index, Items)
                    if SunnyDrugs.sell.InSell then return end

                    drugsIndex = Index
                end
            })
            RageUI.Checkbox('Vente de drogue', nil, SunnyDrugs.sell.InSell, {}, {
                onChecked = function()
                    ESX.TriggerServerCallback('sunny:drugs:sell:getPhone', function(cb)
                        if not cb then return ESX.ShowNotification('Vous devez posséder un téléphone pour vendre de la ~r~drogue~s~') end

                        -- if exports["lb-phone"]:GetAirplaneMode() then return ESX.ShowNotification('Vous ne pouvez pas vendre de la drogue avec le mode avion activé') end

                        ESX.TriggerServerCallback('sunny:drugs:sell:getItem', function(cbb)
                            if not cbb then return end

                            SunnyDrugs.sell.InSell = true
    
                            sendPhoneMessage("Twitter", ("💊 Vente de pochon de %s"):format(DrgusList[drugsIndex]), "Tu viens de lancer une session de vente de drogue")
        
                            setNewDestination()
                        end, DrugsListData[DrgusList[drugsIndex]])

                    end)
                end,
                onUnChecked = function()
                    SunnyDrugs.sell.InSell = false

                    sendPhoneMessage("Twitter", ("💊 Vente de pochon de %s"):format(DrgusList[drugsIndex]), "Tu viens d\'arrêter ta session de vente de drogue")

                    stopVente()
                end
            })
        end)

        RageUI.IsVisible(radioMenu, function()
            radioMenu.EnableMouse = false
            RageUI.Checkbox('Etat de la radio', nil, self.radioEnabled, {}, {
                onChecked = function()
                    self.radioEnabled = true
                    pma:setVoiceProperty("radioEnabled", true)
                    pma:setRadioChannel(0)
                end,
                onUnChecked = function()
                    self.radioEnabled = false
                    pma:setVoiceProperty("radioEnabled", false)
                    pma:setRadioChannel(0)
                end,
            })
            if (self.radioEnabled) then
                RageUI.Button(('Fréquence (%s)'):format(self.radioChannel), nil, {}, true, {
                    onSelected = function()
                        local input = ESX.GetNumberInput("Entrez la fréquence")
                        if input == nil then
                            return ESX.ShowNotification("~r~La fréquence ne peut pas être nulle")
                        end

                        if Config.Personalmenu.Radio[input] then
                            if not Config.Personalmenu.Radio[input][ESX.PlayerData.job.name] then
                                return ESX.ShowNotification("Vous n'avez pas accès à cette fréquence")
                            end

                            self.radioChannel = input
                            pma:setRadioChannel(input)
                            ESX.ShowNotification(("Fréquence définie sur %s MHZ"):format(input))
                        else
                            self.radioChannel = tostring(input)
                            pma:setRadioChannel(input)
                            ESX.ShowNotification(("Fréquence définie sur %s MHZ"):format(input))
                        end
                    end
                })
                RageUI.Checkbox('Bruitages', nil, self.radioTick, {}, {
                    onChecked = function()
                        self.radioTick = true
                        pma:setVoiceProperty("micClicks", true)
                    end,
                    onUnChecked = function()
                        self.radioTick = false
                        pma:setVoiceProperty("micClicks", false)
                    end,
                })
                RageUI.Button(('Volume (%s)'):format(math.floor(self.volumeRadio*100)..'%'), nil, {}, true, {
                    onActive = function()
                        radioMenu.EnableMouse = true
                    end,
                })
            end
        end, function()
            RageUI.PercentagePanel(self.volumeRadio, 'Volume', '0%', '100%', {
                onProgressChange = function(data)
                    self.volumeRadio = data
                    pma:setRadioVolume(math.floor(self.volumeRadio*100))
                end
            }, 4)
        end)

        -- Neva Radio Menu
        
            RageUI.IsVisible(weaponsAnimationsMenu, function()
                
            for k,v in pairs(SunnyHolsters) do 
                RageUI.Checkbox(v.label, false, Player.holsterPreset == k, {}, {
                    onChecked = function()
                        SetResourceKvp("HolsterPreset", k)
                        Player.holsterPreset = GetResourceKvpString("HolsterPreset")
                    end
                })
            end
            RageUI.Line()
                        for k,v in pairs(SunnyAimStyles) do 
                RageUI.Checkbox(v, false, Player.aimStyle == v, {}, {
                    onChecked = function()
                        SetResourceKvp("aimStyle", v)
                        Player.aimStyle = GetResourceKvpString("aimStyle")
                    end
                })
            end
        end)

        RageUI.IsVisible(openSocietyList, function()
            local societyOpen, societyClosed = getSocietyStatusLists()

            if (#societyOpen == 0 and #societyClosed == 0) then
                RageUI.Separator('~c~Liste des entreprises indisponible')
                return
            end

            local function renderEntry(entry)
                if societyStatusBlacklist[entry.name] then
                    return
                end

                RageUI.Button(entry.label, 'Appuyer sur ENTRER si vous souhaitez voir la localisation de l\'entreprise sur votre map.', {RightLabel = entry.value}, true, {
                    onSelected = function()
                        if not setSocietyWaypoint(entry) then
                            ESX.ShowNotification('~r~Aucune localisation n\'est définie pour cette entreprise.')
                        end
                    end
                })
            end

            local function renderPaginatedEntries(entries, meta, emptyLabel, colorCode)
                ensurePagination(meta, #entries)

                if #entries == 0 then
                    RageUI.Separator(('~c~%s'):format(emptyLabel))
                    return
                end

                if meta.total > 1 then
                    RageUI.List(('%s (%d)'):format(colorCode, #entries), meta.labels, meta.index, 'Utilisez ← → pour changer de page', {}, true, {
                        onListChange = function(index)
                            meta.index = index
                        end
                    })
                else
                    RageUI.Separator(('%s (%d)'):format(colorCode, #entries))
                end

                local perPage = societyStatusView.perPage
                local startIdx = ((meta.index - 1) * perPage) + 1
                local endIdx = math.min(startIdx + perPage - 1, #entries)

                for i = startIdx, endIdx do
                    renderEntry(entries[i])
                end
            end

            renderPaginatedEntries(societyOpen, societyStatusView.pagination.open, 'Aucune entreprise ouverte', '~g~Entreprises ouvertes')

            if #societyOpen > 0 and #societyClosed > 0 then
                RageUI.Line()
            end

            renderPaginatedEntries(societyClosed, societyStatusView.pagination.closed, 'Aucune entreprise fermée', '~r~Entreprises fermées')
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(CustomMenu) and not RageUI.Visible(manageAnimalMenu) and not RageUI.Visible(CustomMenuSelected) and not RageUI.Visible(Portefeuille) and not RageUI.Visible(VehicleOption) and not RageUI.Visible(OpenReportFast) and not RageUI.Visible(OptiMenu) and not RageUI.Visible(FightModif) and not RageUI.Visible(vipMenu) and not RageUI.Visible(petMenu) and not RageUI.Visible(permanentAnimalsMenu) and not RageUI.Visible(animalAdoptMenu) and not RageUI.Visible(EntrepriseOption) and not RageUI.Visible(OptionsVisuels) and not RageUI.Visible(radioMenu) and not RageUI.Visible(openSocietyList) and not RageUI.Visible(Notifmeny) and not RageUI.Visible(propsMenu) and not RageUI.Visible(clothesMenu) and not RageUI.Visible(clothesMenu2) and not RageUI.Visible(factures) and not RageUI.Visible(stautinfo) and not RageUI.Visible(walksList) and not RageUI.Visible(openVipPeds) and not RageUI.Visible(visualconfig) and not RageUI.Visible(carconfig) and not RageUI.Visible(selectedWeaponTint) and not RageUI.Visible(selectedAnimals1) and not RageUI.Visible(gestionlicense) and not RageUI.Visible(vipPlateGestion) and not RageUI.Visible(vipPlates) and not RageUI.Visible(infojob2) and not RageUI.Visible(infojob) and not RageUI.Visible(guids) and not RageUI.Visible(weaponsAnimationsMenu) and not RageUI.Visible(ModifMenu) and not RageUI.Visible(weaponsBindList) and not RageUI.Visible(weaponsBind) and not RageUI.Visible(drugsmod) and not RageUI.Visible(territoryMenu) and
            
            not RageUI.Visible(main) then
            main = RMenu:DeleteType('main')
        end
    end
end

RegisterCommand('personnalmenu', function()
    openPersonnalMenu()
end)

RegisterKeyMapping('personnalmenu', 'Menu Personnel', 'keyboard', 'F5')

RegisterNetEvent('sunny:recieveProps', function(table)
    propsPropsList = table
end)

function getWeaponTint()
    local weaponHash = GetSelectedPedWeapon(PlayerPedId())
    if weaponHash ~= GetHashKey("WEAPON_UNARMED") then
        return GetPedWeaponTintIndex(PlayerPedId(), weaponHash)
    end
    return 0
end

function getWalkStyle()
    return "Normal"
end

function setWeaponTint(tintId)
    local weaponHash = GetSelectedPedWeapon(PlayerPedId())
    if weaponHash ~= GetHashKey("WEAPON_UNARMED") then
        SetPedWeaponTintIndex(PlayerPedId(), weaponHash, tintId)
        ESX.ShowNotification("Vous avez changé la teinte de votre arme.")
    else
        ESX.ShowNotification("Vous devez tenir une arme en main pour appliquer une teinte.")
    end
end