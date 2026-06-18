-- Initialiser Society si non existant
if not Society then
    Society = { List = {} }
end

-- Handler pour recevoir la liste des sociétés
RegisterNetEvent('sunny:society:sendList', function(data)
    if data then
        Society.List = data
    end
end)

society = function(data, ...)
    if type(data) == 'table' then
        return data
    elseif type(data) == 'string' then
        return {name = data, label = data}
    else
        return {}
    end
end

CreateThread(function()
    while true do
        Wait(10)
    end
end)

adminManagement = {
    Service = false,
    LockSearch = true,
    NoClip = false,
    Gamertags = false,
    MyName = false,
    SuppInfo = false,
    Blips = false,
    InfoReports = false,
    SongReports = false,
    isSpectateMod = false,
    object = false,
    gunInfos = false,
    objectFilter = nil,
    objectFilterUniqueId = false,
    Invisible = false,
    Invincible = false,
    -- Vehicles
    FreezeUnFreeze = false,
    territories = {},
    territoriesDrugs = {},
    territoriesShop = {},
    -- Players
    Players = {},
    PlayersCount = 0,
    SearchPlayer = nil,
    ZoneShow = false,
    staffList = {},
    staffsCounts = 0,
    SelectedPlayer = {},
    FreezeUnfreeze = false,
    accounts = {},
    AddJobList = {},
    AddGradeListWithJob = {},
    AddSearchJob = nil,
    SelectedPlayerJobList = {},
    searchStaff = nil,
    gestion_staff = {
        data = {},
        best = {},
    },
    SelectedJobType = 1,
    WarnList = {},
    WarnListSearch = nil,
    jobsData = {},
    -- Reports
    Reports = {},
    ReportsInfo = false,
    MyReports = 0,
    ReportsCount = 0,
    SelectedReport = {},
    Filters = false,
    FiltersList = {'Tous', 'Pris en charge', 'Non pris en charge'},
    FiltersListIndex = 1,

    -- Server
    DealerShipVehicles = {},
    DealerShipCategories = {},
    DealerShipCategoriesSelect = nil,
    SearchVehicle = nil,
    SearchVehicleCategorie = nil,
    EditCategorieType = nil,
    EditCategorieTypeList = {},
    DealerShipAddVehicleAddParentCategory = {
        name = nil,
        label = nil
    },
    DealerShipAddVehicle = {
        spawnName = nil,
        label = nil,
        price = nil,
        categorie = nil
    },
    DealerShipEditVehicle = {
        name = nil,
    },
    JobList = {},
    GradeList = {},
    ItemsList = {},
    SellingList = {},

    -- Gestion Téléphones avancée
    PhoneListe = {},
    PhoneSearch = nil,
    SelectedPhone = nil,

    -- Gestion Staff avancée
    StaffGrades = {},
    SelectedStaffGrade = nil,
    StaffPermissions = {},
    NewStaffGrade = {
        name = nil,
        label = nil,
        color = '#ffffff',
        priority = 1,
    },

    CreateDrugs = {
        Laboratory = {
            active = false,
            list = {
                ['weed_laboratory'] = {
                    name = 'weed_laboratory',
                    label = 'Laboratoire de Weed',
                    active = false,
                    exit = vector3(1066.15, -3183.38, -40.15),
                    exitHeading = 90.0,
                    interiorAtCoords = vector3(1051.491, -3196.536, -39.14842),
                    management = vector3(1044.605, -3194.886, -38.15789),
                    ipls = true,
                    iplsList = {
                        'weed_drying',
                        'weed_production',
                        'weed_set_up',
                        'weed_standard_equip',
                        'weed_upgrade_equip',
                        'weed_growtha_stage1',
                        'weed_growtha_stage2',
                        'weed_growtha_stage3',
                        'weed_growthb_stage1',
                        'weed_growthb_stage2',
                        'weed_growthb_stage3',
                        'weed_growthc_stage1',
                        'weed_growthc_stage2',
                        'weed_growthc_stage3',
                        'weed_growthd_stage1',
                        'weed_growthd_stage2',
                        'weed_growthd_stage3',
                        'weed_growthe_stage1',
                        'weed_growthe_stage2',
                        'weed_growthe_stage3',
                        'weed_growthf_stage1',
                        'weed_growthf_stage2',
                        'weed_growthf_stage3',
                        'weed_growthg_stage1',
                        'weed_growthg_stage2',
                        'weed_growthg_stage3',
                        'weed_growthh_stage1',
                        'weed_growthh_stage2',
                        'weed_growthh_stage3',
                        'weed_growthi_stage1',
                        'weed_growthi_stage2',
                        'weed_growthi_stage3',
                        'weed_hosea',
                        'weed_hoseb',
                        'weed_hosec',
                        'weed_hosed',
                        'weed_hosee',
                        'weed_hosef',
                        'weed_hoseg',
                        'weed_hoseh',
                        'weed_hosei',
                        'light_growtha_stage23_standard',
                        'light_growthb_stage23_standard',
                        'light_growthc_stage23_standard',
                        'light_growthd_stage23_standard',
                        'light_growthe_stage23_standard',
                        'light_growthf_stage23_standard',
                        'light_growthg_stage23_standard',
                        'light_growthh_stage23_standard',
                        'light_growthi_stage23_standard',
                        'light_growtha_stage23_upgrade',
                        'light_growthb_stage23_upgrade',
                        'light_growthc_stage23_upgrade',
                        'light_growthc_stage23_upgrade',
                        'light_growthd_stage23_upgrade',
                        'light_growthe_stage23_upgrade',
                        'light_growthf_stage23_upgrade',
                        'light_growthg_stage23_upgrade',
                        'light_growthh_stage23_upgrade',
                        'light_growthi_stage23_upgrade',
                        'weed_low_security',
                        'weed_security_upgrade',
                        'weed_chairs'
                    },
                },
                ['coke_laboratory'] = {
                    name = 'coke_laboratory',
                    label = 'Laboratoire de Coke',
                    active = false,
                    exit = vector3(1066.15, -3183.38, -40.15),
                    exitHeading = 90.0,
                    interiorAtCoords = vector3(1051.491, -3196.536, -39.14842),
                    ipls = false,
                },
                ['meth_laboratory'] = {
                    name = 'meth_laboratory',
                    label = 'Laboratoire de Meth',
                    active = false,
                    exit = vector3(1066.15, -3183.38, -40.15),
                    exitHeading = 90.0,
                    interiorAtCoords = vector3(1051.491, -3196.536, -39.14842),
                    ipls = false,
                },
            },
            Index = 1
        }
    },
    SelectedDrugs = {},
    SelectedDrugsCategorie = 'recolte',

    -- Society
    SelectedSociety = {},
    SelectedSocietyZoneTeleport = {'Blips', 'Coffre', 'Boss'},
    SelectedSocietyZoneTeleportIndex = 1,
    SelectedSocietyGrade = {},

    -- ID Unique
    UniqueIDSearch = {},
    UniqueIDSearchBoutiqueHistory = {},
    UniqueIDSearchBoutiqueHistorySearch = nil,
    WeaponSearch = nil,
    SelectedWeapon = {},
    UniqueIDPlayerInventoryWeaponSelectK = nil,

    -- Utils
    LastPlayerPos = {},

    -- Events
    EventPos = true,
    EventPosList = {'Maze Bank Arena (Scene Fashion)', 'Maze Bank Arena (Plafond Milieux)'},
    EventPosListIndex = 1,
    EventPosListData = {
        [1] = {
            pos = vector3(-329.3486328125, -1970.4323730469, 21.603454589844),
            pos2 = vector3(-325.30215454102, -1973.9567871094, 21.603446960449)
        },
        [2] = {
            pos = vector3(-323.94323730469, -1968.1636962891, 36.276332855225)
        },
    },

    -- EventFireWorksData
    EventFireWorksDef = true,
    EventPosListFireWorks = {'Fontaine de feux', 'Explosion de feux', 'Explosion étoile blanche'},
    EventPosListFireWorskIndex = 1,
    TimeFireWorks = 0,
    EventFireWorksNotDef = nil,
    EventFireWorksNotZoneDef = {},

    -- give vehicle
    vehicleModel = nil,
    vehicleLabel = nil,
    vehicleType = nil,
    vehicleBoutique = false,
    vehicleData = {},
    garageSelected = {},
    vehicleGarageid = 1,

    jails = {},
    
    society = function(data, ...)
        if type(society) == "function" and society ~= adminManagement.society then
            return society(data, ...)
        elseif type(data) == 'table' then
            return data
        elseif type(data) == 'string' then
            return {name = data, label = data}
        else
            return {}
        end
    end,
}

society = function(data, ...)
    if type(data) == 'table' then
        return data
    elseif type(data) == 'string' then
        return {name = data, label = data}
    else
        return {}
    end
end
local objectIndex = 1
local objectsFormatted = WorldProps.list
local objectCategories = { "Mobilier" }
function sortGroupTable(t)
    local sorted = {}
    for k, v in pairs(t) do
        sorted[#sorted + 1] = v
    end
    table.sort(sorted, function(a, b)
        return a.id < b.id
    end)
    return (sorted)
end

function adminManagement:SetCoords(player, coords)
    SetEntityCoords(player, coords)
end

RegisterNetEvent('sunny:admin:addReport', function(a, data, value)
    adminManagement.Reports = data

    if value == 'new' then
        adminManagement.ReportsCount = 0
        
        for k,v in pairs(adminManagement.Reports) do
            adminManagement.ReportsCount = adminManagement.ReportsCount + 1
        end
        
        if adminManagement.SongReports then
            PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true)
        end
    end
end)

RegisterNetEvent('sunny:reports:refreh:service', function(reportList)
    adminManagement.Reports = reportList

    for k,v in pairs(adminManagement.Reports) do
        adminManagement.ReportsCount = adminManagement.ReportsCount + 1
    end
end)

RegisterNetEvent('sunny:admin:removeReport', function(v, k, data, value)
    adminManagement.Reports = data
    adminManagement.ReportsCount = 0

    for k,v in pairs(adminManagement.Reports) do
        adminManagement.ReportsCount = adminManagement.ReportsCount + 1
    end
end)

RegisterNetEvent('sunny:admin:addPlayer', function(data)
    adminManagement.Players = data
    adminManagement.PlayersCount = 0

    for k,v in pairs(adminManagement.Players) do
        adminManagement.PlayersCount = adminManagement.PlayersCount + 1
    end
end)

RegisterNetEvent('sunny:admin:addStaff', function(data)
    if type(data) ~= 'table' or type(data.list) ~= 'table' then
        print("addStaff en invalid format")
        return
    end

    local oldData = json.encode(adminManagement.staffList or {})
    local newData = json.encode(data.list)

    if oldData == newData then
        print("data addStaff inchangé")
        return
    end

    print("data addStaff bien changé")

    adminManagement.staffList = data.list
    adminManagement.staffsCounts = tonumber(data.count) or 0
end)

RegisterNetEvent('sunny:admin:addStaff:service', function(id, newVal)
    if adminManagement.staffList and adminManagement.staffList[id] then
        adminManagement.staffList[id].service = newVal
    else
        print("Warning: Attempting to set service for non-existent staff ID: " .. tostring(id))
    end
end)

RegisterNetEvent('sunny:admin:teleport', function(coords)
    adminManagement:SetCoords(PlayerPedId(), vector3(coords))
end)

Citizen.CreateThread(function()
    ESX.TriggerServerCallback('screenshot:getwebhook', function(webhookUrl)
        WebHook = webhookUrl
    end)
end)

RegisterNetEvent('sunny:admin:requestScreen', function(target, license, sourceName)
    exports['screenshot-basic']:requestScreenshotUpload(WebHook, "files[]", function(data)
        TriggerServerEvent('sunny:admin:sendLogsScreen', target, license, json.decode(data), sourceName)
    end)
end)

AddEventHandler('onResourceStart', function()
    TriggerServerEvent('sunny:admin:restart')
end)

RegisterNetEvent('sunny:admin:restart', function(source)
    TriggerServerEvent('sunny:admin:restart')
end)

RegisterNetEvent('sunny:admin:service', function(value)
    adminManagement.Service = value

    adminManagement.InfoReports = value

    local pPed = PlayerId()

    if adminManagement.Service and Config.Staff.HavePermission('OutFit', 'Data') then
        -- while not exports['zConnect']:playerLoaded() do Wait(1) end


        local playerPed = PlayerPedId()
        TriggerEvent('skinchanger:getSkin', function(currentSkin)
            adminManagement.SavedHair = {
                hair_1 = currentSkin.hair_1,
                hair_2 = currentSkin.hair_2,
                hair_color_1 = currentSkin.hair_color_1,
                hair_color_2 = currentSkin.hair_color_2
            }
        end)
        
        while adminManagement.Service do 
            Wait(1000)
            local model = GetEntityModel(Player.playerPed)

            if model ~= `mp_m_freemode_01` and model ~= `mp_f_freemode_01` then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    local playerHealth = GetEntityHealth(Player.playerPed)
                    if adminManagement.SavedHair then
                        skin.hair_1 = adminManagement.SavedHair.hair_1
                        skin.hair_2 = adminManagement.SavedHair.hair_2
                        skin.hair_color_1 = adminManagement.SavedHair.hair_color_1
                        skin.hair_color_2 = adminManagement.SavedHair.hair_color_2
                    end
                    TriggerEvent('skinchanger:forceLoadSkin', skin, playerHealth)
                end)
            end

            TriggerEvent('skinchanger:getSkin', function(skin)
                if not adminManagement.SavedHair then
                    adminManagement.SavedHair = {
                        hair_1 = skin.hair_1,
                        hair_2 = skin.hair_2,
                        hair_color_1 = skin.hair_color_1,
                        hair_color_2 = skin.hair_color_2
                    }
                end
                
                if model == `mp_m_freemode_01` then
                    clothesSkin = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                        ['torso_1'] = 178, ['torso_2'] = 3,
                        ['arms'] = 33,
                        ['pants_1'] = 77, ['pants_2'] = 3,
                        ['shoes_1'] = 55, ['shoes_2'] = 3,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = 91, ['helmet_2'] = 3,
                    }
                elseif model == `mp_f_freemode_01` then
                    clothesSkin = {
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['tshirt_1'] = 6,['tshirt_2'] = 0,
                        ['torso_1'] = 180, ['torso_2'] = 4,
                        ['arms'] = 3, ['arms_2'] = 0,
                        ['pants_1'] = 79, ['pants_2'] = 4,
                        ['shoes_1'] = 58, ['shoes_2'] = 4,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bproof_1'] = 0,
                        ['chain_1'] = 0,
                        ['helmet_1'] = 90, ['helmet_2'] = 4,
                    }
                end
                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                
                -- Restaurer la coiffure après avoir chargé la tenue staff
                if adminManagement.SavedHair then
                    TriggerEvent('skinchanger:change', 'hair_1', adminManagement.SavedHair.hair_1)
                    TriggerEvent('skinchanger:change', 'hair_2', adminManagement.SavedHair.hair_2)
                    TriggerEvent('skinchanger:change', 'hair_color_1', adminManagement.SavedHair.hair_color_1)
                    TriggerEvent('skinchanger:change', 'hair_color_2', adminManagement.SavedHair.hair_color_2)
                end
            end)
            
            if not adminManagement.Service then
                break
            end
        end

        TriggerEvent('esx:restoreLoadout')

        if Config.Staff.HavePermission('OutFit', 'Data') then
            adminManagement.InfoReports = true
            adminManagement.SongReports = true
            adminManagement.MyName = true
            Blips()
            showNames(true)
        end

        local playerHealth = GetEntityHealth(Player.playerPed)
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            -- Restaurer la coiffure préservée dans la skin
            if adminManagement.SavedHair then
                skin.hair_1 = adminManagement.SavedHair.hair_1
                skin.hair_2 = adminManagement.SavedHair.hair_2
                skin.hair_color_1 = adminManagement.SavedHair.hair_color_1
                skin.hair_color_2 = adminManagement.SavedHair.hair_color_2
            end
            TriggerEvent('skinchanger:forceLoadSkin', skin, playerHealth)
        end)

        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            local isMale = skin.sex == 0

            -- Restaurer la coiffure préservée dans la skin
            if adminManagement.SavedHair then
                skin.hair_1 = adminManagement.SavedHair.hair_1
                skin.hair_2 = adminManagement.SavedHair.hair_2
                skin.hair_color_1 = adminManagement.SavedHair.hair_color_1
                skin.hair_color_2 = adminManagement.SavedHair.hair_color_2
            end

            TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    -- Restaurer la coiffure préservée dans la skin
                    if adminManagement.SavedHair then
                        skin.hair_1 = adminManagement.SavedHair.hair_1
                        skin.hair_2 = adminManagement.SavedHair.hair_2
                        skin.hair_color_1 = adminManagement.SavedHair.hair_color_1
                        skin.hair_color_2 = adminManagement.SavedHair.hair_color_2
                    end
                    TriggerEvent('skinchanger:loadSkin', skin)
                    TriggerEvent('esx:restoreLoadout')
                    
                    -- Sauvegarder la skin avec la coiffure préservée
                    TriggerEvent('skinchanger:getSkin', function(finalSkin)
                        TriggerServerEvent('esx_skin:save', finalSkin)
                    end)
                end)
            end)
        end)
        
        -- Nettoyer la coiffure sauvegardée
        adminManagement.SavedHair = nil

        adminManagement.InfoReports = false
        adminManagement.SongReports = false
        adminManagement.MyName = false
        Blips()
        showNames(false)
    end
end)

function adminManagement:removePermissions()
    if adminManagement.NoClip then
        ToggleNoClipMode()
    end
    if adminManagement.Invisible then
        local playerPed = PlayerPedId()
        SetEntityVisible(playerPed, true, false)
        adminManagement.Invisible = false
    end
    if adminManagement.Invincible then
        local playerPed = PlayerPedId()
        SetEntityInvincible(playerPed, false)
        SetPlayerInvincible(PlayerId(), false)
        adminManagement.Invincible = false
    end
    adminManagement.Service = false adminManagement.Gamertags = false adminManagement.MyName = false adminManagement.Blips = false adminManagement.InfoReports = false adminManagement.SongReports = false adminManagement.NoClip = false
end

local weathersZone = {
    {"Autre", 1},
    {"Sud", 2},
    {"Nord", 3},
}

function adminManagement:staffMenu()
    
    while not ESXLoaded do Wait(1) end

    local main = RageUI.CreateMenu('', 'Actions Disponibles')

    local actionsPersonnel = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')

    local playersList = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    local selectedPlayer = RageUI.CreateSubMenu(playersList, '', 'Actions Disponibles')
    local infoPlayer = RageUI.CreateSubMenu(selectedPlayer, '', 'Actions Disponibles')
    local accountsPlayer = RageUI.CreateSubMenu(infoPlayer, '', 'Actions Disponibles') 
    local jobPlayer = RageUI.CreateSubMenu(infoPlayer, '', 'Actions Disponibles')
    local addJobPlayer = RageUI.CreateSubMenu(selectedPlayer, '', 'Actions Disponibles')
    local addJobPlayerList = RageUI.CreateSubMenu(addJobPlayer, '', 'Actions Disponibles')
    local addJobGradeWithJobList = RageUI.CreateSubMenu(addJobPlayerList, '', 'Actions Disponibles')
    local changePlayerGroup = RageUI.CreateSubMenu(selectedPlayer, '', 'Actions Disponibles')
    local WarnListPlayer = RageUI.CreateSubMenu(selectedPlayer, '', 'Actions Disponibles')

    local openServInfo = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')

    local vehiclesOptions = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    local tpoints = RageUI.CreateSubMenu(actionsPersonnel, '', 'Actions Disponibles')

    local serverOptions = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    local openCreateSociety = RageUI.CreateSubMenu(serverOptions, '', 'Actions Disponibles')
    local openCreateFarm = RageUI.CreateSubMenu(serverOptions, '', 'Actions Disponibles')
    local openEditSociety = RageUI.CreateSubMenu(serverOptions, '', 'Actions Disponibles')
    local openEditSelectedSociety = RageUI.CreateSubMenu(openEditSociety, '', 'Actions Disponibles')
    local supprimerSocieteMenu = RageUI.CreateSubMenu(openEditSociety, '', 'Actions Disponibles')
    local openEditSocietyGrade = RageUI.CreateSubMenu(openEditSelectedSociety, '', 'Actions Disponibles')
    local openEditGradeMenu = RageUI.CreateSubMenu(openEditSelectedSociety, '', 'Actions Disponibles')
    local openInformationsSociety = RageUI.CreateSubMenu(openEditSelectedSociety, '', 'Actions Disponibles')
    local weaponsSell = RageUI.CreateSubMenu(serverOptions, '', 'Actions Disponibles')
    local weaponsSellGroupList = RageUI.CreateSubMenu(weaponsSell, '', 'Actions Disponibles')
    local createDrugs = RageUI.CreateSubMenu(serverOptions, '', 'Actions Disponibles')
    local createCircuit = RageUI.CreateSubMenu(createDrugs, '', 'Actions Disponibles')
    local editCircuit = RageUI.CreateSubMenu(createDrugs, '', 'Actions Disponibles')
    local editCircuit2 = RageUI.CreateSubMenu(editCircuit, '', 'Actions Disponibles')

    local menuServerOptionsPhone = RageUI.CreateSubMenu(openServInfo, '', 'Actions Disponibles')

    local openJobList = RageUI.CreateSubMenu(openServInfo, '', 'Actions Disponibles')

    local staffGestion = RageUI.CreateSubMenu(openServInfo, '', 'Actions Disponibles')

    local staffGestion_list = RageUI.CreateSubMenu(staffGestion, '', 'Actions Disponibles')
    local staffGestion_reportList = RageUI.CreateSubMenu(staffGestion, '', 'Actions Disponibles')


    local editPosWithCategorie_drugs = RageUI.CreateSubMenu(editCircuit2, '', 'Actions Disponibles')
    local editSellDrugs = RageUI.CreateSubMenu(createDrugs, '', 'Actions Disponibles')
    local manageVehicleConcess = RageUI.CreateSubMenu(serverOptions, '', 'Actions Disponibles')
    local manageVehicleConcessCreateVehicle = RageUI.CreateSubMenu(manageVehicleConcess, '', 'Actions Disponibles')
    local manageVehicleConcessCreateVehicleCategorie = RageUI.CreateSubMenu(manageVehicleConcessCreateVehicle, '', 'Actions Disponibles')
    local manageVehicleConcessEdit = RageUI.CreateSubMenu(manageVehicleConcess, '', 'Actions Disponibles')
    local manageVehicleConcessEditCategorie = RageUI.CreateSubMenu(manageVehicleConcessEdit, '', 'Actions Disponibles')
    local manageVehicleConcessEditAllCategorie = RageUI.CreateSubMenu(manageVehicleConcess, '', 'Actions Disponibles')
    local manageVehicleConcessEditAllCategorieEdit = RageUI.CreateSubMenu(manageVehicleConcessEditAllCategorie, '', 'Actions Disponibles')
    local manageVehicleConcessEditAllCategorieEditAdd = RageUI.CreateSubMenu(manageVehicleConcessEditAllCategorieEdit, '', 'Actions Disponibles')
    local manageVehicleConcessEditAllCategorieEditInformations = RageUI.CreateSubMenu(manageVehicleConcessEditAllCategorieEdit, '', 'Actions Disponibles')
    local weatherManagement = RageUI.CreateSubMenu(serverOptions, '', 'Actions Disponibles')

    -- Gestion Téléphones avancée
    local gestionTelephones = RageUI.CreateSubMenu(openServInfo, '', 'Gestion Téléphones')
    local gestionTelephonesSelected = RageUI.CreateSubMenu(gestionTelephones, '', 'Téléphone')

    -- Gestion Staff avancée
    local gestionStaffGrades = RageUI.CreateSubMenu(staffGestion, '', 'Gestion Grades')
    local gestionStaffGradeSelected = RageUI.CreateSubMenu(gestionStaffGrades, '', 'Grade')
    local gestionStaffGradePermissions = RageUI.CreateSubMenu(gestionStaffGradeSelected, '', 'Permissions')
    local gestionStaffCreateGrade = RageUI.CreateSubMenu(gestionStaffGrades, '', 'Créer Grade')

    local reportsList = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    local selectedReport = RageUI.CreateSubMenu(reportsList, '', 'Actions Disponibles')
    local infoReportPlayer = RageUI.CreateSubMenu(selectedReport, '', 'Actions Disponibles')
    local accountsReportPlayer = RageUI.CreateSubMenu(infoReportPlayer, '', 'Actions Disponibles') 
    local jobReportPlayer = RageUI.CreateSubMenu(infoReportPlayer, '', 'Actions Disponibles')
    local addJobReportPlayer = RageUI.CreateSubMenu(selectedReport, '', 'Actions Disponibles')
    local addJobReportPlayerList = RageUI.CreateSubMenu(addJobReportPlayer, '', 'Actions Disponibles')
    local addReportJobGradeWithJobList = RageUI.CreateSubMenu(addJobReportPlayerList, '', 'Actions Disponibles')
    local changeReportPlayerGroup = RageUI.CreateSubMenu(selectedReport, '', 'Actions Disponibles')

    local SearchUniqueID = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    local UniqueIDresult = RageUI.CreateSubMenu(SearchUniqueID, '', 'Actions Disponibles')
    local UniqueIDPlayerInventory = RageUI.CreateSubMenu(UniqueIDresult, '', 'Actions Disponibles')
    local UniqueIDPlayerInventoryWeaponSelect = RageUI.CreateSubMenu(UniqueIDPlayerInventory, '', 'Actions Disponibles')
    local UniqueIDPlayerWeapponAccesory = RageUI.CreateSubMenu(UniqueIDPlayerInventoryWeaponSelect, '', 'Actions Disponibles')
    local UniqueIDPlayerBoutiqueHistory = RageUI.CreateSubMenu(UniqueIDresult, '', 'Actions Disponibles')
    local WeaponListIDUnique = RageUI.CreateSubMenu(UniqueIDresult, '', 'Actions Disponibles')
    local UniqueIDPlayerDataGIVE_VEHICLE = RageUI.CreateSubMenu(UniqueIDresult, '', 'Actions Disponibles')
    local UniqueIDPlayerDataGIVE_VEHICLE_GARAGE = RageUI.CreateSubMenu(UniqueIDPlayerDataGIVE_VEHICLE, '', 'Actions Disponibles')
    local WarnListPlayerUniqueID = RageUI.CreateSubMenu(UniqueIDresult, '', 'Actions Disponibles')
    local changePlayerGroupWithUniqueID = RageUI.CreateSubMenu(UniqueIDresult, '', 'Actions Disponibles')
    local UniqueIDPlayerDataGIVE_Item = RageUI.CreateSubMenu(UniqueIDresult, '', 'Actions Disponibles')

    local eventOptions = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    local truckEvent = RageUI.CreateSubMenu(eventOptions, '', 'Actions Disponibles')
    local mba = RageUI.CreateSubMenu(eventOptions, '', 'Actions Disponibles')
    local openEventCreator = RageUI.CreateSubMenu(eventOptions, '', 'Actions Disponibles')
    local fireWorksEvent = RageUI.CreateSubMenu(eventOptions, '', 'Actions Disponibles')

    local weathers = weatherCFG?.weathers
    local phoneSearchResult = nil
    menuServerOptionsPhone.Closed = function()
        phoneSearchResult = nil
    end

    RageUI.Visible(main, not RageUI.Visible(main))
    while main do Wait(1)
        RageUI.IsVisible(main, function()
            if not (Config.Staff.HavePermission('Menu', 'openMenu')) then adminManagement:removePermissions() RageUI.CloseAll() end

             if not adminManagement.Service then
                RageUI.Info(
                    string.format("%sInformations Hors-Service", SunnyConfigServ.GTACOLOR), 
                    {'Report(s)', 'Staff(s)', 'Group'}, 
                    {adminManagement.ReportsCount, adminManagement.staffsCounts, Config.Staff.Group[ESX.PlayerData.group]}
                )
                             end

            if (Config.Staff.HavePermission('Menu', 'openMenu')) then
                RageUI.Checkbox('Service', nil, adminManagement.Service, {}, {
                    onChecked = function()
                        TriggerServerEvent('sunny:admin:service')
                    end,
                    onUnChecked = function()
                        TriggerEvent('SHOW_NOTIFTOP', false, ('Joueurs: ~g~%s~s~ Reports: ~g~%s~s~ Staffs: ~g~%s~s~'):format(adminManagement.PlayersCount, adminManagement.ReportsCount, adminManagement.staffsCounts), SunnyConfigServ.LogoUrl, ('rgba(%s,%s,%s,%s)'):format(33, 37, 41, UTILS.ServerColor.o))
                        TriggerServerEvent('sunny:admin:service')
                        adminManagement.Gamertags = false
                        adminManagement.MyName = false
                        adminManagement.Blips = false
                        adminManagement.InfoReports = false
                        adminManagement.SongReports = false
                        if adminManagement.NoClip then
                            ToggleNoClipMode()
                        end
                        if adminManagement.Invisible then
                            local playerPed = PlayerPedId()
                            SetEntityVisible(playerPed, true, false)
                            adminManagement.Invisible = false
                        end
                        if adminManagement.Invincible then
                            local playerPed = PlayerPedId()
                            SetEntityInvincible(playerPed, false)
                            SetPlayerInvincible(PlayerId(), false)
                            adminManagement.Invincible = false
                        end
                        if Config.Staff.HavePermission('OutFit', 'Data') then
                            Citizen.CreateThread(function()
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                    local isMale = skin.sex == 0
                
                
                                    TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                            TriggerEvent('skinchanger:loadSkin', skin)
                                            TriggerEvent('esx:restoreLoadout')
                                        end)
                                    end)
                                end)
                            end)
                        end
                    end
                })
            end
            if not adminManagement.Service then
                if Config.Staff.HavePermission('OutFit', 'Data') or ESX.PlayerData.group == 'gerant' then
                    if (Config.Staff.HavePermission('Modules', 'reportsSong')) then
                        RageUI.Checkbox('Son des reports (Hors-Service)', nil, adminManagement.SongReports, {}, {
                            onChecked = function()
                                adminManagement.SongReports = true
                            end,
                            onUnChecked = function()
                                adminManagement.SongReports = false
                            end
                        })
                    end
                end
            end
            if adminManagement.Service then
                RageUI.Line()
                if (Config.Staff.HavePermission('Menu', 'personnalOptions')) then
                    RageUI.Button('Options Personnelles', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            
                        end
                    }, actionsPersonnel)
                end
                if (Config.Staff.HavePermission('Menu', 'vehiclesOptions')) then
                    RageUI.Button('Options Véhicules', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                        end
                    }, vehiclesOptions)
                end
                if ESX.GetPlayerData()["group"] == "fondateur" then
                RageUI.Button('Gestion Serveur', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        end
                    }, serverOptions)
                end
                if (Config.Staff.HavePermission('Menu', 'staffsList')) then
                    RageUI.Button(('Options Supplémentaires'), nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            
                        end
                    }, openServInfo)
                end
                if (Config.Staff.HavePermission('Menu', 'events')) then
                    RageUI.Button('Événements', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                        end
                    }, eventOptions)
                end
                if (Config.Staff.HavePermission('Menu', 'playersList')) then
                    RageUI.Button(('Liste des Joueurs (%s%s~s~)'):format(SunnyConfigServ.GTACOLOR, adminManagement.PlayersCount), nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            
                        end
                    }, playersList)
                end
                if (Config.Staff.HavePermission('Menu', 'uniqueidOptions')) then
                    RageUI.Button('Options ID Unique', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            
                        end
                    }, SearchUniqueID)
                end
                if (Config.Staff.HavePermission('Menu', 'reports')) then
                    RageUI.Button(('Reports (%s%s~s~)'):format(SunnyConfigServ.GTACOLOR, adminManagement.ReportsCount), nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            
                        end
                    }, reportsList)
                end
                RageUI.Line()
            end
        end)

        RageUI.IsVisible(actionsPersonnel, function()
            if (Config.Staff.HavePermission('Modules', 'noClip')) then
                RageUI.Checkbox('Noclip', nil, adminManagement.NoClip, {}, {
                    onChecked = function()
                        ToggleNoClipMode()
                        adminManagement.NoClip = true
                    end,
                    onUnChecked = function()
                        ToggleNoClipMode()
                        adminManagement.NoClip = false
                    end
                })
            end
            if (Config.Staff.HavePermission('Modules', 'gamerTags')) then
                RageUI.Checkbox('Gamertag', nil, adminManagement.Gamertags, {}, {
                    onChecked = function()
                        showNames(true)
                    end,
                    onUnChecked = function()
                        showNames(false)
                    end
                })
                RageUI.Checkbox('Afficher mon nom', nil, adminManagement.MyName, {}, {
                    onChecked = function()
                        adminManagement.MyName = true
                    end,
                    onUnChecked = function()
                        adminManagement.MyName = false
                    end
                })
                RageUI.Checkbox('Afficher les Informations Supplémentaires', nil, adminManagement.SuppInfo, {}, {
                    onChecked = function()
                        showNames(false)
                        Wait(5)
                        adminManagement.SuppInfo = true
                        Wait(100)
                        showNames(true)
                    end,
                    onUnChecked = function()
                        showNames(false)
                        Wait(5)
                        adminManagement.SuppInfo = false
                        Wait(100)
                        showNames(true)
                    end
                })
            end

            if (Config.Staff.HavePermission('Modules', 'blips')) then
                RageUI.Checkbox('Blips', nil, adminManagement.Blips, {}, {
                    onChecked = function()
                        Blips()
                    end,
                    onUnChecked = function()
                        Blips()
                    end
                })
            end
            if (Config.Staff.HavePermission('Modules', 'reportsInfos')) then
            RageUI.Checkbox('Informations reports', nil, adminManagement.InfoReports, {}, {
                    onChecked = function()
                        adminManagement.InfoReports = true
                    end,
                    onUnChecked = function()
                        adminManagement.InfoReports = false

                        -- exports['core-ui']:hideInfo()
                        TriggerEvent('SHOW_NOTIFTOP', false, ('Joueurs: ~g~%s~s~ Reports: ~g~%s~s~ Staffs: ~g~%s~s~'):format(adminManagement.PlayersCount, adminManagement.ReportsCount, adminManagement.staffsCounts), SunnyConfigServ.LogoUrl, ('rgba(%s,%s,%s,%s)'):format(33, 37, 41, UTILS.ServerColor.o))

                    end
                })
            end
            if (Config.Staff.HavePermission('Modules', 'reportsSong')) then
                RageUI.Checkbox('Son des reports', nil, adminManagement.SongReports, {}, {
                    onChecked = function()
                        adminManagement.SongReports = true
                    end,
                    onUnChecked = function()
                        adminManagement.SongReports = false
                    end
                })
            end
            if (Config.Staff.HavePermission('Modules', 'objects')) then
                RageUI.Checkbox('Objets', nil, adminManagement.object, {}, {
                    onChecked = function()
                        WorldProps.data.info = true
                        setobject()
                    end,
                    onUnChecked = function()
                        WorldProps.data.info = false
                        setobject()
                    end
                })
            end
            
            RageUI.Line()
            RageUI.Separator('~b~Modes Spéciaux')
            
            -- Mode Invisible
            RageUI.Checkbox('Mode Invisible', 'Rend votre personnage invisible aux autres joueurs', adminManagement.Invisible, {}, {
                onChecked = function()
                    print("[DEBUG] Checkbox cochée - Activation invisibilité")
                    adminManagement.Invisible = true
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        SetEntityVisible(playerPed, false, false)
                        SetLocalPlayerVisibleLocally(true)
                        SetEntityAlpha(playerPed, 0, false)
                        Wait(100)
                        SetEntityVisible(playerPed, false, false)
                        SetLocalPlayerVisibleLocally(true)
                    end)
                    ESX.ShowNotification('~g~Mode invisible activé')
                end,
                onUnChecked = function()
                    print("[DEBUG] Checkbox décochée - Désactivation invisibilité")
                    adminManagement.Invisible = false
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        ResetEntityAlpha(playerPed)
                        SetEntityVisible(playerPed, true, false)
                        Wait(100)
                        SetEntityVisible(playerPed, true, false)
                    end)
                    ESX.ShowNotification('~r~Mode invisible désactivé')
                end
            })
            
            -- Mode Invincible
            RageUI.Checkbox('Mode Invincible', 'Vous rend invincible aux dégâts', adminManagement.Invincible, {}, {
                onChecked = function()
                    print("[DEBUG] Checkbox cochée - Activation invincibilité")
                    adminManagement.Invincible = true
                    local playerPed = PlayerPedId()
                    SetEntityInvincible(playerPed, true)
                    SetPlayerInvincible(PlayerId(), true)
                    ESX.ShowNotification('~g~Mode invincible activé')
                end,
                onUnChecked = function()
                    print("[DEBUG] Checkbox décochée - Désactivation invincibilité")
                    adminManagement.Invincible = false
                    local playerPed = PlayerPedId()
                    SetEntityInvincible(playerPed, false)
                    SetPlayerInvincible(PlayerId(), false)
                    ESX.ShowNotification('~r~Mode invincible désactivé')
                end
            })
            
            RageUI.Line()
            if (Config.Staff.HavePermission('Modules', 'tptkt')) then
                RageUI.Button('List Points', nil, {}, true, {
                    onSelected = function()
                    end
                }, tpoints)
            end
            RageUI.Button('Se téléporter sur un marker', nil, {}, true, {
                onSelected = function()
                    local waypointHandle = GetFirstBlipInfoId(8)

                    if DoesBlipExist(waypointHandle) then
                        Citizen.CreateThread(function()
                            local waypointCoords = GetBlipInfoIdCoord(waypointHandle)
                            local foundGround, zCoords, zPos = false, -500.0, 0.0

                            while not foundGround do
                                zCoords = zCoords + 10.0
                                RequestCollisionAtCoord(waypointCoords.x, waypointCoords.y, zCoords)
                                Citizen.Wait(0)
                                foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, zCoords)

                                if not foundGround and zCoords >= 2000.0 then
                                    foundGround = true
                                end
                            end

                            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords.x, waypointCoords.y, zPos)
                        end)
                    else
                        ESX.ShowNotification('Aucun marker')
                    end
                end
            })
        end)

        RageUI.IsVisible(playersList, function()
            RageUI.Button('Rechercher', nil, {RightLabel = adminManagement.SearchPlayer or ''}, true, {
                onSelected = function()
                    KeyboardUtils.use('Rechercher', function(data)
                        adminManagement.SearchPlayer = data
                    end)
                end
            })
            if (adminManagement.SearchPlayer) then
                RageUI.Button('❌ Arrêter la Recherche', nil, {}, true, {
                    onSelected = function()
                        adminManagement.SearchPlayer = nil
                    end
                })
            end
            RageUI.Checkbox('Zone Uniquement', nil, adminManagement.ZoneShow, {}, {
                onChecked = function()
                    
                    if adminManagement.SearchPlayer == true then return end
                    adminManagement.ZoneShow = true
                end,
                onUnChecked = function()

                    if adminManagement.SearchPlayer == true then return end

                    adminManagement.ZoneShow = false
                end
            })
            if (not adminManagement.ZoneShow) then
                for k,v in pairs(adminManagement.Players) do
                    local playerName = ('[%s] %s (U ~r~%s~s~ | T ~r~%s~s~)'):format(v.group == 'user' and 'Joueur' or Config.Staff.Group[v.group], v.name, v.UniqueID, k)
                    if not adminManagement.SearchPlayer then
                        RageUI.Button(playerName, nil, {}, true, {
                            onSelected = function()
                                adminManagement.SelectedPlayer = v
                            end
                        }, selectedPlayer)
                    else
                        if string.match(string.lower(playerName), string.lower(adminManagement.SearchPlayer)) then 
                            RageUI.Button(playerName, nil, {}, true, {
                                onSelected = function()
                                    adminManagement.SelectedPlayer = v
                                end
                            }, selectedPlayer)
                        end
                    end
                end
            else
                for _, player in ipairs(GetActivePlayers()) do
                    local sID = GetPlayerServerId(player)
                    if (adminManagement.Players[sID]) then 
                        local playerName = ('[%s] %s (U ~r~%s~s~ | T ~r~%s~s~)'):format(adminManagement.Players[sID].group == 'user' and 'Joueur' or Config.Staff.Group[adminManagement.Players[sID].group], adminManagement.Players[sID].name == nil and '*Invalide*' or adminManagement.Players[sID].name, adminManagement.Players[sID].UniqueID, sID)
                        if adminManagement.SearchPlayer then 
                            if not adminManagement.ZoneShow then
                            if string.match(string.lower(playerName), string.lower(adminManagement.searchName)) then 
                                RageUI.Button(playerName, nil, {}, true, {
                                    onSelected = function()
                                        adminManagement.SelectedPlayer = adminManagement.Players[sID]
                                    end
                                }, selectedPlayer)
                            end
                        end
                        else
                            RageUI.Button(playerName, nil, {}, true, {
                                onSelected = function()
                                    adminManagement.SelectedPlayer = adminManagement.Players[sID]
                                end
                            }, selectedPlayer)
                        end
                    end
                end
            end
        end)

        RageUI.IsVisible(selectedPlayer, function()
            RageUI.Separator(('[%s] %s (U ~r~%s~s~ | T ~r~%s~s~)'):format(adminManagement.SelectedPlayer.group == 'user' and 'Joueur' or adminManagement.SelectedPlayer.group, adminManagement.SelectedPlayer.name, adminManagement.SelectedPlayer.UniqueID, adminManagement.SelectedPlayer.id))
            if (adminManagement.Players[adminManagement.SelectedPlayer.id] ~= nil) then
                if (Config.Staff.HavePermission('ManagePlayers', 'goto')) then
                    RageUI.Button('Se Téléporter', nil, {}, true, {
                        onSelected = function()
                            ExecuteCommand('goto '..adminManagement.SelectedPlayer.UniqueID)
                            -- TriggerServerEvent('sunny:admin:goto', adminManagement.SelectedPlayer.id)
                        end
                    })
                end
                if (Config.Staff.HavePermission('ManagePlayers', 'bring')) then
                    RageUI.Button('Téléporter sur moi', nil,  {}, true, {
                        onSelected = function()
                            ExecuteCommand('tp '..adminManagement.SelectedPlayer.UniqueID)
                            -- TriggerServerEvent('sunny:admin:bring', adminManagement.SelectedPlayer.id, GetEntityCoords(PlayerPedId()))
                            TriggerServerEvent('sunny:admin:getPosForRreturnPlayer', adminManagement.SelectedPlayer.id)
                        end
                    })
                end
                RageUI.Button('Retourner', nil, {}, true, {
                    onSelected = function()
                        if (adminManagement.LastPlayerPos[adminManagement.SelectedPlayer.id] == nil) then return end

                        TriggerServerEvent('sunny:admin:xPlayer.return', adminManagement.SelectedPlayer.id, adminManagement.LastPlayerPos[adminManagement.SelectedPlayer.id].pos)
                    end
                })

                if (Config.Staff.HavePermission('ManagePlayers', 'gopc')) then
                    RageUI.Button('Téléporter au Parking Central', nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent('sunny:admin:teleport', adminManagement.SelectedPlayer.id, vector3(234.06896972656, -756.89605712891, 37.856971740723))
                            ESX.ShowNotification('✅ Joueur téléporter avec succès')
                        end
                    })
                end
                if (Config.Staff.HavePermission('ManagePlayers', 'gomb')) then
                    RageUI.Button('Téléporter au dessus de la Maze Bank', nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent('sunny:admin:teleport', adminManagement.SelectedPlayer.id, vector3(-75.012283325195, -818.96472167969, 326.17532348633))
                            ESX.ShowNotification('✅ Joueur téléporter avec succès')
                        end
                    })
                end

                if Config.Staff.HavePermission('ManagePlayers', 'Message') then
                    RageUI.Button('Envoyer un message', nil, {}, true, {
                        onSelected = function()
                            KeyboardUtils.use('Message', function(data)
                                if data == nil or data == '' then return ESX.ShowNotification('Argument manquant') end
                                
                                TriggerServerEvent('sunny:staff:players:takeMessage', adminManagement.SelectedPlayer.id, data)
                            end)
                        end
                    })
                end
                RageUI.Line()
                RageUI.Button("Sortir de l'instance (Bucket)", "Bucket 0", {}, true, {
                    onSelected = function()
                        TriggerServerEvent('sunny:admin:sortBucket', adminManagement.SelectedPlayer.id)
                        ESX.ShowNotification('Vous avez sortie la personne du bucket')
                    end
                })
                if (Config.Staff.HavePermission('ManagePlayers', 'spectate')) then
                    RageUI.Button('Spectate', nil, {}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                            Wait(750)
                            TriggerServerEvent('sunny:admin:spectatePlayer', tonumber(adminManagement.SelectedPlayer.UniqueID))
                        end
                    })
                end
                RageUI.Button('Freeze Unfreeze', nil, {}, true, {
                    onSelected = function()
                        if (adminManagement.FreezeUnfreeze) then
                            adminManagement.FreezeUnfreeze = false
                            TriggerServerEvent('sunny:admin:freezeunfreezeplayer', adminManagement.SelectedPlayer.id, 'unfreeze')
                            ESX.ShowNotification('✅ Joueur unfreeze avec succès')
                        else
                            adminManagement.FreezeUnfreeze = true
                            TriggerServerEvent('sunny:admin:freezeunfreezeplayer', adminManagement.SelectedPlayer.id, 'freeze')
                            ESX.ShowNotification('✅ Joueur freeze avec succès')
                        end
                    end
                })

                if (Config.Staff.HavePermission('ManagePlayers', 'revive')) then
                    RageUI.Button('Revive', nil, {}, true, {
                        onSelected = function()
                            ExecuteCommand("revive " ..adminManagement.SelectedPlayer.UniqueID)
                            ESX.ShowNotification('✅ Joueur revive avec succès')
                        end
                    })
                end
                if (Config.Staff.HavePermission('ManagePlayers', 'heal')) then
                    RageUI.Button('Heal', nil, {}, true, {
                        onSelected = function()
                            ExecuteCommand("heal " ..adminManagement.SelectedPlayer.UniqueID)
                            ESX.ShowNotification('✅ Joueur heal avec succès')
                        end
                    })

                if (Config.Staff.HavePermission('ManagePlayers', 'playerinformations')) then
                    RageUI.Button('Informations', nil, {}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback('sunny:admin.getAccounts', function(cb)
                                adminManagement.accounts = cb
                            
                            end, adminManagement.SelectedPlayer.UniqueID)
                        end
                    }, infoPlayer)
                end
                -- if (Config.Staff.HavePermission('ManagePlayers', 'screen')) then
                --     RageUI.Button('Screen', nil, {}, true, {
                --         onSelected = function()
                --             TriggerServerEvent('sunny:admin:screen', adminManagement.SelectedPlayer.id)
                --             ESX.ShowNotification('📷 Vous retrouverez le screen dans les logs')
                --         end
                --     })
                -- end

                end
                if (Config.Staff.HavePermission('ManagePlayers', 'givepanto')) then
                    RageUI.Button('Donner Panto', nil, {}, not adminManagement.cooldown, {
                        onSelected = function()
                            TriggerServerEvent('sunny:admin:spawnVehicle', adminManagement.SelectedPlayer.id, 'panto')
                            adminManagement.cooldown = true
                            SetTimeout(2500, function()
                                adminManagement.cooldown = false
                            end)
                            ESX.ShowNotification('✅ Véhicule give avec succès')
                        end
                    })
                end
                RageUI.Line()
                if (Config.Staff.HavePermission('ManagePlayers', 'WARN')) then
                    RageUI.Button('Mettre un Avertissement', nil, {}, true, {
                        onSelected = function()
                            KeyboardUtils.use('Raison', function(data)
                                ExecuteCommand(('warn %s %s'):format(adminManagement.SelectedPlayer.UniqueID, data))
                            end)
                        end
                    })
                    RageUI.Button('Voir la liste des Warns', nil, {}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback('sunny:admin:getWarnList', function(cb)
                                adminManagement.WarnList = cb
                            end, adminManagement.SelectedPlayer.UniqueID)
                        end
                    }, WarnListPlayer)
                end
                if (Config.Staff.HavePermission('ManagePlayers', 'heal')) then
                    RageUI.Button('Jail le Joueur', nil, {}, true, {
                        onSelected = function()
                            KeyboardUtils.use('Temps', function(data)
                                if data == nil or data == '' then
                                    return
                                end
                
                                CreateThread(function()
                                    KeyboardUtils.use('Raison', function(raison)
                                        if raison == nil or raison == '' then
                                            return
                                        end
                
                                        exports['prompt']:createPrompt(
                                            SunnyConfigServ.ServerName,
                                            'Voulez-vous jail le joueur ?', 
                                            '',
                                            function(response)
                                                if response then -- Oui
                                                    ExecuteCommand(('jail %s %s %s'):format(adminManagement.SelectedPlayer.UniqueID, data, raison))
                                                else -- Non
                                                    ESX.ShowNotification("Vous avez annulé l'action") 
                                                end
                                            end
                                        )
                                    end)
                                end)
                            end)
                        end
                    })
                
                end
                if (Config.Staff.HavePermission('ManagePlayers', 'heal')) then
                    RageUI.Button('Unjail le Joueur', nil, {}, true, {
                        onSelected = function()
                                ExecuteCommand(('unjail %s'):format(adminManagement.SelectedPlayer.UniqueID))
                    end
                    })
                end
                if (Config.Staff.HavePermission('ManagePlayers', 'heal')) then
                    RageUI.Button('Kick le Joueur', nil, {}, true, {
                        onSelected = function()
                            KeyboardUtils.use('Raison', function(data)
                                if data == nil or data == '' then
                                    return
                                end
                                exports['prompt']:createPrompt(
                                    SunnyConfigServ.ServerName,
                                    'Voulez-vous kick le joueur ?',
                                    '',
                                    function(response)
                                        if response then -- Oui
                                            ExecuteCommand(('kick %s %s'):format(adminManagement.SelectedPlayer.UniqueID, data))
                                        else -- Non
                                            ESX.ShowNotification("Vous avez annulé l'action")
                                        end
                                    end
                                )
                            end)
                        end
                    })
                end
                if (Config.Staff.HavePermission('COMMANDS', 'BAN')) then
                    RageUI.Button('Ban le Joueur', nil, {}, true, {
                        onSelected = function()
                            KeyboardUtils.use('Temps (heures, 0 pour permanent)', function(data)
                                if data == nil or data == '' then
                                    return
                                end
                
                                CreateThread(function()
                                    KeyboardUtils.use('Raison', function(raison)
                                        if raison == nil or raison == '' then
                                            return
                                        end
                
                                        exports['prompt']:createPrompt(
                                            SunnyConfigServ.ServerName,
                                            'Voulez-vous ban le joueur ?', 
                                            '',
                                            function(response)
                                                if response then
                                                    ExecuteCommand(('ban %s %s %s'):format(adminManagement.SelectedPlayer.UniqueID, data, raison))
                                                else
                                                    ESX.ShowNotification("Vous avez annulé l'action") 
                                                end
                                            end
                                        )
                                    end)
                                end)
                            end)
                        end
                    })
                end
                    if (Config.Staff.HavePermission('ManagePlayers', 'wipe')) then
                    RageUI.Button('Wipe le joueur', nil, {}, true, {
                        onSelected = function()
                            exports['prompt']:createPrompt(
                                SunnyConfigServ.ServerName,
                                'Voulez-vous wipe le joueur ?', 
                                '',
                                function(response)
                                    if response then -- Oui
                                        TriggerServerEvent('sunny:admin:players:wipeUniqueID', adminManagement.SelectedPlayer.UniqueID)
                                    else -- Non
                                        ESX.ShowNotification("Vous avez annulé l'action")
                                    end
                                end
                            )
                        end
                    })
                end
                

                RageUI.Line()
                if (Config.Staff.HavePermission('ManagePlayers', 'clearinventory')) then
                    RageUI.Button('Clear l\'inventaire', nil, {}, true, {
                        onSelected = function()
                            exports['prompt']:createPrompt(
                                SunnyConfigServ.ServerName, 
                                'Êtes-vous sûr de vouloir vider l\'inventaire de ce joueur ?',
                                '',
                                function(response)
                                    if response then -- Oui
                                        TriggerServerEvent('sunny:admin:clearInventory', adminManagement.SelectedPlayer.id)
                                    else -- Non
                                        ESX.ShowNotification("Vous avez annulé l'action") 
                                    end
                                end
                            )
                        end
                    })
                end
                
                if (Config.Staff.HavePermission('ManagePlayers', 'clearweapons')) then
                    RageUI.Button('Clear les armes', nil, {}, true, {
                        onSelected = function()
                            exports['prompt']:createPrompt(
                                SunnyConfigServ.ServerName,
                                'Voulez-vous retirer toutes les armes de ce joueur ?',
                                '',
                                function(response) 
                                    if response then -- Oui
                                        TriggerServerEvent('sunny:admin:clearWeapon', adminManagement.SelectedPlayer.id)
                                    else -- Non
                                        ESX.ShowNotification("Vous avez annulé l'action")
                                    end
                                end
                            )
                        end
                    })
                end
                
                RageUI.Line()
                if (Config.Staff.HavePermission('ManagePlayers', 'changejob')) then
                    RageUI.Button('Changer le job', nil, {}, true, {
                        onSelected = function()

                        end
                    }, addJobPlayer)
                end
                if (Config.Staff.HavePermission('ManagePlayers', 'changegroup')) then
                    RageUI.Button('Changer Groupe', nil, {}, true, {
                        onSelected = function()
                            
                        end
                    }, changePlayerGroup)
                end
            end
        end)
            RageUI.IsVisible(infoPlayer, function()
                RageUI.Button(('Prénom :  '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(adminManagement.SelectedPlayer.name), nil, {}, true, {
                    onSelected = function()
                    end
                })
                -- RageUI.Button(('Nom '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(adminManagement.SelectedPlayer.label), nil, {}, true, {
                --     onSelected = function()
                --     end
                -- })

                -- RageUI.Button(('Date de naissance '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(adminManagement.SelectedPlayer.dateofbirth), nil, {}, true, {
                --     onSelected = function()
                --     end
                -- })

                -- RageUI.Button(('Sexe '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(adminManagement.SelectedPlayer.sex), nil, {}, true, {
                --     onSelected = function()
                --     end
                -- })



                RageUI.Button(('Identifiant Unique :  '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(adminManagement.SelectedPlayer.UniqueID), nil, {}, true, {
                    onSelected = function()
                    end
                })

                RageUI.Button(('Groupes :  '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(adminManagement.SelectedPlayer.group), nil, {}, true, {
                    onSelected = function()
                    end
                })
                RageUI.Button(('Entreprise :  '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(adminManagement.SelectedPlayer.job.label), nil, {}, true, {
                    onSelected = function()
                    end
                })
                RageUI.Button(('Gang/Organisation :  '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(adminManagement.SelectedPlayer.job2.label), nil, {}, true, {
                    onSelected = function()
                    end
                })
                for k,v in pairs(adminManagement.accounts) do
                if v.cash then
                    RageUI.Button(('Cash :  '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(v.cash), nil, {}, true, {

                    })
                end
                if v.bank then
                    RageUI.Button(('Bank :  '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(v.bank), nil, {}, true, {

                    })
                end
                if v.black_money then
                    RageUI.Button(('Argent Sale :  '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(v.black_money), nil, {}, true, {

                    })
                end
            end
        end)

        RageUI.IsVisible(tpoints, function()
            for _, location in ipairs(SunnyTPAdmin.TeleportLocations) do
                RageUI.Button(location.label, nil, {}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName,
                            'Êtes-vous sûr de vouloir vous téléporter à ' .. location.label .. ' ?',
                            '',
                            function(response)
                                if response then -- Oui
                                    SetEntityCoords(PlayerPedId(), location.coords.x, location.coords.y, location.coords.z, false, false, false, false)
                                    ESX.ShowNotification("Vous avez été téléporté à " .. location.label)
                                else -- Non
                                    ESX.ShowNotification("Vous avez annulé l'action")
                                end
                            end
                        )
                    end
                })
            end
        end)
        
        

        RageUI.IsVisible(accountsPlayer, function()
            for k,v in pairs(adminManagement.accounts) do
                if v.cash then
                    RageUI.Button(('Cash '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(v.cash), nil, {}, true, {

                    })
                end
                if v.bank then
                    RageUI.Button(('Bank '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(v.bank), nil, {}, true, {

                    })
                end
                if v.black_money then
                    RageUI.Button(('Argent Sale '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(v.black_money), nil, {}, true, {

                    })
                end
            end
        end)
        
        RageUI.IsVisible(jobPlayer, function()
            RageUI.Button(('Entreprise '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(adminManagement.SelectedPlayer.job.label), nil, {}, true, {
                onSelected = function()
                end
            })
            RageUI.Button(('Gang/Organisation '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(adminManagement.SelectedPlayer.job2.label), nil, {}, true, {
                onSelected = function()
                end
            })
        end)

        
        RageUI.IsVisible(addJobPlayer, function()
            RageUI.Button('Changer le job en Entreprise', nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:admin:getAllJobs', function(cb)
                        adminManagement.SelectedJobType = 1
                        adminManagement.AddJobList = cb
                    end)
                end
            }, addJobPlayerList)
            RageUI.Button('Changer le job en Gang/Organisation', nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:admin:getAllJobs', function(cb)
                        adminManagement.SelectedJobType = 0
                        adminManagement.AddJobList = cb
                    end)
                end
            }, addJobPlayerList)
        end)

        RageUI.IsVisible(addJobPlayerList, function()
            RageUI.Button('Rechercher', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom/Label/Id du job', function(data)
                        adminManagement.AddSearchJob = data
                    end)
                end
            })
            if (adminManagement.AddSearchJob) then
                RageUI.Button('❌ Arrêter la Recherche', nil, {}, true, {
                    onSelected = function()
                        adminManagement.AddSearchJob = nil
                    end
                })
            end
            for k,v in pairs(adminManagement.AddJobList) do
                local jobData = ('[%s] %s (%s)'):format(k, v.name, v.label)
                if tonumber(v.type) == tonumber(adminManagement.SelectedJobType) then
                    if (not adminManagement.AddSearchJob) then
                        RageUI.Button(jobData, nil, {}, true, {
                            onSelected = function()
                                ESX.TriggerServerCallback('sunny:admin:getGradeWithJob', function(cb)
                                    adminManagement.AddGradeListWithJob = cb
                                    adminManagement.SelectedPlayerJobList = v
                                end, v.name)
                            end
                        }, addJobGradeWithJobList)
                    else
                        if (string.match(string.lower(jobData), string.lower(adminManagement.AddSearchJob))) then 
                            RageUI.Button(jobData, nil, {}, true, {
                                onSelected = function()
                                    ESX.TriggerServerCallback('sunny:admin:getGradeWithJob', function(cb)
                                        adminManagement.AddGradeListWithJob = cb
                                        adminManagement.SelectedPlayerJobList = v
                                    end, v.name)
                                end
                            }, addJobGradeWithJobList)
                        end
                    end
                end
            end
        end)

        RageUI.IsVisible(addJobGradeWithJobList, function()
            for k, v in pairs(adminManagement.AddGradeListWithJob) do
                RageUI.Button(('[%s] %s (%s)'):format(v.grade, v.name, v.label), nil, {}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName,
                            'Êtes-vous sûr de vouloir définir ce grade pour ce joueur ?',
                            '',
                            function(response)
                                if response then -- Oui
                                    local jobType = tonumber(adminManagement.SelectedJobType) == 0 and 'job2' or 'job'
                                    TriggerServerEvent('sunny:admin:setPlayerJob', adminManagement.SelectedPlayer.id, adminManagement.SelectedPlayerJobList.name, v.grade, jobType)
                                    ESX.ShowNotification('✅ Joueur setJob avec succès')
                                else -- Non 
                                    ESX.ShowNotification('Vous avez annulé l\'action')
                                end
                            end
                        )
                    end
                })
            end
        end)
        

        RageUI.IsVisible(changePlayerGroup, function()
            Config.Staff.Permissions['ServerGroup'][ESX.GetPlayerData().group] = sortGroupTable(Config.Staff.Permissions['ServerGroup'][ESX.GetPlayerData().group])
            for k,v in pairs(Config.Staff.Permissions['ServerGroup'][ESX.GetPlayerData().group]) do
                RageUI.Button(v.label, nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent('sunny:admin:setGroup', adminManagement.SelectedPlayer.id, v.value)
                        ESX.ShowNotification('✅ Joueur setgroup avec succès')
                    end
                })
            end
        end)

        RageUI.IsVisible(vehiclesOptions, function()
            if (Config.Staff.HavePermission('VehiclesOptions', 'delveh')) then
                RageUI.Button('Supprimer le véhicule', nil, {}, true, {
                    onActive = function()
                        ClosetVehWithDisplay()
                    end,
                    onSelected = function()
                        local veh = ESX.Game.GetClosestVehicle(Player.coords)

                        TriggerServerEvent('sunny:admin:delVeh', NetworkGetNetworkIdFromEntity(veh))

                        ESX.ShowNotification('✅ Véhicule supprimé avec succès')
                    end
                })
            end
            if (Config.Staff.HavePermission('VehiclesOptions', 'delvehzone')) then
                RageUI.Button('Supprimer véhicules ( zone )', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Définir une zone', function(data)
                            local data = tonumber(data)

                            if data == nil then return ESX.ShowNotification("🚨 Vous devez indiquer un nombre") end

                            local veh = ESX.Game.GetVehiclesInArea(Player.coords, data)

                            for i= 1, #veh, 1 do
                                TriggerServerEvent('sunny:admin:delVeh', NetworkGetNetworkIdFromEntity(veh[i]))
                            end
    
                            ESX.ShowNotification(('✅ Véhicules supprimés dans une zone de %s mètre'):format(data))
                        end)
                    end
                })
            end
            if (Config.Staff.HavePermission('VehiclesOptions', 'repairvehzone')) then
                RageUI.Button('Réparer véhicules ( zone )', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Définir une zone', function(data)
                            local data = tonumber(data)

                            if data == nil then return ESX.ShowNotification("🚨 Vous devez indiquer un nombre") end

                            local veh = ESX.Game.GetVehiclesInArea2(GetEntityCoords(PlayerPedId()), data)

                            for i= 1, #veh, 1 do
                                TriggerServerEvent('sunny:admin:repairVeh', veh[i])
                            end
    
                            ESX.ShowNotification(('✅ Véhicules réparés dans une zone de %s mètre'):format(data))
                        end)
                    end
                })
            end
            if (Config.Staff.HavePermission('VehiclesOptions', 'repairveh')) then
                RageUI.Button('Réparer le véhicule', nil, {}, true, {
                    onActive = function()
                        ClosetVehWithDisplay()
                    end,
                    onSelected = function()
                        local veh = ESX.Game.GetClosestVehicle(Player.coords)
                        if not (veh) then
                            ESX.ShowNotification('🚨 Aucun véhicule au alentours')
                        else
                            TriggerServerEvent('sunny:admin:repairVeh', veh)
                        ESX.ShowNotification('✅ Véhicule réparé avec succès')
                        end
                    end
                })
            end
            if (Config.Staff.HavePermission('VehiclesOptions', 'cleanVehicle')) then
                RageUI.Button('Nettoyer le véhicule', nil, {}, true, {
                    onSelected = function()
                        local veh = ESX.Game.GetClosestVehicle(Player.coords)
                        SetVehicleDirtLevel(veh, 0)

                        ESX.ShowNotification('✅ Véhicule nettoyé avec succès')
                    end
                })
            end
            if (Config.Staff.HavePermission('VehiclesOptions', 'spawnveh')) then
            RageUI.Button("Crocheter le véhicule", nil, {}, true, {
                onSelected = function()
                    local veh = ESX.Game.GetClosestVehicle(Player.coords)
                    NetworkRequestControlOfEntity(veh)
                    local gameTimer = GetGameTimer()
                    while not NetworkHasControlOfEntity(veh) and gameTimer + 2000 > GetGameTimer() do
                        Citizen.Wait(0)
                    end
                    ESX.ShowNotification("Vous avez ~g~déverrouillé~s~ le véhicule.")
                    SetVehicleDoorsLockedForAllPlayers(veh, false)
                    SetEntityAsMissionEntity(veh, true, true)
                    SetVehicleDoorsLocked(veh, 1)
                    SetVehicleHasBeenOwnedByPlayer(veh, true)
                end
            })
            end
            if (Config.Staff.HavePermission('VehiclesOptions', 'spawnveh')) then
                RageUI.Button('Spawn un véhicule', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Model', function(data)
                            TriggerServerEvent('sunny:admin:spawnVehicle', GetPlayerServerId(PlayerId()), data)
                        end)
                    end
                })
            end
            if (Config.Staff.HavePermission('VehiclesOptions', 'fullcustom')) then
                RageUI.Button('Upgrade le véhicule au max', nil, {}, true, {
                    onActive = function()
                        ClosetVehWithDisplay()
                    end,
                    onSelected = function()
                        local veh = ESX.Game.GetClosestVehicle(Player.coords)

                        TriggerServerEvent('sunny:admin:fullCustomVeh', veh)
                        ESX.ShowNotification('✅ Véhicule upgrade avec succès')
                    end
                })
            end
            if (Config.Staff.HavePermission('VehiclesOptions', 'returnveh')) then
            RageUI.Button("Essence maximum", nil, {}, true, {
                onSelected = function()
                    local veh = ESX.Game.GetClosestVehicle(Player.coords)
                    if veh and DoesEntityExist(veh) then
                        if exports and exports['fuel'] and exports['fuel'].SetFuel then
                            exports['fuel']:SetFuel(veh, 100.0)
                            ESX.ShowNotification('✅ Le véhicule a maintenant le plein d\'essence.')
                        else
                            ESX.ShowNotification('🚨 Le système de gestion du carburant est introuvable ou non initialisé.')
                        end
                    else
                        ESX.ShowNotification('🚨 Aucun véhicule à proximité.')
                    end
                end
            })
            end
            if (Config.Staff.HavePermission('VehiclesOptions', 'returnveh')) then
                RageUI.Button('Retourner le véhicule', nil, {}, true, {
                    onActive = function()
                        ClosetVehWithDisplay()
                    end,
                    onSelected = function()
                        local veh = ESX.Game.GetClosestVehicle(Player.coords)
                        if not (veh) then
                            ESX.ShowNotification('🚨 Aucun véhicule au alentours')
                        else
                            TriggerServerEvent("sunny:admin:returnveh", NetworkGetNetworkIdFromEntity(veh))
                            ESX.ShowNotification('✅ Véhicule retourner avec succès')
                        end
                    end
                }) 
            end
            if (Config.Staff.HavePermission('VehiclesOptions', 'freezeunfreeze')) then
                RageUI.Button('Freeze Unfreeze le véhicule', nil, {}, true, {
                    onActive = function()
                        ClosetVehWithDisplay()
                    end,
                    onSelected = function()
                        local veh = ESX.Game.GetClosestVehicle(Player.coords)
                        if IsEntityPositionFrozen(veh) then
                            TriggerServerEvent('sunny:admin:freezeunfreezevehicle', NetworkGetNetworkIdFromEntity(veh), false)
                            ESX.ShowNotification('✅ Véhicule unfreeze avec succès')
                        else
                            TriggerServerEvent('sunny:admin:freezeunfreezevehicle', NetworkGetNetworkIdFromEntity(veh), true)
                            ESX.ShowNotification('✅ Véhicule freeze avec succès')
                        end
                    end
                })
            end
        end)

        RageUI.IsVisible(serverOptions, function()

            RageUI.Button('Créer une société', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                end
            }, openCreateSociety)
        
            RageUI.Button('Modifier une société', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    adminManagement.SocietyMode = 'edit'
                end
            }, openEditSociety)

            RageUI.Button('Supprimer une société', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    adminManagement.SocietyMode = 'delete'
                end
            }, openEditSociety)

            RageUI.Button('Créer un job farm', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                end
            }, openCreateFarm)
        
            RageUI.Line()
        
            if Config.Staff.HavePermission('ServerOptions', 'fondateur') then
                RageUI.Button('Gérer les véhicules et catégories des concessionnaires', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('sunny:admin:dealership:refreshvehicleslist', function(cb)
                            if type(cb) == "table" then
                                adminManagement.DealerShipVehicles = cb
                            end
                        end)
                    end
                }, manageVehicleConcess)
            end
        
            RageUI.Line()
        
            RageUI.Button("Gestion Neva Drugs", "Ouvrir le menu de gestion des territoires et drogues", {}, true, {
                onSelected = function()
                    RageUI.CloseAll()
                    ExecuteCommand('territories')
                end
            })
        
            if Config.Staff.HavePermission('ServerOptions', 'creategang') then
                RageUI.Button('Gérer les groupes', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        RageUI.CloseAll()
                        ExecuteCommand('gangbuilder')
                    end
                })
            end
        
            if Config.Staff.HavePermission('ServerOptions', 'CreateBlanchiment') then
                RageUI.Button('Gérer les bâtiments de blanchiment', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        RageUI.CloseAll()
                        ExecuteCommand('blanchiment')
                    end
                })
            end
        
            if Config.Staff.HavePermission('ServerOptions', 'weaponsSell') then
                RageUI.Button('Gérer la vente d\'arme', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('sunny:weapons:getSelling', function(cb)
                            adminManagement.SellingList = cb
                            RageUI.Visible(weaponsSell, true)
                        end)
                    end
                })
            end
        
            RageUI.Line()
        
            if Config.Staff.HavePermission('ServerOptions', 'creategang') then
                RageUI.Button('Créer un doorlock', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        RageUI.CloseAll()
                        ExecuteCommand('doorlock')
                    end
                })
            end

            RageUI.Line()

        end)

        RageUI.IsVisible(createDrugs, function()
            RageUI.Button('Créé Circuit', nil, {}, true, {
                RageUI.Button('❌ Arrêter la Recherche', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        adminManagement.ArmurerieSearch = nil
                    end
                })
            })

            RageUI.Line()

            for k, v in pairs(adminManagement.ArmurerieListe) do
                local armurerieLabel = ('Armurerie #%s - %s'):format(v.id or k, v.label or 'Sans nom')
                local showItem = true

                if adminManagement.ArmurerieSearch then
                    showItem = string.match(string.lower(armurerieLabel), string.lower(adminManagement.ArmurerieSearch))
                end

                if showItem then
                    RageUI.Button(armurerieLabel, nil, {RightLabel = '→→'}, true, {
                        onActive = function()
                            if v.x and v.y and v.z then
                                DrawMarker(1, v.x, v.y, v.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 200, false, false, 2, false, nil, nil, false)
                            end
                        end,
                        onSelected = function()
                            adminManagement.SelectedArmurerie = v
                        end
                    }, gestionArmureriesSelected)
                end
            end
        end)

        RageUI.IsVisible(gestionArmureriesSelected, function()
            if not adminManagement.SelectedArmurerie then return end
            local armurerie = adminManagement.SelectedArmurerie

            RageUI.Separator(('~b~%s~s~'):format(armurerie.label or 'Armurerie'))

            RageUI.Button('Modifier le nom', nil, {RightLabel = armurerie.label or '~r~Non défini~s~'..'→→'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nouveau nom', function(data)
                        if not data or data == '' then return end
                        TriggerServerEvent('sunny:admin:armureries:updateLabel', armurerie.id, data)
                        armurerie.label = data
                        ESX.ShowNotification('~g~Nom modifié')
                    end)
                end
            })

            RageUI.Button('Modifier la position', 'Se téléporter et définir votre position actuelle', {RightLabel = armurerie.x and '~g~Défini~s~' or '~r~Non défini~s~'..'→→'}, true, {
                onSelected = function()
                    local coords = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('sunny:admin:armureries:updatePosition', armurerie.id, coords.x, coords.y, coords.z)
                    armurerie.x = coords.x
                    armurerie.y = coords.y
                    armurerie.z = coords.z
                    ESX.ShowNotification('~g~Position mise à jour')
                end
            })

            RageUI.Button('Se téléporter', nil, {RightLabel = '→→'}, true, {
                onSelected = function()
                    if armurerie.x and armurerie.y and armurerie.z then
                        SetEntityCoords(PlayerPedId(), armurerie.x, armurerie.y, armurerie.z, false, false, false, false)
                        ESX.ShowNotification('~g~Téléportation effectuée')
                    else
                        ESX.ShowNotification('~r~Position non définie')
                    end
                end
            })

            RageUI.Line()

            RageUI.Button('ID du Blip', nil, {RightLabel = tostring(armurerie.blip_id or 110)..'→→'}, true, {
                onSelected = function()
                    KeyboardUtils.use('ID du Blip (ex: 110)', function(data)
                        local blipId = tonumber(data)
                        if not blipId then return ESX.ShowNotification('~r~ID invalide') end
                        TriggerServerEvent('sunny:admin:armureries:updateBlip', armurerie.id, 'blip_id', blipId)
                        armurerie.blip_id = blipId
                        ESX.ShowNotification('~g~Blip modifié')
                    end)
                end
            })

            RageUI.Button('Couleur du Blip', nil, {RightLabel = tostring(armurerie.blip_color or 1)}, true, {
                onSelected = function()
                    KeyboardUtils.use('Couleur du Blip (0-85)', function(data)
                        local blipColor = tonumber(data)
                        if not blipColor then return ESX.ShowNotification('~r~Couleur invalide') end
                        TriggerServerEvent('sunny:admin:armureries:updateBlip', armurerie.id, 'blip_color', blipColor)
                        armurerie.blip_color = blipColor
                        ESX.ShowNotification('~g~Couleur modifiée')
                    end)
                end
            })

            RageUI.Line()

            RageUI.Button('~r~Supprimer cette armurerie', nil, {}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Êtes-vous sûr de vouloir supprimer cette armurerie ?',
                        '',
                        function(response)
                            if response then
                                TriggerServerEvent('sunny:admin:armureries:delete', armurerie.id)
                                ESX.ShowNotification('~g~Armurerie supprimée')
                                RageUI.GoBack()
                                ESX.TriggerServerCallback('sunny:admin:armureries:getAll', function(data)
                                    adminManagement.ArmurerieListe = data or {}
                                end)
                            end
                        end
                    )
                end
            })
        end)

        RageUI.IsVisible(gestionArmureriesItems, function()
            RageUI.Button('Rechercher', nil, {RightLabel = adminManagement.ArmurerieItemSearch or ''}, true, {
                onSelected = function()
                    KeyboardUtils.use('Rechercher', function(data)
                        adminManagement.ArmurerieItemSearch = data
                    end)
                end
            })

            if adminManagement.ArmurerieItemSearch then
                RageUI.Button('❌ Arrêter la Recherche', nil, {}, true, {
                    onSelected = function()
                        adminManagement.ArmurerieItemSearch = nil
                    end
                })
            end

            RageUI.Line()

            for k, v in pairs(adminManagement.ArmurerieItems) do
                local itemLabel = ('%s - ~g~%s$~s~'):format(v.label or v.name, ESX.Math.GroupDigits(v.price or 0))
                local showItem = true

                if adminManagement.ArmurerieItemSearch then
                    showItem = string.match(string.lower(itemLabel), string.lower(adminManagement.ArmurerieItemSearch))
                end

                if showItem then
                    RageUI.Button(itemLabel, ('Catégorie: %s'):format(v.category or 'armes'), {RightLabel = '→'}, true, {
                        onSelected = function()
                            adminManagement.SelectedArmurerieItem = v
                        end
                    }, gestionArmureriesItemSelected)
                end
            end
        end)

        RageUI.IsVisible(gestionArmureriesItemSelected, function()
            if not adminManagement.SelectedArmurerieItem then return end
            local item = adminManagement.SelectedArmurerieItem

            RageUI.Separator(('~b~%s~s~'):format(item.label or item.name))

            RageUI.Button('Modifier le label', nil, {RightLabel = item.label or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nouveau label', function(data)
                        if not data or data == '' then return end
                        TriggerServerEvent('sunny:admin:armureries:updateItem', item.id, 'label', data)
                        item.label = data
                        ESX.ShowNotification('~g~Label modifié')
                    end)
                end
            })

            RageUI.Button('Modifier le nom (item)', nil, {RightLabel = item.name or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom de l\'item', function(data)
                        if not data or data == '' then return end
                        TriggerServerEvent('sunny:admin:armureries:updateItem', item.id, 'name', data)
                        item.name = data
                        ESX.ShowNotification('~g~Nom modifié')
                    end)
                end
            })

            RageUI.Button('Modifier le prix', nil, {RightLabel = ('~g~%s$~s~'):format(ESX.Math.GroupDigits(item.price or 0))}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nouveau prix', function(data)
                        local price = tonumber(data)
                        if not price then return ESX.ShowNotification('~r~Prix invalide') end
                        TriggerServerEvent('sunny:admin:armureries:updateItem', item.id, 'price', price)
                        item.price = price
                        ESX.ShowNotification('~g~Prix modifié')
                    end)
                end
            })

            RageUI.Button('Modifier la catégorie', nil, {RightLabel = item.category or 'armes'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Catégorie (armes/munitions)', function(data)
                        if not data or data == '' then return end
                        TriggerServerEvent('sunny:admin:armureries:updateItem', item.id, 'category', data)
                        item.category = data
                        ESX.ShowNotification('~g~Catégorie modifiée')
                    end)
                end
            })

            RageUI.Line()

            RageUI.Button('~r~Supprimer cet article', nil, {}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Êtes-vous sûr de vouloir supprimer cet article ?',
                        '',
                        function(response)
                            if response then
                                TriggerServerEvent('sunny:admin:armureries:deleteItem', item.id)
                                ESX.ShowNotification('~g~Article supprimé')
                                RageUI.GoBack()
                                ESX.TriggerServerCallback('sunny:admin:armureries:getItems', function(data)
                                    adminManagement.ArmurerieItems = data or {}
                                end)
                            end
                        end
                    )
                end
            })
        end)

        RageUI.IsVisible(gestionArmureriesCreate, function()
            RageUI.Separator('~g~Créer une Armurerie~s~')

            RageUI.Button('Nom de l\'armurerie', nil, {RightLabel = adminManagement.NewArmurerie.label or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom', function(data)
                        if data and data ~= '' then
                            adminManagement.NewArmurerie.label = data
                        end
                    end)
                end
            })

            RageUI.Button('ID du Blip', nil, {RightLabel = tostring(adminManagement.NewArmurerie.blipId)}, true, {
                onSelected = function()
                    KeyboardUtils.use('ID Blip (110 = arme)', function(data)
                        local id = tonumber(data)
                        if id then adminManagement.NewArmurerie.blipId = id end
                    end)
                end
            })

            RageUI.Button('Couleur du Blip', nil, {RightLabel = tostring(adminManagement.NewArmurerie.blipColor)}, true, {
                onSelected = function()
                    KeyboardUtils.use('Couleur (0-85)', function(data)
                        local color = tonumber(data)
                        if color then adminManagement.NewArmurerie.blipColor = color end
                    end)
                end
            })

            RageUI.Line()

            if adminManagement.NewArmurerie.label then
                RageUI.Button('~g~Créer à ma position', nil, {Color = {BackgroundColor = {0, 200, 0, 150}}}, true, {
                    onSelected = function()
                        local coords = GetEntityCoords(PlayerPedId())
                        TriggerServerEvent('sunny:admin:armureries:create', {
                            label = adminManagement.NewArmurerie.label,
                            x = coords.x,
                            y = coords.y,
                            z = coords.z,
                            blip_id = adminManagement.NewArmurerie.blipId,
                            blip_color = adminManagement.NewArmurerie.blipColor,
                            blip_scale = adminManagement.NewArmurerie.blipScale,
                        })
                        ESX.ShowNotification('~g~Armurerie créée avec succès')
                        RageUI.GoBack()
                        Wait(500)
                        ESX.TriggerServerCallback('sunny:admin:armureries:getAll', function(data)
                            adminManagement.ArmurerieListe = data or {}
                        end)
                    end
                })
            else
                RageUI.Button('~r~Créer (nom requis)', nil, {}, false, {})
            end
        end)

        RageUI.IsVisible(gestionArmureriesAddItem, function()
            RageUI.Separator('~g~Ajouter un Article~s~')

            RageUI.Button('Label', nil, {RightLabel = adminManagement.NewArmurerieItem.label or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Label (affiché)', function(data)
                        if data and data ~= '' then
                            adminManagement.NewArmurerieItem.label = data
                        end
                    end)
                end
            })

            RageUI.Button('Nom item', nil, {RightLabel = adminManagement.NewArmurerieItem.name or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom item (ex: WEAPON_PISTOL)', function(data)
                        if data and data ~= '' then
                            adminManagement.NewArmurerieItem.name = data
                        end
                    end)
                end
            })

            RageUI.Button('Prix', nil, {RightLabel = adminManagement.NewArmurerieItem.price and ('~g~%s$~s~'):format(ESX.Math.GroupDigits(adminManagement.NewArmurerieItem.price)) or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Prix', function(data)
                        local price = tonumber(data)
                        if price then adminManagement.NewArmurerieItem.price = price end
                    end)
                end
            })

            RageUI.Button('Catégorie', nil, {RightLabel = adminManagement.NewArmurerieItem.category or 'armes'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Catégorie (armes/munitions)', function(data)
                        if data and data ~= '' then
                            adminManagement.NewArmurerieItem.category = data
                        end
                    end)
                end
            })

            RageUI.Line()

            local canCreate = adminManagement.NewArmurerieItem.label and adminManagement.NewArmurerieItem.name and adminManagement.NewArmurerieItem.price
            if canCreate then
                RageUI.Button('~g~Ajouter l\'article', nil, {Color = {BackgroundColor = {0, 200, 0, 150}}}, true, {
                    onSelected = function()
                        TriggerServerEvent('sunny:admin:armureries:addItem', adminManagement.NewArmurerieItem)
                        ESX.ShowNotification('~g~Article ajouté avec succès')
                        RageUI.GoBack()
                        Wait(500)
                        ESX.TriggerServerCallback('sunny:admin:armureries:getItems', function(data)
                            adminManagement.ArmurerieItems = data or {}
                        end)
                    end
                })
            else
                RageUI.Button('~r~Ajouter (champs requis)', nil, {}, false, {})
            end
        end)

        -- ═══════════════════════════════════════════════════════════════════════════
        -- GESTION SUPERETTES
        -- ═══════════════════════════════════════════════════════════════════════════

        RageUI.IsVisible(gestionSuperettes, function()
            RageUI.Button('Liste des Supérettes', ('~b~%s~s~ supérettes'):format(#adminManagement.SuperetteListe), {}, true, {
                onSelected = function()
                    adminManagement.SuperetteSearch = nil
                end
            }, gestionSuperettesListe)

            RageUI.Button('Articles en vente', ('~b~%s~s~ articles'):format(#adminManagement.SuperetteItems), {}, true, {
                onSelected = function()
                    adminManagement.SuperetteItemSearch = nil
                end
            }, gestionSuperettesItems)

            RageUI.Line()

            RageUI.Button('Créer une supérette', 'Ajouter une nouvelle supérette à votre position', {Color = {BackgroundColor = {0, 150, 0, 150}}}, true, {
                onSelected = function()
                    adminManagement.NewSuperette = {
                        label = nil,
                        blipId = 52,
                        blipColor = 2,
                        blipScale = 0.7,
                    }
                end
            }, gestionSuperettesCreate)

            RageUI.Button('Ajouter un article', 'Ajouter un nouvel article à vendre', {Color = {BackgroundColor = {0, 100, 150, 150}}}, true, {
                onSelected = function()
                    adminManagement.NewSuperetteItem = {
                        label = nil,
                        name = nil,
                        price = nil,
                        category = 'food',
                    }
                end
            }, gestionSuperettesAddItem)

            RageUI.Line()

            RageUI.Button('Rafraîchir les données', nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:admin:superettes:getAll', function(data)
                        adminManagement.SuperetteListe = data or {}
                        ESX.ShowNotification('~g~Données supérettes rafraîchies')
                    end)
                    ESX.TriggerServerCallback('sunny:admin:superettes:getItems', function(data)
                        adminManagement.SuperetteItems = data or {}
                    end)
                end
            })
        end)

        RageUI.IsVisible(gestionSuperettesListe, function()
            RageUI.Button('Rechercher', nil, {RightLabel = adminManagement.SuperetteSearch or ''}, true, {
                onSelected = function()
                    KeyboardUtils.use('Rechercher', function(data)
                        adminManagement.SuperetteSearch = data
                    end)
                end
            })

            if adminManagement.SuperetteSearch then
                RageUI.Button('❌ Arrêter la Recherche', nil, {}, true, {
                    onSelected = function()
                        adminManagement.SuperetteSearch = nil
                    end
                })
            end

            RageUI.Line()

            for k, v in pairs(adminManagement.SuperetteListe) do
                local superetteLabel = ('Supérette #%s - %s'):format(v.id or k, v.label or 'Sans nom')
                local showItem = true

                if adminManagement.SuperetteSearch then
                    showItem = string.match(string.lower(superetteLabel), string.lower(adminManagement.SuperetteSearch))
                end

                if showItem then
                    RageUI.Button(superetteLabel, nil, {RightLabel = '→'}, true, {
                        onActive = function()
                            if v.x and v.y and v.z then
                                DrawMarker(1, v.x, v.y, v.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 200, false, false, 2, false, nil, nil, false)
                            end
                        end,
                        onSelected = function()
                            adminManagement.SelectedSuperette = v
                        end
                    }, gestionSuperettesSelected)
                end
            end
        end)

        RageUI.IsVisible(gestionSuperettesSelected, function()
            if not adminManagement.SelectedSuperette then return end
            local superette = adminManagement.SelectedSuperette

            RageUI.Separator(('~g~%s~s~'):format(superette.label or 'Supérette'))

            RageUI.Button('Modifier le nom', nil, {RightLabel = superette.label or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nouveau nom', function(data)
                        if not data or data == '' then return end
                        TriggerServerEvent('sunny:admin:superettes:updateLabel', superette.id, data)
                        superette.label = data
                        ESX.ShowNotification('~g~Nom modifié')
                    end)
                end
            })

            RageUI.Button('Modifier la position', 'Définir votre position actuelle', {RightLabel = superette.x and '~g~Défini~s~' or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    local coords = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('sunny:admin:superettes:updatePosition', superette.id, coords.x, coords.y, coords.z)
                    superette.x = coords.x
                    superette.y = coords.y
                    superette.z = coords.z
                    ESX.ShowNotification('~g~Position mise à jour')
                end
            })

            RageUI.Button('Se téléporter', nil, {}, true, {
                onSelected = function()
                    if superette.x and superette.y and superette.z then
                        SetEntityCoords(PlayerPedId(), superette.x, superette.y, superette.z, false, false, false, false)
                        ESX.ShowNotification('~g~Téléportation effectuée')
                    else
                        ESX.ShowNotification('~r~Position non définie')
                    end
                end
            })

            RageUI.Line()

            RageUI.Button('ID du Blip', nil, {RightLabel = tostring(superette.blip_id or 52)}, true, {
                onSelected = function()
                    KeyboardUtils.use('ID du Blip (ex: 52)', function(data)
                        local blipId = tonumber(data)
                        if not blipId then return ESX.ShowNotification('~r~ID invalide') end
                        TriggerServerEvent('sunny:admin:superettes:updateBlip', superette.id, 'blip_id', blipId)
                        superette.blip_id = blipId
                        ESX.ShowNotification('~g~Blip modifié')
                    end)
                end
            })

            RageUI.Button('Couleur du Blip', nil, {RightLabel = tostring(superette.blip_color or 2)}, true, {
                onSelected = function()
                    KeyboardUtils.use('Couleur du Blip (0-85)', function(data)
                        local blipColor = tonumber(data)
                        if not blipColor then return ESX.ShowNotification('~r~Couleur invalide') end
                        TriggerServerEvent('sunny:admin:superettes:updateBlip', superette.id, 'blip_color', blipColor)
                        superette.blip_color = blipColor
                        ESX.ShowNotification('~g~Couleur modifiée')
                    end)
                end
            })

            RageUI.Line()

            RageUI.Button('~r~Supprimer cette supérette', nil, {}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Êtes-vous sûr de vouloir supprimer cette supérette ?',
                        '',
                        function(response)
                            if response then
                                TriggerServerEvent('sunny:admin:superettes:delete', superette.id)
                                ESX.ShowNotification('~g~Supérette supprimée')
                                RageUI.GoBack()
                                ESX.TriggerServerCallback('sunny:admin:superettes:getAll', function(data)
                                    adminManagement.SuperetteListe = data or {}
                                end)
                            end
                        end
                    )
                end
            })
        end)

        RageUI.IsVisible(gestionSuperettesItems, function()
            RageUI.Button('Rechercher', nil, {RightLabel = adminManagement.SuperetteItemSearch or ''}, true, {
                onSelected = function()
                    KeyboardUtils.use('Rechercher', function(data)
                        adminManagement.SuperetteItemSearch = data
                    end)
                end
            })

            if adminManagement.SuperetteItemSearch then
                RageUI.Button('❌ Arrêter la Recherche', nil, {}, true, {
                    onSelected = function()
                        adminManagement.SuperetteItemSearch = nil
                    end
                })
            end

            RageUI.Line()

            for k, v in pairs(adminManagement.SuperetteItems) do
                local itemLabel = ('%s - ~g~%s$~s~'):format(v.label or v.name, ESX.Math.GroupDigits(v.price or 0))
                local showItem = true

                if adminManagement.SuperetteItemSearch then
                    showItem = string.match(string.lower(itemLabel), string.lower(adminManagement.SuperetteItemSearch))
                end

                if showItem then
                    RageUI.Button(itemLabel, ('Catégorie: %s'):format(v.category or 'food'), {RightLabel = '→'}, true, {
                        onSelected = function()
                            adminManagement.SelectedSuperetteItem = v
                        end
                    }, gestionSuperettesItemSelected)
                end
            end
        end)

        RageUI.IsVisible(gestionSuperettesItemSelected, function()
            if not adminManagement.SelectedSuperetteItem then return end
            local item = adminManagement.SelectedSuperetteItem

            RageUI.Separator(('~g~%s~s~'):format(item.label or item.name))

            RageUI.Button('Modifier le label', nil, {RightLabel = item.label or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nouveau label', function(data)
                        if not data or data == '' then return end
                        TriggerServerEvent('sunny:admin:superettes:updateItem', item.id, 'label', data)
                        item.label = data
                        ESX.ShowNotification('~g~Label modifié')
                    end)
                end
            })

            RageUI.Button('Modifier le nom (item)', nil, {RightLabel = item.name or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom de l\'item', function(data)
                        if not data or data == '' then return end
                        TriggerServerEvent('sunny:admin:superettes:updateItem', item.id, 'name', data)
                        item.name = data
                        ESX.ShowNotification('~g~Nom modifié')
                    end)
                end
            })

            RageUI.Button('Modifier le prix', nil, {RightLabel = ('~g~%s$~s~'):format(ESX.Math.GroupDigits(item.price or 0))}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nouveau prix', function(data)
                        local price = tonumber(data)
                        if not price then return ESX.ShowNotification('~r~Prix invalide') end
                        TriggerServerEvent('sunny:admin:superettes:updateItem', item.id, 'price', price)
                        item.price = price
                        ESX.ShowNotification('~g~Prix modifié')
                    end)
                end
            })

            RageUI.Button('Modifier la catégorie', nil, {RightLabel = item.category or 'food'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Catégorie (food/divers)', function(data)
                        if not data or data == '' then return end
                        TriggerServerEvent('sunny:admin:superettes:updateItem', item.id, 'category', data)
                        item.category = data
                        ESX.ShowNotification('~g~Catégorie modifiée')
                    end)
                end
            })

            RageUI.Line()

            RageUI.Button('~r~Supprimer cet article', nil, {}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Êtes-vous sûr de vouloir supprimer cet article ?',
                        '',
                        function(response)
                            if response then
                                TriggerServerEvent('sunny:admin:superettes:deleteItem', item.id)
                                ESX.ShowNotification('~g~Article supprimé')
                                RageUI.GoBack()
                                ESX.TriggerServerCallback('sunny:admin:superettes:getItems', function(data)
                                    adminManagement.SuperetteItems = data or {}
                                end)
                            end
                        end
                    )
                end
            })
        end)

        RageUI.IsVisible(gestionSuperettesCreate, function()
            RageUI.Separator('~g~Créer une Supérette~s~')

            RageUI.Button('Nom de la supérette', nil, {RightLabel = adminManagement.NewSuperette.label or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom', function(data)
                        if data and data ~= '' then
                            adminManagement.NewSuperette.label = data
                        end
                    end)
                end
            })

            RageUI.Button('ID du Blip', nil, {RightLabel = tostring(adminManagement.NewSuperette.blipId)}, true, {
                onSelected = function()
                    KeyboardUtils.use('ID Blip (52 = magasin)', function(data)
                        local id = tonumber(data)
                        if id then adminManagement.NewSuperette.blipId = id end
                    end)
                end
            })

            RageUI.Button('Couleur du Blip', nil, {RightLabel = tostring(adminManagement.NewSuperette.blipColor)}, true, {
                onSelected = function()
                    KeyboardUtils.use('Couleur (0-85)', function(data)
                        local color = tonumber(data)
                        if color then adminManagement.NewSuperette.blipColor = color end
                    end)
                end
            })

            RageUI.Line()

            if adminManagement.NewSuperette.label then
                RageUI.Button('~g~Créer à ma position', nil, {Color = {BackgroundColor = {0, 200, 0, 150}}}, true, {
                    onSelected = function()
                        local coords = GetEntityCoords(PlayerPedId())
                        TriggerServerEvent('sunny:admin:superettes:create', {
                            label = adminManagement.NewSuperette.label,
                            x = coords.x,
                            y = coords.y,
                            z = coords.z,
                            blip_id = adminManagement.NewSuperette.blipId,
                            blip_color = adminManagement.NewSuperette.blipColor,
                            blip_scale = adminManagement.NewSuperette.blipScale,
                        })
                        ESX.ShowNotification('~g~Supérette créée avec succès')
                        RageUI.GoBack()
                        Wait(500)
                        ESX.TriggerServerCallback('sunny:admin:superettes:getAll', function(data)
                            adminManagement.SuperetteListe = data or {}
                        end)
                    end
                })
            else
                RageUI.Button('~r~Créer (nom requis)', nil, {}, false, {})
            end
        end)

        RageUI.IsVisible(gestionSuperettesAddItem, function()
            RageUI.Separator('~g~Ajouter un Article~s~')

            RageUI.Button('Label', nil, {RightLabel = adminManagement.NewSuperetteItem.label or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Label (affiché)', function(data)
                        if data and data ~= '' then
                            adminManagement.NewSuperetteItem.label = data
                        end
                    end)
                end
            })

            RageUI.Button('Nom item', nil, {RightLabel = adminManagement.NewSuperetteItem.name or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom item (ex: water)', function(data)
                        if data and data ~= '' then
                            adminManagement.NewSuperetteItem.name = data
                        end
                    end)
                end
            })

            RageUI.Button('Prix', nil, {RightLabel = adminManagement.NewSuperetteItem.price and ('~g~%s$~s~'):format(ESX.Math.GroupDigits(adminManagement.NewSuperetteItem.price)) or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Prix', function(data)
                        local price = tonumber(data)
                        if price then adminManagement.NewSuperetteItem.price = price end
                    end)
                end
            })

            RageUI.Button('Catégorie', nil, {RightLabel = adminManagement.NewSuperetteItem.category or 'food'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Catégorie (food/divers)', function(data)
                        if data and data ~= '' then
                            adminManagement.NewSuperetteItem.category = data
                        end
                    end)
                end
            })

            RageUI.Line()

            local canCreate = adminManagement.NewSuperetteItem.label and adminManagement.NewSuperetteItem.name and adminManagement.NewSuperetteItem.price
            if canCreate then
                RageUI.Button('~g~Ajouter l\'article', nil, {Color = {BackgroundColor = {0, 200, 0, 150}}}, true, {
                    onSelected = function()
                        TriggerServerEvent('sunny:admin:superettes:addItem', adminManagement.NewSuperetteItem)
                        ESX.ShowNotification('~g~Article ajouté avec succès')
                        RageUI.GoBack()
                        Wait(500)
                        ESX.TriggerServerCallback('sunny:admin:superettes:getItems', function(data)
                            adminManagement.SuperetteItems = data or {}
                        end)
                    end
                })
            else
                RageUI.Button('~r~Ajouter (champs requis)', nil, {}, false, {})
            end
        end)


        RageUI.IsVisible(createDrugs, function()
                RageUI.Button('Créé Circuit', nil, {}, true, {
                    onSelected = function()
                        
                    end
                }, createCircuit)
            RageUI.Button('Edit Circuit', nil, {}, true, {
                    onSelected = function()
                        
                    end
                }, editCircuit)
        RageUI.Button('Edit Sell Drugs', nil, {}, true, {
                    onSelected = function()
                        
                    end
                }, editSellDrugs)
            
        end)
        -- RageUI.IsVisible(weatherManagement, function()
        --     RageUI.Separator(string.format("↓     %sMétéo     ~s~↓", SunnyConfigServ.GTACOLOR))
        --     for k,v in pairs(weathersZone) do
        --         RageUI.List(v[1], weathers, v[2], "Appuyez sur ENTRER pour définir le temps.", {}, true, {
        --             onListChange = function(Index) 
        --                 v[2] = Index 
        --             end,

        --             onSelected = function(Index)
        --                 TriggerServerEvent('weather:server:setWeather', k, v[2])
        --             end
        --         })
        --     end
        
        -- end)

        RageUI.IsVisible(manageVehicleConcess, function()
            RageUI.Button('Rafraichir la liste des véhicules', nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:admin:dealership:refreshvehicleslist', function(cb)
                        if type(cb) == "table" then
                            adminManagement.DealerShipVehicles = cb
                        end
                    end)
                end
            })
            RageUI.Line()
            RageUI.Button('Catégories', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    
                end
            }, manageVehicleConcessEditAllCategorie)
            RageUI.Line()
            RageUI.Button('Ajouter un véhicule', nil, {Color = {BackgroundColor = {UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o}}}, true, {
                onSelected = function()
                    
                end
            }, manageVehicleConcessCreateVehicle)
            RageUI.Button('Rechercher', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Recherche', function(data)
                        adminManagement.SearchVehicle = data
                    end)
                end
            })
            if adminManagement.SearchVehicle then
                RageUI.Button('Stopper la recherche ❌', nil, {RightLabel = adminManagement.SearchVehicle}, true, {
                    onSelected = function()
                        adminManagement.SearchVehicle = nil
                    end
                })
            end
            if json.encode(adminManagement.DealerShipVehicles) ~= "[]" then
                RageUI.Line()
                for k,v in pairs(adminManagement.DealerShipVehicles) do
                    local vehicleInformations = ("%s [%s] (%s)"):format(v.name, v.model, v.category) 
                    if not adminManagement.SearchVehicle then
                        RageUI.Button(vehicleInformations, nil, {RightLabel = ('~g~%s$~s~ →'):format(ESX.Math.GroupDigits(v.price))}, true, {
                            onSelected = function()
                                adminManagement.DealerShipEditVehicle = v

                                RageUI.Visible(manageVehicleConcessEdit, true)
                            end
                        })
                    else
                        if string.match(string.upper(vehicleInformations), string.upper(adminManagement.SearchVehicle)) then
                            RageUI.Button(vehicleInformations, nil, {RightLabel = ('~g~%s$~s~ →'):format(ESX.Math.GroupDigits(v.price))}, true, {
                                onSelected = function()
                                    adminManagement.DealerShipEditVehicle = v

                                    RageUI.Visible(manageVehicleConcessEdit, true)
                                end
                            })
                        end
                    end
                end
            end
        end)
        
        RageUI.IsVisible(manageVehicleConcessEditAllCategorie, function()
            RageUI.Button('Concessionnaire Luxury', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    adminManagement.EditCategorieType = "vehicle_categories"

                    ESX.TriggerServerCallback('sunny:staff:vehicles:concess:searchCategory', function(cb)
                        adminManagement.EditCategorieTypeList = cb

                        RageUI.Visible(manageVehicleConcessEditAllCategorieEdit, true)
                    end, adminManagement.EditCategorieType)
                end
            })
            RageUI.Button('Concessionnaire Deux roues', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    adminManagement.EditCategorieType = "moto_categories"

                    ESX.TriggerServerCallback('sunny:staff:vehicles:concess:searchCategory', function(cb)
                        adminManagement.EditCategorieTypeList = cb

                        RageUI.Visible(manageVehicleConcessEditAllCategorieEdit, true)
                    end, adminManagement.EditCategorieType)
                end
            })
            RageUI.Button('Concessionnaire Nautiques', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    adminManagement.EditCategorieType = "boat_categories"

                    ESX.TriggerServerCallback('sunny:staff:vehicles:concess:searchCategory', function(cb)
                        adminManagement.EditCategorieTypeList = cb

                        RageUI.Visible(manageVehicleConcessEditAllCategorieEdit, true)
                    end, adminManagement.EditCategorieType)
                end
            })
            RageUI.Button('Concessionnaire Aériens', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    adminManagement.EditCategorieType = "aircraft_categorie"

                    ESX.TriggerServerCallback('sunny:staff:vehicles:concess:searchCategory', function(cb)
                        adminManagement.EditCategorieTypeList = cb

                        RageUI.Visible(manageVehicleConcessEditAllCategorieEdit, true)
                    end, adminManagement.EditCategorieType)
                end
            })
        end)

        RageUI.IsVisible(manageVehicleConcessEditAllCategorieEdit, function()
            RageUI.Button('Rafraichir la liste des categories', nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:staff:vehicles:concess:searchCategory', function(cb)
                        adminManagement.EditCategorieTypeList = cb

                        RageUI.Visible(manageVehicleConcessEditAllCategorieEdit, true)
                    end, adminManagement.EditCategorieType)
                end
            })
            RageUI.Button('Ajouter une catégorie', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    
                end
            }, manageVehicleConcessEditAllCategorieEditAdd)
            RageUI.Line()
            RageUI.Button('Rechercher', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Recherche', function(data)
                        adminManagement.SearchVehicle = data
                    end)
                end
            })
            if adminManagement.SearchVehicle then
                RageUI.Button('Stopper la recherche ❌', nil, {RightLabel = adminManagement.SearchVehicle}, true, {
                    onSelected = function()
                        adminManagement.SearchVehicle = nil
                    end
                })
            end
            RageUI.Line()
            for k,v in pairs(adminManagement.EditCategorieTypeList) do
                local categoryInformations = ("%s (%s)"):format(v.name, v.label) 
                if not adminManagement.SearchVehicle then
                    RageUI.Button(categoryInformations, nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            adminManagement.DealerShipCategoriesSelect = v.name

                            RageUI.Visible(manageVehicleConcessEditAllCategorieEditInformations, true)
                        end
                    })
                else
                    if string.match(string.upper(categoryInformations), string.upper(adminManagement.SearchVehicle)) then
                        RageUI.Button(categoryInformations, nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                                adminManagement.DealerShipCategoriesSelect = v.name

                                RageUI.Visible(manageVehicleConcessEditAllCategorieEditInformations, true)
                            end
                        })
                    end
                end
            end
        end)

        RageUI.IsVisible(manageVehicleConcessEditAllCategorieEditInformations, function()
            RageUI.Separator(('Édition de la catégorie ~g~%s~s~'):format(adminManagement.DealerShipCategoriesSelect))
            RageUI.Button('Supprimer la catégorie', nil, {}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Êtes-vous sûr de vouloir supprimer cette catégorie de véhicules ?',
                        '',
                        function(response)
                            if response then -- Oui
                                TriggerServerEvent('sunny:staff:vehicles:concess:categories:delete', adminManagement.EditCategorieType, adminManagement.DealerShipCategoriesSelect)
                                
                                Wait(500)
                                RageUI.GoBack()
                                ESX.TriggerServerCallback('sunny:staff:vehicles:concess:searchCategory', function(cb)
                                    adminManagement.EditCategorieTypeList = cb
                                    RageUI.Visible(manageVehicleConcessEditAllCategorieEdit, true)
                                end, adminManagement.EditCategorieType)
                            else -- Non
                                ESX.ShowNotification('Suppression annulée')
                            end
                        end
                    )
                end
            })
        end)
        

        RageUI.IsVisible(manageVehicleConcessEditAllCategorieEditAdd, function()
            RageUI.Button('Nom de la catégorie', nil, {RightLabel = adminManagement.DealerShipAddVehicleAddParentCategory.name == nil and '~r~Indéfini~s~' or adminManagement.DealerShipAddVehicleAddParentCategory.name}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom de la catégorie', function(data)
                        if data == '' or data == nil then return end

                        adminManagement.DealerShipAddVehicleAddParentCategory.name = data
                    end)
                end
            })
            RageUI.Button('Nom d\'affiche de la catégorie', nil, {RightLabel = adminManagement.DealerShipAddVehicleAddParentCategory.label == nil and '~r~Indéfini~s~' or adminManagement.DealerShipAddVehicleAddParentCategory.label}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom d\'affiche de la catégorie', function(data)
                        if data == '' or data == nil then return end

                        adminManagement.DealerShipAddVehicleAddParentCategory.label = data
                    end)
                end
            })
                if adminManagement.DealerShipAddVehicleAddParentCategory.name ~= nil and adminManagement.DealerShipAddVehicleAddParentCategory.label ~= nil then
                    RageUI.Button('Confirmer', nil, {Color = {BackgroundColor = {UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o}}}, true, {
                        onSelected = function()
                            exports['prompt']:createPrompt(
                                SunnyConfigServ.ServerName, 
                                'Êtes-vous sûr de vouloir ajouter cette catégorie de véhicules ?',
                                '',
                                function(response)
                                    if response then -- Oui
                                        TriggerServerEvent('sunny:staff:vehicles:concess:categories:add', adminManagement.EditCategorieType, adminManagement.DealerShipAddVehicleAddParentCategory)

                                        Wait(500)
                                        RageUI.GoBack()
                                        ESX.TriggerServerCallback('sunny:staff:vehicles:concess:searchCategory', function(cb)
                                            adminManagement.EditCategorieTypeList = cb
                                            RageUI.Visible(manageVehicleConcessEditAllCategorieEdit, true)
                                        end, adminManagement.EditCategorieType)
                                    else -- Non
                                        ESX.ShowNotification('Vous avez annulé l\'action')
                                    end
                                end
                            )
                        end
                    })
                end
            
                -- Ajoutez ici les autres boutons et fonctionnalités de votre interface RageUI
            end)

        RageUI.IsVisible(manageVehicleConcessEdit, function()
            RageUI.Separator(('Edition du véhicule: ~g~%s~s~ (~g~%s~s~) [~g~%s$~s~] "%s"'):format(adminManagement.DealerShipEditVehicle.name, adminManagement.DealerShipEditVehicle.model, ESX.Math.GroupDigits(adminManagement.DealerShipEditVehicle.price), adminManagement.DealerShipEditVehicle.category))
            RageUI.Line()
            RageUI.Button('Modifier le prix du véhicule', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nouveau prix', function(data)
                        local data = tonumber(data)

                        if data == nil then return end

                        TriggerServerEvent('sunny:staff:vehicles:concess:changePrice', adminManagement.DealerShipEditVehicle.id, data)

                        Wait(500)
                        RageUI.GoBack()
                        ESX.TriggerServerCallback('sunny:admin:dealership:refreshvehicleslist', function(cb)
                            if type(cb) == "table" then
                                adminManagement.DealerShipVehicles = cb
                            end
                        end)
                    end)
                end
            })
            RageUI.Button('Renommer le véhicule', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nouveau nom', function(data)
                        if data == nil or data == '' then return end

                        TriggerServerEvent('sunny:staff:vehicles:concess:renameVehicle', adminManagement.DealerShipEditVehicle.id, data)

                        Wait(500)
                        RageUI.GoBack()
                        ESX.TriggerServerCallback('sunny:admin:dealership:refreshvehicleslist', function(cb)
                            if type(cb) == "table" then
                                adminManagement.DealerShipVehicles = cb
                            end
                        end)
                    end)
                end
            })
            RageUI.Button('Modifier la catégorie du véhicule', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:staff:vehicles:concess:catégories:fetch', function(cb)
                        if type(cb) == "table" then
                            adminManagement.DealerShipCategories = cb

                            for k,v in pairs(adminManagement.DealerShipCategories) do
                                if v.name ==  adminManagement.DealerShipEditVehicle.category then
                                    v.enable = true
                                end
                            end

                            RageUI.Visible(manageVehicleConcessEditCategorie, true)
                        end
                    end)
                end
            })
            RageUI.Button('Supprimer le véhicule', nil, {Color = {BackgroundColor = {255,0,0,150}}}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName, 
                        'Êtes-vous sûr de vouloir supprimer ce véhicule ?',
                        '',
                        function(response)
                            if response then -- Oui
                                TriggerServerEvent('sunny:staff:vehicles:concess:deleteVehicle', adminManagement.DealerShipEditVehicle.id)

                                Wait(500) 
                                RageUI.GoBack()
                                ESX.TriggerServerCallback('sunny:admin:dealership:refreshvehicleslist', function(cb)
                                    if type(cb) == "table" then
                                        adminManagement.DealerShipVehicles = cb
                                    end
                                end)
                            else -- Non
                                ESX.ShowNotification('Suppression annulée')
                            end
                        end
                    )
                end
            })
            end)

        RageUI.IsVisible(manageVehicleConcessEditCategorie, function()
            RageUI.Button('Rechercher', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Recherche', function(data)
                        adminManagement.SearchVehicleCategorie = data
                    end)
                end
            })
            if adminManagement.SearchVehicleCategorie then
                RageUI.Button('Stopper la recherche ❌', nil, {RightLabel = adminManagement.SearchVehicleCategorie}, true, {
                    onSelected = function()
                        adminManagement.SearchVehicleCategorie = nil
                    end
                })
            end
            RageUI.Button('Confirmer les modifications', nil, {Color = {BackgroundColor = {UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o}}}, true, {
                onSelected = function()
                    TriggerServerEvent('sunny:staff:vehicles:concess:changeCategory', adminManagement.DealerShipEditVehicle.id, adminManagement.DealerShipEditVehicle.category)
                    Wait(500)
                    RageUI.GoBack()
                    ESX.TriggerServerCallback('sunny:admin:dealership:refreshvehicleslist', function(cb)
                        if type(cb) == "table" then
                            adminManagement.DealerShipVehicles = cb

                            RageUI.GoBack()
                        end
                    end)
                end
            })
            RageUI.Line()
            for k,v in pairs(adminManagement.DealerShipCategories) do
                if adminManagement.SearchVehicleCategorie == nil then
                    RageUI.Checkbox(('%s (%s)'):format(v.label, v.name), nil, v.enable, {}, {
                        onChecked = function()
                            for k,v in pairs(adminManagement.DealerShipCategories) do
                                v.enable = false
                            end
    
                            v.enable = true
    
                            adminManagement.DealerShipEditVehicle.category = v.name
                        end,
                        onUnChecked = function()
                            for k,v in pairs(adminManagement.DealerShipCategories) do
                                v.enable = false
                            end
    
                            adminManagement.DealerShipEditVehicle.category = v.name
                        end
                    })
                else
                    if string.match(string.upper(v.name), string.upper(adminManagement.SearchVehicleCategorie)) or string.match(string.upper(v.label), string.upper(adminManagement.SearchVehicleCategorie)) then
                        RageUI.Checkbox(('%s (%s)'):format(v.label, v.name), nil, v.enable, {}, {
                            onChecked = function()
                                for k,v in pairs(adminManagement.DealerShipCategories) do
                                    v.enable = false
                                end
        
                                v.enable = true
        
                                adminManagement.DealerShipEditVehicle.category = v.name
                            end,
                            onUnChecked = function()
                                for k,v in pairs(adminManagement.DealerShipCategories) do
                                    v.enable = false
                                end
        
                                adminManagement.DealerShipEditVehicle.category = v.name
                            end
                        })
                    end
                end
            end
        end)

        RageUI.IsVisible(manageVehicleConcessCreateVehicle, function()
            RageUI.Button('Nom du Spawn', nil, {RightLabel = adminManagement.DealerShipAddVehicle.spawnName == nil and '~r~Indéfini~s~' or adminManagement.DealerShipAddVehicle.spawnName}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom du Spawn', function(data)
                        if data == nil or data == '' then return end
                        
                        adminManagement.DealerShipAddVehicle.spawnName = data
                    end)
                end
            })
            RageUI.Button('Nom du Véhicule', nil, {RightLabel = adminManagement.DealerShipAddVehicle.label == nil and '~r~Indéfini~s~' or adminManagement.DealerShipAddVehicle.label}, true, {
                onSelected = function()
                    KeyboardUtils.use('Label du Véhicule', function(data)
                        if data == nil or data == '' then return end
                        
                        adminManagement.DealerShipAddVehicle.label = data
                    end)
                end
            })
            RageUI.Button('Prix du Véhicule', nil, {RightLabel = adminManagement.DealerShipAddVehicle.price == nil and '~r~Indéfini~s~' or ("~g~%s$~s~"):format(ESX.Math.GroupDigits(adminManagement.DealerShipAddVehicle.price))}, true, {
                onSelected = function()
                    KeyboardUtils.use('Prix du Véhicule', function(data)
                        if data == nil or data == '' then return end
                        
                        adminManagement.DealerShipAddVehicle.price = data
                    end)
                end
            })
            RageUI.Button('Catégorie', nil, {RightLabel = adminManagement.DealerShipCategoriesSelect == nil and '→' or adminManagement.DealerShipCategoriesSelect}, true, {
                onSelected = function()
                    if json.encode(adminManagement.DealerShipCategories) ~= "[]" then return end
                    ESX.TriggerServerCallback('sunny:staff:vehicles:concess:catégories:fetch', function(cb)
                        if type(cb) == "table" then
                            adminManagement.DealerShipCategories = cb
                        end
                    end)
                end
            }, manageVehicleConcessCreateVehicleCategorie)
            if adminManagement.DealerShipAddVehicle.spawnName ~= nil and adminManagement.DealerShipAddVehicle.label ~= nil and adminManagement.DealerShipAddVehicle.price ~= nil and adminManagement.DealerShipCategoriesSelect ~= nil then
                RageUI.Button('Confirmer', nil, {Color = {BackgroundColor = {UTILS.ServerColor.r, UTILS.ServerColor.g, UTILS.ServerColor.b, UTILS.ServerColor.o}}}, true, {
                    onSelected = function()
                        TriggerServerEvent('sunny:staff:vehicles:concess:addVehicle', adminManagement.DealerShipAddVehicle, adminManagement.DealerShipCategoriesSelect)

                        adminManagement.DealerShipCategoriesSelect = nil
                        adminManagement.DealerShipAddVehicle = {
                            spawnName = nil,
                            label = nil,
                            price = nil,
                            categorie = nil
                        }
                    end
                })
            end
        end)

        RageUI.IsVisible(manageVehicleConcessCreateVehicleCategorie, function()
            RageUI.Button('Rechercher', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Recherche', function(data)
                        adminManagement.SearchVehicleCategorie = data
                    end)
                end
            })
            if adminManagement.SearchVehicleCategorie then
                RageUI.Button('Stopper la recherche ❌', nil, {RightLabel = adminManagement.SearchVehicleCategorie}, true, {
                    onSelected = function()
                        adminManagement.SearchVehicleCategorie = nil
                    end
                })
            end
            RageUI.Line()
            for k,v in pairs(adminManagement.DealerShipCategories) do
                if adminManagement.SearchVehicleCategorie == nil then
                    RageUI.Checkbox(('%s (%s)'):format(v.label, v.name), nil, v.enable, {}, {
                        onChecked = function()
                            for k,v in pairs(adminManagement.DealerShipCategories) do
                                v.enable = false
                            end
    
                            v.enable = true
    
                            adminManagement.DealerShipCategoriesSelect = v.name
                        end,
                        onUnChecked = function()
                            for k,v in pairs(adminManagement.DealerShipCategories) do
                                v.enable = false
                            end
    
                            adminManagement.DealerShipCategoriesSelect = nil
                        end
                    })
                else
                    if string.match(string.upper(v.name), string.upper(adminManagement.SearchVehicleCategorie)) or string.match(string.upper(v.label), string.upper(adminManagement.SearchVehicleCategorie)) then
                        RageUI.Checkbox(('%s (%s)'):format(v.label, v.name), nil, v.enable, {}, {
                            onChecked = function()
                                for k,v in pairs(adminManagement.DealerShipCategories) do
                                    v.enable = false
                                end
        
                                v.enable = true
        
                                adminManagement.DealerShipCategoriesSelect = v.name
                            end,
                            onUnChecked = function()
                                for k,v in pairs(adminManagement.DealerShipCategories) do
                                    v.enable = false
                                end
        
                                adminManagement.DealerShipCategoriesSelect = nil
                            end
                        })
                    end
                end
            end
        end)

        RageUI.IsVisible(openJobList, function()
            for k, v in pairs(adminManagement.jobsData) do
                RageUI.Button(('%s (%s)'):format(k, v.label), "Press ENTRER pour enlever toutes les personnes ayant ce jobs ", {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Y / N', function(data)
                            if data == "y" or data == 'Y' then
                                TriggerServerEvent('sunny:jobs:RemoveallJobs', v.name)
                            end
                        end)
                    end
                })
            end
        end)

        RageUI.IsVisible(editSellDrugs, function()
            RageUI.Button('Ajouter une position', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Message', function(data)
                        if data == nil or data == '' then
                            return
                        end

                        TriggerServerEvent('sunny:drugs:sell:addPos', GetEntityCoords(Player.playerPed), data)
                    end)
                end
            })
            RageUI.Line()
            for k,v in pairs(SunnyDrugs.sell.Position) do
                RageUI.Button(v.pos.x..' '.. v.pos.y.. ' ' .. v.pos.z, '\n[E] pour se téléporter sur le point\n\n'..v.message, {}, true, {
                    onActive = function()
                        
                        if IsControlJustPressed(0,54) then
                            SetEntityCoords(Player.playerPed, vector3(v.pos.x, v.pos.y, v.pos.z))
                        end

                        DrawMarker(1, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 240, 255, 0, 255, false, false, 2, false, false, false, false)
                        DrawInstructionBarNotification(v.pos.x, v.pos.y, v.pos.z+0.25, v.pos.x..' '.. v.pos.y.. ' ' .. v.pos.z)

                    end,
                    onSeleted = function()
                        KeyboardUtils('Taper Y pour supprimer la positon', function(data)
                            if data == 'y' or data == 'Y' then
                                TriggerServerEvent('sunny:drugs:sell:delete', v.id)
                            end
                        end)
                    end
                })
            end
        end)

        RageUI.IsVisible(editCircuit, function()
            for k,v in pairs(SunnyDrugs.Items) do
                RageUI.Button(('%s (%s) (r-%s) (t-%s)'):format(v.recolte.name, v.recolte.label, #SunnyDrugs.Drugs[k]['recolte'], #SunnyDrugs.Drugs[k]['traitement']), nil, {RightLabel = '>>'}, true, {
                    onSelected = function()
                        adminManagement.SelectedDrugs = v
                        RageUI.Visible(editCircuit2, true)
                    end
                })
            end
        end)

        RageUI.IsVisible(editCircuit2, function()
            if json.encode(adminManagement.SelectedDrugs) ~= '[]' then
                RageUI.Separator(("Informations de la drogue ~y~%s - %s~s~"):format(adminManagement.SelectedDrugs.recolte.name, adminManagement.SelectedDrugs.recolte.label))

                RageUI.Line()

                RageUI.Button('Changer le nom', nil, {}, true, {
                    onSelected = function()
                        
                    end
                })
                RageUI.Button('Changer le label', nil, {}, true, {
                    onSelected = function()
                        
                    end
                })
                RageUI.Button('Changer le nom du pochon', nil, {}, true, {
                    onSelected = function()
                        
                    end
                })
                RageUI.Button('Changer le label du pochon', nil, {}, true, {
                    onSelected = function()
                        
                    end
                })
                RageUI.Button('Gérer les positions de recolte', nil, {RightLabel = ('~y~%s~s~'):format(#SunnyDrugs.Drugs[adminManagement.SelectedDrugs.recolte.name]['recolte'])}, true, {
                    onSelected = function()
                        adminManagement.SelectedDrugsCategorie = 'recolte'
                    end
                }, editPosWithCategorie_drugs)
                RageUI.Button('Gérer les positions de traitement', nil, {RightLabel = ('~y~%s~s~'):format(#SunnyDrugs.Drugs[adminManagement.SelectedDrugs.recolte.name]['traitement'])}, true, {
                    onSelected = function()
                        adminManagement.SelectedDrugsCategorie = 'traitement'
                    end
                }, editPosWithCategorie_drugs)
            end
        end)

        RageUI.IsVisible(editPosWithCategorie_drugs, function()
            RageUI.Separator(('Catégorie: ~y~%s~s~'):format(adminManagement.SelectedDrugsCategorie))
            RageUI.Button('Ajouter une position', nil, {RightLabel = ('~y~%s positions~s~'):format(#SunnyDrugs.Drugs[adminManagement.SelectedDrugs.recolte.name][adminManagement.SelectedDrugsCategorie])}, true, {
                onSelected = function()
                    
                end
            })
            RageUI.Line()
            for k,v in pairs(SunnyDrugs.Drugs[adminManagement.SelectedDrugs.recolte.name][adminManagement.SelectedDrugsCategorie]) do
                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 240, 255, 0, 255, false, false, 2, false, false, false, false)
                DrawInstructionBarNotification(v.x, v.y, v.z, (v.x..' '..v.y..' '..v.z.. ' (%s)'):format(adminManagement.SelectedDrugsCategorie))
                RageUI.Button(('[%s] (%s %s %s)'):format(k, v.x, v.y, v.z), '\n[ENTER] changer la position\n[E] supprimer la positon\n', {RightLabel = ''}, true, {
                    onActive = function()
                        DrawMarker(43, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 240, 0, 0, 255, false, false, 2, false, false, false, false)
                        DrawInstructionBarNotification(v.x, v.y, v.z, (v.x..' '..v.y..' '..v.z.. ' (%s)'):format(adminManagement.SelectedDrugsCategorie))

                        if IsControlJustPressed(0, 54) then
                            
                        end
                    end,
                    onSelected = function()
                        
                    end
                })
            end
        end)

        RageUI.IsVisible(createCircuit, function()
            RageUI.Separator('Création d\'un circuit de drogue')
            RageUI.Checkbox('Laboratoire', nil, adminManagement.CreateDrugs.Laboratory.active, {}, {
                onChecked = function()
                    adminManagement.CreateDrugs.Laboratory.active = true
                end,
                onUnChecked = function()
                    adminManagement.CreateDrugs.Laboratory.active = false
                end
            })
            if adminManagement.CreateDrugs.Laboratory.active == false then
                RageUI.Button('Nom de la drogue', nil, {RightLabel = adminManagement.CreateDrugs.name or '~r~Indéfini~s~'}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Nom de la drogue', function(data)
                            if not data or data == '' then return end
    
                            adminManagement.CreateDrugs.name = data
                        end)
                    end
                })
                RageUI.Button('Label de la drogue', nil, {RightLabel = adminManagement.CreateDrugs.label or '~r~Indéfini~s~'}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Label de la drogue', function(data)
                            if not data or data == '' then return end
    
                            adminManagement.CreateDrugs.label = data
                        end)
                    end
                })
                RageUI.Separator('~y~↓ Récolte ↓~s~')
                RageUI.Button('Type d\'animation', nil, {RightLabel = adminManagement.CreateDrugs.recolte_animtype or '~r~Indéfini~s~'}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Type d\'animation (anim/scenario)', function(data)
                            if not data or data == '' then return end
    
                            adminManagement.CreateDrugs.recolte_animtype = data
                        end)
                    end
                })
                RageUI.Button('Dict de l\'animation', nil, {RightLabel = adminManagement.CreateDrugs.recolte_animdict or '~r~Indéfini~s~'}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Dict de l\'animation)', function(data)
                            if not data or data == '' then return end
    
                            adminManagement.CreateDrugs.recolte_animdict = data
                        end)
                    end
                })
                RageUI.Button('Animation', nil, {RightLabel = adminManagement.CreateDrugs.recolte_anim or '~g~Aucune~s~'}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Animation', function(data)
                            if not data or data == '' then 
                                adminManagement.CreateDrugs.recolte_anim = nil
                                return 
                            end
    
                            adminManagement.CreateDrugs.recolte_anim = data
                        end)
                    end
                })
                RageUI.Button('Durée de l\'animation', nil, {RightLabel = adminManagement.CreateDrugs.recolte_animtime or '~r~Indéfini~s~'}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Animation', function(data)
                            local data = tonumber(data)
                            if data == nil then return end
                
                            adminManagement.CreateDrugs.recolte_animtime = data
                        end)
                    end
                })
                RageUI.Checkbox('Marker', nil, adminManagement.CreateDrugs.recolte_marker or false, {}, {
                    onActive = function()
                        if adminManagement.CreateDrugs.recolte_marker == nil then
                            adminManagement.CreateDrugs.recolte_marker = false
                        end
                    end,
                    onChecked = function()
                        adminManagement.CreateDrugs.recolte_marker = true
                    end,
                    onUnChecked = function()
                        adminManagement.CreateDrugs.recolte_marker = false
                    end
                })
                RageUI.Button('Props (Si pas de marker)', nil, {RightLabel = adminManagement.CreateDrugs.recolte_props or '~g~Aucun~s~'}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Animation', function(data)
                            if not data or data == '' then 
                                adminManagement.CreateDrugs.recolte_props = nil
                                return 
                            end
                            adminManagement.CreateDrugs.recolte_props = data
                        end)
                    end
                })
                RageUI.Button(('Ajouter des positions à la récolte (%s) position'):format(adminManagement.CreateDrugs.posRecolte and #adminManagement.CreateDrugs.posRecolte or 0), '\n[E] pour retirer la dernnière position\n', {}, true, {
                    onActive = function()
                        if IsControlJustPressed(0, 54) then
                            adminManagement.CreateDrugs.posRecolte[#adminManagement.CreateDrugs.posRecolte] = nil
                        end
    
                        if adminManagement.CreateDrugs.posRecolte then
                            for k,v in pairs(adminManagement.CreateDrugs.posRecolte) do
                                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 240, 255, 0, 255, false, false, 2, false, false, false, false)
                                DrawInstructionBarNotification(v.x, v.y, v.z+0.15, ('Récolte'))
                            end
                        end
                    end,
                    onSelected = function()
                        if not adminManagement.CreateDrugs.posRecolte then
                            adminManagement.CreateDrugs.posRecolte = {}
                        end
    
                        adminManagement.CreateDrugs.posRecolte[#adminManagement.CreateDrugs.posRecolte+1] = GetEntityCoords(PlayerPedId())
                    end
                })
            RageUI.Separator('~y~↓ Traitement ↓~s~')
            RageUI.Button('Type d\'animation', nil, {RightLabel = adminManagement.CreateDrugs.traitement_animtype or '~r~Indéfini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Type d\'animation (anim/scenario)', function(data)
                        if not data or data == '' then return end
            
                        adminManagement.CreateDrugs.traitement_animtype = data
                    end)
                end
            })
            RageUI.Button('Dict de l\'animation', nil, {RightLabel = adminManagement.CreateDrugs.traitement_animdict or '~r~Indéfini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Dict de l\'animation)', function(data)
                        if not data or data == '' then return end
            
                        adminManagement.CreateDrugs.traitement_animdict = data
                    end)
                end
            })
            RageUI.Button('Animation', nil, {RightLabel = adminManagement.CreateDrugs.traitement_anim or '~g~Aucune~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Animation', function(data)
                        if not data or data == '' then 
                            adminManagement.CreateDrugs.traitement_anim = nil
                            return 
                        end
            
                        adminManagement.CreateDrugs.traitement_anim = data
                    end)
                end
            })
            RageUI.Button('Durée de l\'animation', nil, {RightLabel = adminManagement.CreateDrugs.traitement_animtime or '~r~Indéfini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Animation', function(data)
                        local data = tonumber(data)
                        if data == nil then return end
            
                        adminManagement.CreateDrugs.traitement_animtime = data
                    end)
                end
            })
            RageUI.Checkbox('Marker', nil, adminManagement.CreateDrugs.traitement_marker or false, {}, {
                onActive = function()
                    if adminManagement.CreateDrugs.traitement_marker == nil then
                        adminManagement.CreateDrugs.traitement_marker = false
                    end
                end,
                onChecked = function()
                    adminManagement.CreateDrugs.traitement_marker = true
                end,
                onUnChecked = function()
                    adminManagement.CreateDrugs.traitement_marker = false
                end
            })
            RageUI.Button('Props (Si pas de marker)', nil, {RightLabel = adminManagement.CreateDrugs.traitement_props or '~g~Aucun~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Animation', function(data)
                        if not data or data == '' then 
                            adminManagement.CreateDrugs.traitement_props = nil
                            return 
                        end
                        adminManagement.CreateDrugs.traitement_props = data
                    end)
                end
            })
            RageUI.Button('Nom de la drogue traitée', nil, {RightLabel = adminManagement.CreateDrugs.name_pooch or '~r~Indéfini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom de la drogue traitée', function(data)
                        if not data or data == '' then return end

                        adminManagement.CreateDrugs.name_pooch = data
                    end)
                end
            })
            RageUI.Button('Label de la drogue traitée', nil, {RightLabel = adminManagement.CreateDrugs.label_pooch or '~r~Indéfini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Label de la drogue traitée', function(data)
                        if not data or data == '' then return end

                        adminManagement.CreateDrugs.label_pooch = data
                    end)
                end
            })
            RageUI.Button(('Ajouter des positions au traitement (%s) position'):format(adminManagement.CreateDrugs.posTraitement and #adminManagement.CreateDrugs.posTraitement or 0), '\n[E] pour retirer la dernnière position\n', {}, true, {
                onActive = function()
                    if IsControlJustPressed(0, 54) then
                        adminManagement.CreateDrugs.posTraitement[#adminManagement.CreateDrugs.posTraitement] = nil
                    end

                    if adminManagement.CreateDrugs.posTraitement then
                        for k,v in pairs(adminManagement.CreateDrugs.posTraitement) do
                            DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 240, 255, 0, 255, false, false, 2, false, false, false, false)
                            DrawInstructionBarNotification(v.x, v.y, v.z+0.15, ('Traitement'))
                        end
                    end
                end,
                onSelected = function()
                    if not adminManagement.CreateDrugs.posTraitement then
                        adminManagement.CreateDrugs.posTraitement = {}
                    end

                    adminManagement.CreateDrugs.posTraitement[#adminManagement.CreateDrugs.posTraitement+1] = GetEntityCoords(PlayerPedId())
                end
            })
            else
                RageUI.Separator('~y~↓ Mode laboratoire ↓~s~')
                for k,v in pairs(adminManagement.CreateDrugs.Laboratory.list) do
                    RageUI.Checkbox(v.label, nil, adminManagement.CreateDrugs.Laboratory.list[k].active, {}, {
                        onChecked = function()

                            for k,v in pairs(adminManagement.CreateDrugs.Laboratory.list) do
                                if v.active == true then
                                    adminManagement.CreateDrugs.Laboratory.list[k].active = false

                                    adminManagement.CreateDrugs.Laboratory.pos = nil
                                end
                            end

                            adminManagement.CreateDrugs.Laboratory.list[k].active = true
                        end,
                        onUnChecked = function()
                            adminManagement.CreateDrugs.Laboratory.list[k].active = false

                            adminManagement.CreateDrugs.Laboratory.activeLaboratory = false

                            adminManagement.CreateDrugs.Laboratory.pos = nil
                        end
                    })
                end

                for k,v in pairs(adminManagement.CreateDrugs.Laboratory.list) do
                    if v.active == true then
                        adminManagement.CreateDrugs.Laboratory.activeLaboratory = true
                        adminManagement.CreateDrugs.Laboratory.activeLaboratoryName = v.name
                    end
                end

                if adminManagement.CreateDrugs.Laboratory.activeLaboratory then
                    RageUI.Separator('~y~↓ Informations et Paramètres du laboratoire ↓~s~')
                    RageUI.Separator(('%s'):format(adminManagement.CreateDrugs.Laboratory.list[adminManagement.CreateDrugs.Laboratory.activeLaboratoryName].label))
                    RageUI.Button('Nom du laboratoire', nil, {RightLabel = not  adminManagement.CreateDrugs.Laboratory.name and '~r~Indéfini~s~' or  adminManagement.CreateDrugs.Laboratory.name}, true, {
                        onSelected = function()
                            KeyboardUtils.use('Nom du laboratoire', function(data)
                                if data == nil or data == '' then return end

                                adminManagement.CreateDrugs.Laboratory.name = data
                            end)
                        end
                    })
                    RageUI.Button('Position du laboratoire', adminManagement.CreateDrugs.Laboratory.pos or '', {RightLabel = not adminManagement.CreateDrugs.Laboratory.pos and '~r~Indéfini~s~' or '~g~Défini~s~'}, true, {
                        onActive = function()
                            if adminManagement.CreateDrugs.Laboratory.pos then
                                v = adminManagement.CreateDrugs.Laboratory.pos
                                DrawMarker(1, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 240, 255, 0, 255, false, false, 2, false, false, false, false)
                                DrawInstructionBarNotification(v.x, v.y, v.z, (v.x..' '..v.y..' '..v.z.. ' (Position du laboratoire)'))
                            end
                        end,
                        onSelected = function()
                            adminManagement.CreateDrugs.Laboratory.pos = Player.coords
                        end
                    })
                end
            end
            RageUI.Line()
            RageUI.Button('Confirmer', nil, {Color = {BackgroundColor = {0,255,0,150}}}, true, {
                onSelected = function()

                    if not adminManagement.CreateDrugs.Laboratory.active then
                        if json.encode(adminManagement.CreateDrugs) == '[]' then return end
                        if not adminManagement.CreateDrugs.posTraitement then return end
                        if not adminManagement.CreateDrugs.posRecolte then return end
    
                        if #adminManagement.CreateDrugs.posTraitement < 1 then return end
                        if #adminManagement.CreateDrugs.posRecolte < 1 then return end
    
                        if adminManagement.CreateDrugs.name == nil or adminManagement.CreateDrugs.label == nil then return end 
                        if adminManagement.CreateDrugs.recolte_animtype == nil or adminManagement.CreateDrugs.recolte_animdict == nil then return end
    
                        if adminManagement.CreateDrugs.traitement_animtype == nil or adminManagement.CreateDrugs.traitement_animdict == nil then return end
    
                        if adminManagement.CreateDrugs.name_pooch == nil or adminManagement.CreateDrugs.label_pooch == nil then return end
    
                        if adminManagement.CreateDrugs.recolte_animtime == nil then return end
                        if adminManagement.CreateDrugs.traitement_animtime == nil then return end 
    
                        if SunnyDrugs.Drugs[adminManagement.CreateDrugs.name] then return ESX.ShowNotification('Cette drogue existe déjà') end
    
                        TriggerServerEvent('sunny:drugs:create', adminManagement.CreateDrugs)
                    else
                        if not adminManagement.CreateDrugs.Laboratory.activeLaboratory then return end
                        if adminManagement.CreateDrugs.Laboratory.name == nil then return end
                        if adminManagement.CreateDrugs.Laboratory.pos == nil then return end

                        TriggerServerEvent('sunny:admin:labo:create', adminManagement.CreateDrugs.Laboratory)
                    end
                end
            })
        end)

        RageUI.IsVisible(weaponsSell, function()
            RageUI.Button('Ajouter un groupe', 'Ajouter un groupe pour la vente d\'armes', {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:admin:getAllJobs', function(cb)
                        adminManagement.SelectedJobType = 0
                        adminManagement.AddJobList = cb
                        RageUI.Visible(weaponsSellGroupList, true)
                    end)
                end
            })
            RageUI.Line()
            for k,v in pairs(adminManagement.SellingList) do
                RageUI.Button(v.name..' - '..v.label, 'Supprimer ce groupe de la vente d\'armes', {}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName,
                            'Êtes-vous sûr de vouloir supprimer ce groupe de la vente d\'armes ?',
                            '',
                            function(response)
                                if response then -- Oui
                                    TriggerServerEvent('sunny:weapons:sell:delete', v.name)
                                    RageUI.GoBack()
                                else -- Non
                                    ESX.ShowNotification('Suppression annulée')
                                end
                            end
                        )
                    end
                })
            end
        end)

        RageUI.IsVisible(weaponsSellGroupList, function()
            RageUI.Button('Rechercher', 'Ajouter ce groupe à la vente d\'arme', {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom/Label/Id du job', function(data)
                        adminManagement.AddSearchJob = data
                    end)
                end
            })
            if adminManagement.AddSearchJob then
                RageUI.Button('❌ Arrêter la Recherche', 'Ajouter ce groupe à la vente d\'arme', {}, true, {
                    onSelected = function()
                        adminManagement.AddSearchJob = nil
                    end
                })
            end
            for k,v in pairs(adminManagement.AddJobList) do
                local jobData = ('[%s] %s (%s)'):format(k, v.name, v.label)
                if tonumber(v.type) == tonumber(adminManagement.SelectedJobType) then
                    if (not adminManagement.AddSearchJob) then
                        RageUI.Button(jobData, 'Ajouter ce groupe à la vente d\'arme', {}, true, {
                            onSelected = function()
                                exports['prompt']:createPrompt(
                                    SunnyConfigServ.ServerName,
                                    'Êtes-vous sûr de vouloir ajouter ce groupe aux ventes d\'armes ?',
                                    '',
                                    function(response)
                                        if response then -- Oui
                                            TriggerServerEvent('sunny:weapons:sell:add', v)
                                            RageUI.GoBack()
                                            ESX.TriggerServerCallback('sunny:admin:getAllJobs', function(cb)
                                                adminManagement.SelectedJobType = 0
                                                adminManagement.AddJobList = cb
                                                RageUI.Visible(weaponsSellGroupList, true)
                                            end)
                                        else -- Non
                                            ESX.ShowNotification('Vous avez annulé l\'action')
                                        end
                                    end
                                )
                            end
                        })
                    else
                        if (string.match(string.lower(jobData), string.lower(adminManagement.AddSearchJob))) then 
                            RageUI.Button(jobData, 'Ajouter ce groupe à la vente d\'arme', {}, true, {
                                onSelected = function()
                                    exports['prompt']:createPrompt(
                                        SunnyConfigServ.ServerName,
                                        'Êtes-vous sûr de vouloir ajouter ce groupe aux ventes d\'armes ?', 
                                        '',
                                        function(response)
                                            if response then -- Oui
                                                TriggerServerEvent('sunny:weapons:sell:add', v)
                                                RageUI.GoBack()
                                                ESX.TriggerServerCallback('sunny:admin:getAllJobs', function(cb)
                                                    adminManagement.SelectedJobType = 0
                                                    adminManagement.AddJobList = cb
                                                    RageUI.Visible(weaponsSellGroupList, true)
                                                end)
                                            else -- Non
                                                ESX.ShowNotification('Vous avez annulé l\'action')
                                            end
                                        end
                                    )
                                end
                            })
                        end
                    end
                end
            end
        end)
    
        RageUI.IsVisible(reportsList, function()
            RageUI.Checkbox('Filtres', nil, adminManagement.Filters, {}, {
                onChecked = function()
                    adminManagement.Filters = true
                end,
                onUnChecked = function()
                    adminManagement.Filters = false
                end
            })
            if adminManagement.Filters == true then
                RageUI.List('Afficher les reports', adminManagement.FiltersList, adminManagement.FiltersListIndex, nil, {}, true, {
                    onListChange = function(Index)
                        adminManagement.FiltersListIndex = Index
                    end
                })
            end
            RageUI.Line()
            for k,v in pairs(adminManagement.Reports) do
                if not adminManagement.Filters or adminManagement.FiltersListIndex == 1 then
                    RageUI.Button((v.take and v.takeUID == ESX.PlayerData.UniqueID and '~g~'..'Report #%s (%s)' or '~r~Report #%s (%s)'):format(k, v.author), ('\n%s\n'):format(v.reason), {RightLabel = v.take == false and '❌' or '✅ '}, true, {
                        onActive = function()
                            RageUI.Info(
                                string.format("%sInformation Report", SunnyConfigServ.GTACOLOR),
                                {'Raison : ', 'Pris par : ', "ID du joueur: " },
                                {v.reason, v.takeBY, k}
                            )
                                                    end,
                        onSelected = function()
                            adminManagement.SelectedReport = v
                        end
                    }, selectedReport)
                elseif adminManagement.Filters and adminManagement.FiltersListIndex == 2 then
                    if v.take == true then
                        RageUI.Button(('Report #%s (%s)'):format(k, v.author), ('\n%s\n'):format(v.reason), {RightLabel = v.take == false and '❌' or '✅'}, true, {
                            onActive = function()
                                RageUI.Info(
                                    string.format("%sInformation Report", SunnyConfigServ.GTACOLOR),
                                    {'Raison : ', 'Pris par : ', "ID du joueur: " },
                                    {v.reason, v.takeBY, k}
                                )
                                                            end,
                            onSelected = function()
                                adminManagement.SelectedReport = v
                            end
                        }, selectedReport)
                    end
                elseif adminManagement.Filters and adminManagement.FiltersListIndex == 3 then
                    if v.take == false then
                        RageUI.Button(('Report #%s (%s)'):format(k, v.author), ('\n%s\n'):format(v.reason), {RightLabel = v.take == false and '❌' or '✅'}, true, {
                            onActive = function()
                                RageUI.Info(
                                    string.format("%sInformation Report", SunnyConfigServ.GTACOLOR),
                                    {'Raison : ', 'Pris par : ', "ID du joueur: " },
                                    {v.reason, v.takeBY, k}
                                )
                                                            end,
                            onSelected = function()
                                adminManagement.SelectedReport = v
                            end
                        }, selectedReport)
                    end
                end
            end
        end)

        RageUI.IsVisible(selectedReport, function()
            RageUI.Separator(adminManagement.SelectedReport.author)
            if not adminManagement.SelectedReport.take then
                RageUI.Button('Prendre le report', nil, {}, true, {
                    onSelected = function()
                        adminManagement.SelectedReport.take = true
                        TriggerServerEvent('sunny:admin:takeReport', adminManagement.SelectedReport.UniqueID, adminManagement.SelectedReport.source)
                        TriggerServerEvent('sunny:admin:getPosForRreturnPlayer', adminManagement.SelectedReport.source)

                        Wait(300)
                        if not adminManagement.NoClip then
                            NoClip(true)
                        end
                    end
                })
            end
            RageUI.Info(
                string.format("%sInformation Report", SunnyConfigServ.GTACOLOR),
                {'Auteur : ', "ID du joueur: " },
                {adminManagement.SelectedReport.author, adminManagement.SelectedReport.UniqueID}
            )
                        RageUI.Button('Clore le report', nil, {}, true, {
                onSelected = function()
                    local reportID = adminManagement.SelectedReport.UniqueID
                    local reportSource = adminManagement.SelectedReport.source
                    local cfg = Config.Staff.Reports

                    RageUI.CloseAll()

                    CreateThread(function()
                        Wait(100)
                        local input = lib.inputDialog(
                            cfg.Modal.Title .. ' #' .. reportID,
                            {
                                {
                                    type = "textarea",
                                    label = "Avis / Résumé de la situation",
                                    description = "Décrivez brièvement comment le report a été résolu",
                                    required = cfg.Modal.RequireReview,
                                    min = cfg.Modal.MinCharacters,
                                    max = cfg.Modal.MaxCharacters
                                },
                                {
                                    type = "select",
                                    label = "Résolution",
                                    options = Config.Staff.GetResolutionOptions(),
                                    default = Config.Staff.GetDefaultResolution()
                                }
                            },
                            { allowCancel = true }
                        )

                        if input then
                            local avis = input[1]
                            local resolution = input[2]
                            TriggerServerEvent('sunny:admin:closeReport', reportID, reportSource, avis, resolution)
                            adminManagement.Reports[reportID] = nil
                            ESX.ShowNotification(cfg.Notifications.StaffSuccess)
                        else
                            ESX.ShowNotification(cfg.Notifications.StaffCancelled)
                        end
                    end)
                end
            })
                if adminManagement.SelectedReport.take then
                if Config.Staff.HavePermission('ManagePlayers', 'goto') then
                    RageUI.Button('Se Téléporter', nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent('sunny:admin:goto', adminManagement.SelectedReport.source)
                        end
                    })
                end
                if Config.Staff.HavePermission('ManagePlayers', 'bring') then
                    RageUI.Button('Téléporter sur moi', nil,  {}, true, {
                        onSelected = function()
                            TriggerServerEvent('sunny:admin:bring', adminManagement.SelectedReport.source, GetEntityCoords(PlayerPedId()))
                        end
                    })
                end
                RageUI.Button('Retourner', nil, {}, true, {
                    onSelected = function()
                        if adminManagement.LastPlayerPos[adminManagement.SelectedReport.source] == nil then return end
    
                        TriggerServerEvent('sunny:admin:xPlayer.return', adminManagement.SelectedReport.source, adminManagement.LastPlayerPos[adminManagement.SelectedReport.source].pos)
                    end
                })
                if Config.Staff.HavePermission('ManagePlayers', 'gopc') then
                    RageUI.Button('Téléporter au Parking Central', nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent('sunny:admin:teleport', adminManagement.SelectedReport.source, vector3(234.06896972656, -756.89605712891, 37.856971740723))
                            ESX.ShowNotification('✅ Joueur téléporter avec succès')
                        end
                    })
                end
                if Config.Staff.HavePermission('ManagePlayers', 'gomb') then
                    RageUI.Button('Téléporter au dessus de la Maze Bank', nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent('sunny:admin:teleport', adminManagement.SelectedReport.source, vector3(-75.012283325195, -818.96472167969, 326.17532348633))
                            ESX.ShowNotification('✅ Joueur téléporter avec succès')
                        end
                    })
                end
                if Config.Staff.HavePermission('ManagePlayers', 'Message') then
                    RageUI.Button('Envoyer un message', nil, {}, true, {
                        onSelected = function()
                            KeyboardUtils.use('Message', function(data)
                                if data == nil or data == '' then return ESX.ShowNotification('Argument manquant') end
                                
                                TriggerServerEvent('sunny:staff:players:takeMessage', adminManagement.SelectedReport.source, data)
                            end)
                        end
                    })
                end
                RageUI.Line()
                RageUI.Button('Freeze Unfreeze', nil, {}, true, {
                    onSelected = function()
                        if adminManagement.FreezeUnfreeze then
                            adminManagement.FreezeUnfreeze = false
                            TriggerServerEvent('sunny:admin:freezeunfreezeplayer', adminManagement.SelectedReport.source, 'unfreeze')
                            ESX.ShowNotification('✅ Joueur unfreeze avec succès')
                        else
                            adminManagement.FreezeUnfreeze = true
                            TriggerServerEvent('sunny:admin:freezeunfreezeplayer', adminManagement.SelectedReport.source, 'freeze')
                            ESX.ShowNotification('✅ Joueur freeze avec succès')
                        end
                    end
                })

                if Config.Staff.HavePermission('ManagePlayers', 'playerinformations') then
                    RageUI.Button('Informations', nil, {}, true, {
                        onSelected = function()
                            
                        end
                    }, infoReportPlayer)
                end
                
                if Config.Staff.HavePermission('ManagePlayers', 'screen') then
                    RageUI.Button('Screen', nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent('sunny:admin:screen', adminManagement.SelectedReport.source)
                            ESX.ShowNotification('📷 Vous retrouverez le screen dans les logs')
                        end
                    })
                end
                if Config.Staff.HavePermission('ManagePlayers', 'revive') then
                    RageUI.Button('Revive', nil, {}, true, {
                        onSelected = function()
                            ExecuteCommand("revive " ..adminManagement.SelectedReport.UniqueID)
                            ESX.ShowNotification('✅ Joueur revive avec succès')
                        end
                    })
                end
                if Config.Staff.HavePermission('ManagePlayers', 'heal') then
                    RageUI.Button('Heal', nil, {}, true, {
                        onSelected = function()
                            ExecuteCommand("heal " ..adminManagement.SelectedReport.UniqueID)
                            ESX.ShowNotification('✅ Joueur heal avec succès')
                        end
                    })
                end
                if Config.Staff.HavePermission('ManagePlayers', 'givepanto') then
                    RageUI.Button('Donner Panto', nil, {}, not adminManagement.cooldown, {
                        onSelected = function()
                            TriggerServerEvent('sunny:admin:spawnVehicle', adminManagement.SelectedReport.source, 'panto')
                            adminManagement.cooldown = true
                            SetTimeout(2500, function()
                                adminManagement.cooldown = false
                            end)
                            ESX.ShowNotification('✅ Véhicule give avec succès')
                        end
                    })
                end
                RageUI.Line()

                if Config.Staff.HavePermission('ManagePlayers', 'clearinventory') then
                    RageUI.Button('Clear l\'inventaire', nil, {}, true, {
                        onSelected = function()
                            exports['prompt']:createPrompt(
                                SunnyConfigServ.ServerName, 
                                'Êtes-vous sûr de vouloir vider l\'inventaire de ce joueur ?',
                                '',
                                function(response)
                                    if response then -- Oui
                                        TriggerServerEvent('sunny:admin:clearInventory', adminManagement.SelectedReport.source)
                                    else -- Non
                                        ESX.ShowNotification('Vidage d\'inventaire annulé')
                                    end
                                end
                            )
                        end
                    })
                end
                
                if Config.Staff.HavePermission('ManagePlayers', 'clearweapons') then
                    RageUI.Button('Clear les armes', nil, {}, true, {
                        onSelected = function()
                            exports['prompt']:createPrompt(
                                SunnyConfigServ.ServerName,
                                'Êtes-vous sûr de vouloir vider les armes de ce joueur ?',
                                '',
                                function(response)
                                    if response then -- Oui
                                        TriggerServerEvent('sunny:admin:clearWeapon', adminManagement.SelectedReport.source)
                                    else -- Non
                                        ESX.ShowNotification("Vous avez annulé l'action")
                                    end
                                end
                            )
                        end
                    })
                end
                

                RageUI.Line()
                if Config.Staff.HavePermission('ManagePlayers', 'changejob') then
                    RageUI.Button('Changer le job', nil, {}, true, {
                        onSelected = function()
    
                        end
                    }, addJobReportPlayer)
                end
                if Config.Staff.HavePermission('ManagePlayers', 'changegroup') then
                    RageUI.Button('Changer le group', nil, {}, true, {
                        onSelected = function()
                            
                        end
                    }, changeReportPlayerGroup)
                end
            end
        end)

        RageUI.IsVisible(infoReportPlayer, function()
            RageUI.Button('Argents', nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:admin.getAccounts', function(cb)
                        adminManagement.accounts = cb
                    
                    end, adminManagement.SelectedReport.UniqueID)
                end
            }, accountsReportPlayer)
            RageUI.Button('Jobs', nil, {}, true, {
                onSelected = function()

                end
            }, jobReportPlayer)
        end)


        RageUI.IsVisible(accountsReportPlayer, function()
            for k,v in pairs(adminManagement.accounts) do
                if v.name == 'cash' then
                    RageUI.Button(('Cash '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(v.money), nil, {}, true, {

                    })
                end
                if v.name == 'bank' then
                    RageUI.Button(('Bank '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(v.money), nil, {}, true, {

                    })
                end
                if v.name == 'black_money' then
                    RageUI.Button(('Argent Sale '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(v.money), nil, {}, true, {

                    })
                end
            end
        end)
        
        RageUI.IsVisible(jobReportPlayer, function()
            RageUI.Button(('Entreprise '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(adminManagement.SelectedReport.job.label), nil, {}, true, {
                onSelected = function()
                end
            })
            RageUI.Button(('Gang/Organisation '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(adminManagement.SelectedReport.job2.label), nil, {}, true, {
                onSelected = function()
                end
            })
        end)

        
        RageUI.IsVisible(addJobReportPlayer, function()
            RageUI.Button('Changer le job en Entreprise', nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:admin:getAllJobs', function(cb)
                        adminManagement.SelectedJobType = 1
                        adminManagement.AddJobList = cb
                    end)
                end
            }, addJobReportPlayerList)
            RageUI.Button('Changer le job en Gang/Organisation', nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:admin:getAllJobs', function(cb)
                        adminManagement.SelectedJobType = 0
                        adminManagement.AddJobList = cb
                    end)
                end
            }, addJobReportPlayerList)
        end)

        RageUI.IsVisible(addJobReportPlayerList, function()
            RageUI.Button('Rechercher', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom/Label/Id du job', function(data)
                        adminManagement.AddSearchJob = data
                    end)
                end
            })
            if adminManagement.AddSearchJob then
                RageUI.Button('❌ Arrêter la Recherche', nil, {}, true, {
                    onSelected = function()
                        adminManagement.AddSearchJob = nil
                    end
                })
            end
            for k,v in pairs(adminManagement.AddJobList) do
                local jobData = ('[%s] %s (%s)'):format(k, v.name, v.label)
                if tonumber(v.type) == tonumber(adminManagement.SelectedJobType) then
                    if not adminManagement.AddSearchJob then
                        RageUI.Button(jobData, nil, {}, true, {
                            onSelected = function()
                                ESX.TriggerServerCallback('sunny:admin:getGradeWithJob', function(cb)
                                    adminManagement.AddGradeListWithJob = cb
                                    adminManagement.SelectedPlayerJobList = v
                                end, v.name)
                            end
                        }, addReportJobGradeWithJobList)
                    else
                        if string.match(string.lower(jobData), string.lower(adminManagement.AddSearchJob)) then 
                            RageUI.Button(jobData, nil, {}, true, {
                                onSelected = function()
                                    ESX.TriggerServerCallback('sunny:admin:getGradeWithJob', function(cb)
                                        adminManagement.AddGradeListWithJob = cb
                                        adminManagement.SelectedPlayerJobList = v
                                    end, v.name)
                                end
                            }, addReportJobGradeWithJobList)
                        end
                    end
                end
            end
        end)

        RageUI.IsVisible(addReportJobGradeWithJobList, function()
            for k,v in pairs(adminManagement.AddGradeListWithJob) do
                RageUI.Button(('[%s] %s (%s)'):format(v.grade, v.name, v.label), nil, {}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName, 
                            'Êtes-vous sûr de vouloir définir ce job pour ce joueur ?',
                            '',
                            function(response)
                                if response then -- Oui
                                    if tonumber(adminManagement.SelectedJobType) == 0 then
                                        TriggerServerEvent('sunny:admin:setPlayerJob', adminManagement.SelectedReport.source, adminManagement.SelectedPlayerJobList.name, v.grade, 'job2')
                                    else
                                        TriggerServerEvent('sunny:admin:setPlayerJob', adminManagement.SelectedReport.source, adminManagement.SelectedPlayerJobList.name, v.grade, 'job') 
                                    end
                                    ESX.ShowNotification('✅ Joueur setJob avec succès')
                                else -- Non
                                    ESX.ShowNotification('Vous avez annulé l\'action')
                                end
                            end
                        )
                    end
                })
            end
        end)

        RageUI.IsVisible(changeReportPlayerGroup, function()
            Config.Staff.Permissions['ServerGroup'] = sortGroupTable(Config.Staff.Permissions['ServerGroup'])
            for k,v in pairs(Config.Staff.Permissions['ServerGroup'][ESX.GetPlayerData().group]) do
                RageUI.Button(v.label, nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent('sunny:admin:setGroup', adminManagement.SelectedReport.source, v.value)
                        ESX.ShowNotification('✅ Joueur setgroup avec succès')
                    end
                })
            end
        end)

        RageUI.IsVisible(SearchUniqueID, function()
            RageUI.Button('Rechercher une ID Unique', nil, {}, true, {
                onSelected = function()
                    adminManagement.UniqueIDSearch = {}
                    KeyboardUtils.use('Entrée une ID Unique', function(data)
                        local data = tonumber(data)
                        if data == nil or data == '' or data <= 0 then return ESX.ShowNotification('Impossible de trouver l\'ID Unique') end

                        ESX.TriggerServerCallback('sunny:admin:getUniqueIDUnique', function(cb)
                            if json.encode(cb) ~= '[]' then
                                adminManagement.UniqueIDSearch = cb
                                RageUI.Visible(UniqueIDresult, true)
                            end
                        end, data)
                    end)
                end
            })
        end)

        RageUI.IsVisible(UniqueIDresult, function()
            RageUI.Separator(
                string.format("%s%s~s~ (%s%s~s~)", SunnyConfigServ.GTACOLOR, adminManagement.UniqueIDSearch[1].playerName, SunnyConfigServ.GTACOLOR, adminManagement.UniqueIDSearch[1].id or '')
            )
            RageUI.Separator(('Statut du joueur : %s'):format(adminManagement.UniqueIDSearch[1].id ~= nil and '~g~Connecté~s~' or '~r~Déconnecté~s~'))

            if Config.Staff.HavePermission('ManagePlayers', 'goto') then
                RageUI.Button('Se Téléporter', nil, {}, true, {
                    onSelected = function()
                        if adminManagement.UniqueIDSearch[1].id == nil then return end
                        TriggerServerEvent('sunny:admin:goto', adminManagement.UniqueIDSearch[1].id)
                    end
                })
            end
            if Config.Staff.HavePermission('ManagePlayers', 'bring') then
                RageUI.Button('Téléporter sur moi', nil,  {}, true, {
                    onSelected = function()
                        if adminManagement.UniqueIDSearch[1].id == nil then return end

                        TriggerServerEvent('sunny:admin:bring', adminManagement.UniqueIDSearch[1].id, GetEntityCoords(PlayerPedId()))
                    end
                })
            end
            RageUI.Button('Retourner', nil, {}, true, {
                onSelected = function()
                    if adminManagement.UniqueIDSearch[1].id == nil then return end
                    if adminManagement.LastPlayerPos[adminManagement.UniqueIDSearch[1].id] == nil then return end

                    TriggerServerEvent('sunny:admin:xPlayer.return', adminManagement.UniqueIDSearch[1].id, adminManagement.LastPlayerPos[adminManagement.UniqueIDSearch[1].id].pos)
                end
            })
            if Config.Staff.HavePermission('ManagePlayers', 'Message') then
                RageUI.Button('Envoyer un message', nil, {}, true, {
                    onSelected = function()
                        if adminManagement.UniqueIDSearch[1].id == nil then return end
                        KeyboardUtils.use('Message', function(data)
                            if data == nil or data == '' then return ESX.ShowNotification('Argument manquant') end
                            
                            TriggerServerEvent('sunny:staff:players:takeMessage', adminManagement.UniqueIDSearch[1].id, data)
                        end)
                    end
                })
            end
            RageUI.Line()
            if (Config.Staff.HavePermission('ManagePlayers', 'spectate')) then
                RageUI.Button('Spectate', nil, {}, true, {
                    onSelected = function()
                        RageUI.CloseAll()
                        Wait(750)
                        TriggerServerEvent('sunny:admin:spectatePlayer', tonumber(adminManagement.UniqueIDSearch[1].UniqueID))
                    end
                })
            end
            if (Config.Staff.HavePermission('ManagePlayers', 'screen')) then
                RageUI.Button('Screen', nil, {}, true, {
                    onSelected = function()
                        if adminManagement.UniqueIDSearch[1].id == nil then return end

                        TriggerServerEvent('sunny:admin:screen', adminManagement.UniqueIDSearch[1].id)
                        ESX.ShowNotification('📷 Vous retrouverez le screen dans les logs')
                    end
                })
            end

            if adminManagement.UniqueIDSearch[1].isBaned == true then
                RageUI.Button('Débanir le joueur', nil, {}, true, {
                    onSelected = function()
                        
                    end
                })
            end
            RageUI.Button('Inventaire', nil, {}, true, {
                onSelected = function()
                    
                end
            }, UniqueIDPlayerInventory)

            RageUI.Line()
            if (Config.Staff.HavePermission('ManagePlayers', 'WARN')) then
                RageUI.Button('Mettre un Avertissement', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Raison', function(data)
                            ExecuteCommand(('warn %s %s'):format(adminManagement.UniqueIDSearch[1].UniqueID, data))
                        end)
                    end
                })
                RageUI.Button('Voir la liste des Warns', nil, {}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('sunny:admin:getWarnList', function(cb)
                            adminManagement.WarnList = cb
                        end, adminManagement.UniqueIDSearch[1].UniqueID)
                    end
                }, WarnListPlayerUniqueID)
                RageUI.Button('Sanctions', nil, {}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('sunny:admin:getSanctions', function(cb)
                            
                        end)
                    end
                })
            end

            if ESX.GetPlayerData()["group"] == "fondateur" then
                RageUI.Line()
                RageUI.Button('Ajouter le VIP', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Durée VIP en heures', function(time)
                            if time then
                                exports['prompt']:createPrompt(
                                    SunnyConfigServ.ServerName,
                                    ('Voulez-vous donner le VIP à l\'ID unique %s pendant %s heures ?'):format(adminManagement.UniqueIDSearch[1].UniqueID, time),
                                    '',
                                    function(response)
                                        if response then -- Oui
                                            ExecuteCommand(('addvip %s %s'):format(adminManagement.UniqueIDSearch[1].UniqueID, time))
                                            ESX.ShowNotification(('✅ VIP ajouté à l\'ID %s pendant %s heures'):format(adminManagement.UniqueIDSearch[1].UniqueID, time))
                                        else -- Non
                                            ESX.ShowNotification("Vous avez annulé l'attribution du VIP")
                                        end
                                    end
                                )
                            end
                        end)
                    end
                })
                RageUI.Button('Retirer le VIP', nil, {}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName, 
                            ('Voulez-vous retirer le VIP à l\'ID unique %s ?'):format(adminManagement.UniqueIDSearch[1].UniqueID),
                            '',
                            function(response)
                                if response then -- Oui
                                    ExecuteCommand(('removevip %s'):format(adminManagement.UniqueIDSearch[1].UniqueID))
                                    ESX.ShowNotification(('✅ VIP retiré à l\'ID %s'):format(adminManagement.UniqueIDSearch[1].UniqueID))
                                else -- Non
                                    ESX.ShowNotification("Vous avez annulé le retrait du VIP")
                                end
                            end
                        )
                    end
                })
                RageUI.Button('Give des Coins', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Nombre de coins', function(coins)
                            if coins then
                                exports['prompt']:createPrompt(
                                    SunnyConfigServ.ServerName,
                                    ('Voulez-vous donner %s coins à l\'ID unique %s ?'):format(coins, adminManagement.UniqueIDSearch[1].UniqueID),
                                    '',
                                    function(response)
                                        if response then -- Oui
                                            TriggerServerEvent('sunny:admin:giveBoutiqueCoins', adminManagement.UniqueIDSearch[1].UniqueID, tonumber(coins))
                                            ESX.ShowNotification(('✅ %s coins donnés à l\'ID %s'):format(coins, adminManagement.UniqueIDSearch[1].UniqueID))
                                        else -- Non
                                            ESX.ShowNotification("Vous avez annulé le don de coins")
                                        end
                                    end
                                )
                            end
                        end)
                    end
                })

                RageUI.Button('Historique boutique', nil, {}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('sunny:admin:uniqueid:boutiquehistory', function(cb)
                            adminManagement.UniqueIDSearchBoutiqueHistory = cb
                        end, adminManagement.UniqueIDSearch[1].UniqueID)
                    end
                }, UniqueIDPlayerBoutiqueHistory)
            end

            RageUI.Line()
            if (Config.Staff.HavePermission('ManagePlayers', 'changejob')) then
                RageUI.Button('Changer le Job', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Nom du job', function(data)
                            CreateThread(function()
                                KeyboardUtils.use('Grade', function(data2)
                                    ExecuteCommand(('setjob %s %s %s'):format(adminManagement.UniqueIDSearch[1].UniqueID, data, tonumber(data2)))
                                end)
                            end)
                        end)
                    end
                })
            end
            if (Config.Staff.HavePermission('ManagePlayers', 'changegroup')) then
                RageUI.Button('Changer Groupe', nil, {}, true, {
                    onSelected = function()
                        
                    end
                }, changePlayerGroupWithUniqueID)
            end
            if Config.Staff.HavePermission('UniqueIDoptions', 'GIVE_MONEY') then 
                RageUI.Button('Give de l\'argent ( Propre )', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Montant', function(data)
                            local data = tonumber(data)
                            if data == nil then return end
                            TriggerServerEvent('sunny:admin:uniqueid:addmoney', adminManagement.UniqueIDSearch[1].UniqueID, 'cash', data)
                        end)
                    end
                })
                RageUI.Button('Give de l\'argent ( Banque )', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Montant', function(data)
                            local data = tonumber(data)
                            if data == nil then return end
                            TriggerServerEvent('sunny:admin:uniqueid:addmoney', adminManagement.UniqueIDSearch[1].UniqueID, 'bank', data)
                        end)
                    end
                })
                RageUI.Button('Give de l\'argent ( Sale )', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Montant', function(data)
                            local data = tonumber(data)
                            if data == nil then return end
                            TriggerServerEvent('sunny:admin:uniqueid:addmoney', adminManagement.UniqueIDSearch[1].UniqueID, 'black_money', data)
                        end)
                    end
                })
            end
            --[[if Config.Staff.HavePermission('UniqueIDoptions', 'GIVE_WEAPON') then 
                RageUI.Button('Give une arme', nil, {}, true, {
                    onSelected = function()

                    end
                }, WeaponListIDUnique)
            end ]]--
            if Config.Staff.HavePermission('UniqueIDoptions', 'GIVE_ITEM') then 
                RageUI.Button('Give un Item', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Recherche (optionnel)', function(searchTerm)
                            ESX.TriggerServerCallback('sunny:admin:itemsList', function(result)
                                if result and result.stashId then
                                    -- Envoyer les infos du joueur cible au serveur
                                    TriggerServerEvent('sunny:admin:setStashTarget', result.stashId, 
                                        adminManagement.UniqueIDSearch[1].UniqueID, 
                                        adminManagement.UniqueIDSearch[1])
                                    
                                    -- Ouvrir le stash ox_inventory
                                    exports.ox_inventory:openInventory('stash', result.stashId)
                                else
                                    local errorMsg = result and result.error or 'Erreur inconnue'
                                    ESX.ShowNotification('~r~' .. errorMsg)
                                end
                            end, searchTerm)
                        end)
                    end
                })
            end
            if Config.Staff.HavePermission('UniqueIDoptions', 'GIVE_VEHICLE') then
                RageUI.Button('Give un véhicule', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        
                    end
                }, UniqueIDPlayerDataGIVE_VEHICLE)
            end
            RageUI.Line()

            if Config.Staff.HavePermission('ManagePlayers', 'wipe') then
                RageUI.Button('Wipe', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName, 
                            'Êtes-vous sûr de vouloir effectuer un wipe ?',
                            '',
                            function(response)
                                if response then -- Oui
                                    TriggerServerEvent('sunny:admin:players:wipeUniqueID', adminManagement.UniqueIDSearch[1].UniqueID)
                                else -- Non
                                    ESX.ShowNotification('Action annulée')
                                end
                            end
                        )
                    end
                })
            end

            if Config.Staff.HavePermission('ManagePlayers', 'clearinventory') then
                RageUI.Button('Clear l\'inventaire', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName,
                            'Êtes-vous sûr de vouloir clear l\'inventaire ?',
                            '',
                            function(response)
                                if response then -- Oui
                                    ExecuteCommand(('clearinventory %s'):format(adminManagement.UniqueIDSearch[1].UniqueID))
                                else -- Non
                                    ESX.ShowNotification("Vous avez annulé l'action") 
                                end
                            end
                        )
                    end
                })
            end
            
            if Config.Staff.HavePermission('ManagePlayers', 'clearweapons') then
                RageUI.Button('Clear les armes', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName,
                            'Êtes-vous sûr de vouloir clear les armes ?', 
                            '',
                            function(response)
                                if response then -- Oui
                                    ExecuteCommand(('clearloadout %s'):format(adminManagement.UniqueIDSearch[1].UniqueID))
                                else -- Non
                                    ESX.ShowNotification("Vous avez annulé l'action")
                                end
                            end
                        )
                    end
                })
            end
        end)
            

            RageUI.IsVisible(UniqueIDPlayerDataGIVE_Item, function()
                RageUI.Button('Rechercher', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Recherche', function(data)
                            adminManagement.WeaponSearch = data
                        end)
                    end
                })
            
                if adminManagement.WeaponSearch then
                    RageUI.Button('❌ Arrêter la Recherche', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            adminManagement.WeaponSearch = nil
                        end
                    })
                end
            
                for k,v in pairs(adminManagement.ItemsList) do
                    local buttonName = ('[%s] %s'):format(v.name, v.label)
                    if not adminManagement.WeaponSearch then
                        RageUI.Button(buttonName, nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                                KeyboardUtils.use('Quantité', function(data)
                                    local data = tonumber(data)
                                    if data == nil then return end
            
                                    TriggerServerEvent('sunny:admin:UniqueID:giveitem', adminManagement.UniqueIDSearch[1].UniqueID, adminManagement.UniqueIDSearch[1], v, data)
                                end)
                            end
                        })
                    else
                        if (string.match(string.lower(buttonName), string.lower(adminManagement.WeaponSearch))) then
                            RageUI.Button(buttonName, nil, {RightLabel = '→'}, true, {
                                onSelected = function()
                                    KeyboardUtils.use('Quantité', function(data)
                                        local data = tonumber(data)
                                        if data == nil then return end
            
                                        TriggerServerEvent('sunny:admin:UniqueID:giveitem', adminManagement.UniqueIDSearch[1].UniqueID, adminManagement.UniqueIDSearch[1], v, data)
                                    end)
                                end
                            })
                        end
                    end
                end
            end)
            
            RageUI.IsVisible(UniqueIDPlayerInventory, function()
                RageUI.Separator('Argents')
                for k,v in pairs(adminManagement.UniqueIDSearch[1].accounts) do
                    if v.name == 'cash' then
                        RageUI.Button(('Cash :  '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(v.money), nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                                if Config.Staff.HavePermission('UniqueIDoptions', 'clearmoney') then
                                    KeyboardUtils.use('Nombre à enlever', function(data)
                                        local data = tonumber(data)
                                        if data == nil or data == '' or data <= 0 or v.money < data then
                                            return ESX.ShowNotification('Argument manquant ou le joueur ne possède pas suffisement d\'argent')
                                        end
            
                                        TriggerServerEvent('sunny:admin:uniqueid:removeMoney', adminManagement.UniqueIDSearch[1].id, adminManagement.UniqueIDSearch[1].UniqueID, data, 'cash')
                                    end)
                                end
                            end
                        })
                    end
                    if v.name == 'bank' then
                        RageUI.Button(('Bank :  '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(v.money), nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                                if Config.Staff.HavePermission('UniqueIDoptions', 'clearmoney') then
                                    KeyboardUtils.use('Nombre à enlever', function(data)
                                        local data = tonumber(data)
                                        if data == nil or data == '' or data <= 0 or v.money < data then
                                            return ESX.ShowNotification('Argument manquant ou le joueur ne possède pas suffisement d\'argent')
                                        end
            
                                        TriggerServerEvent('sunny:admin:uniqueid:removeMoney', adminManagement.UniqueIDSearch[1].id, adminManagement.UniqueIDSearch[1].UniqueID, data, 'bank')
                                    end)
                                end
                            end
                        })
                    end
                    if v.name == 'black_money' then
                        RageUI.Button(('Argent Sale :  '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(v.money), nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                                if Config.Staff.HavePermission('UniqueIDoptions', 'clearmoney') then
                                    KeyboardUtils.use('Nombre à enlever', function(data)
                                        local data = tonumber(data)
                                        if data == nil or data == '' or data <= 0 or v.money < data then
                                            return ESX.ShowNotification('Argument manquant ou le joueur ne possède pas suffisement d\'argent')
                                        end
            
                                        TriggerServerEvent('sunny:admin:uniqueid:removeMoney', adminManagement.UniqueIDSearch[1].id, adminManagement.UniqueIDSearch[1].UniqueID, data, 'black_money')
                                    end)
                                end
                            end
                        })
                    end
                end
            
                RageUI.Separator('Items')
                if json.encode(adminManagement.UniqueIDSearch[1].inventory) ~= '[]' then
                    for k,v in pairs(json.decode(adminManagement.UniqueIDSearch[1].inventory)) do
                        RageUI.Button(('%s '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(v.name, v.count), nil, {}, true, {
                            onSelected = function()
                                if Config.Staff.HavePermission('UniqueIDoptions', 'clearinventory') then
                                    KeyboardUtils.use('Nombre à enlever', function(data)
                                        local data = tonumber(data)
                                        if data == nil or data == '' or data <= 0 or v.count < data then
                                            return ESX.ShowNotification('Argument manquant ou le joueur n\'en possède pas suffisement')
                                        end
            
                                        TriggerServerEvent('sunny:admin:uniqueid:removeItem', adminManagement.UniqueIDSearch[1].id, adminManagement.UniqueIDSearch[1].UniqueID, data, v.name, json.decode(adminManagement.UniqueIDSearch[1].inventory))
                                        v.count = v.count - 1
                                    end)
                                end
                            end
                        })
                    end
                end
            
                RageUI.Separator('Armes')
                if json.encode(adminManagement.UniqueIDSearch[1].loadout) ~= '[]' then
                    for k,v in pairs(json.decode(adminManagement.UniqueIDSearch[1].loadout)) do
                        RageUI.Button(('%s '..SunnyConfigServ.GTACOLOR..'%s~s~'):format(v.label, v.ammo), nil, {}, true, {
                            onSelected = function()
                                adminManagement.UniqueIDPlayerInventoryWeaponSelect = v
                                adminManagement.UniqueIDPlayerInventoryWeaponSelectK = k
                                adminManagement.selectedWeaponCompo = v.components
                            end
                        }, UniqueIDPlayerInventoryWeaponSelect)
                    end
                end
            end)
            

        RageUI.IsVisible(UniqueIDPlayerInventoryWeaponSelect, function()
            RageUI.Button('Supprimer temporairement', nil, {}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Êtes-vous sûr de vouloir supprimer temporairement ?',
                        '',
                        function(response)
                            if response then -- Oui
                                TriggerServerEvent('sunny:admin:uniqueid:clearTemporaireWeapon', adminManagement.UniqueIDSearch[1].id, adminManagement.UniqueIDSearch[1].UniqueID, adminManagement.UniqueIDPlayerInventoryWeaponSelect)
                            else -- Non
                                ESX.ShowNotification("Vous avez annulé l'action") 
                            end
                        end
                    )
                end
            })
        
            RageUI.Button('Supprimer l\'arme', nil, {}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName, 
                        'Êtes-vous sûr de vouloir supprimer cette arme ?',
                        '',
                        function(response)
                            if response then -- Oui
                                TriggerServerEvent('sunny:admin:uniqueid.removeWeapon', adminManagement.UniqueIDSearch[1].id, adminManagement.UniqueIDSearch[1].UniqueID, adminManagement.UniqueIDPlayerInventoryWeaponSelect.name, json.decode(adminManagement.UniqueIDSearch[1].loadout), adminManagement.UniqueIDPlayerInventoryWeaponSelect)
                                RageUI.GoBack()
                            else -- Non
                                ESX.ShowNotification("Vous avez annulé l'action")
                            end
                        end
                    )
                end
            })
        
            RageUI.Button('Accessoires', nil, {RightBadge = RageUI.BadgeStyle.Star}, true, {
                onSelected = function()
                    adminManagement.selectedWeapon = adminManagement.UniqueIDPlayerInventoryWeaponSelect.name
                    RageUI.Visible(UniqueIDPlayerWeapponAccesory, true)
                end
            })
        end)  -- Fermeture de RageUI.IsVisible pour UniqueIDPlayerInventoryWeaponSelect
        

        RageUI.IsVisible(UniqueIDPlayerWeapponAccesory, function()
            for k,v in ipairs(ESX.GetWeaponComponents(adminManagement.selectedWeapon)) do
                local hasAccessories = false

                selectedWeapnHash = GetHashKey(adminManagement.selectedWeapon)

                for i,p in pairs(adminManagement.selectedWeaponCompo) do 
                    if p == v.name then
                        hasAccessories = true
                    end
                end
                RageUI.Checkbox(('%s (%s)'):format(v.label, v.name), nil, hasAccessories, {}, {
                    onChecked = function()
                        ExecuteCommand(('giveweaponcomponent %s %s %s'):format(adminManagement.UniqueIDSearch[1].UniqueID, adminManagement.selectedWeapo), v.name)
                    end,
                    onUnChecked = function()

                    end
                })
            end
        end)

        RageUI.IsVisible(UniqueIDPlayerBoutiqueHistory, function()
            RageUI.Button('Rechercher', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Recherche', function(data)
                        adminManagement.UniqueIDSearchBoutiqueHistorySearch = data
                    end)
                end
            })
            if adminManagement.UniqueIDSearchBoutiqueHistorySearch then
                RageUI.Button('❌ Arrêter la Recherche', nil, {}, true, {
                    onSelected = function()
                        adminManagement.UniqueIDSearchBoutiqueHistorySearch = nil
                    end
                })
            end
            for k,v in pairs(adminManagement.UniqueIDSearchBoutiqueHistory) do
                local data = v.data
                if not adminManagement.UniqueIDSearchBoutiqueHistorySearch then
                    RageUI.Button(('%s'):format(data), nil, {}, true, {
                        onSelected = function()
                            
                        end
                    })
                else
                    if string.match(string.lower(data), string.lower(adminManagement.UniqueIDSearchBoutiqueHistorySearch)) then 
                        RageUI.Button(('%s'):format(data), nil, {}, true, {
                            onSelected = function()
                                
                            end
                        })
                    end
                end
            end
        end)

        RageUI.IsVisible(eventOptions, function()
            RageUI.Button('Communautaire', nil, {}, true, {
                onSelected = function()
                    
                end
            }, truckEvent)
            RageUI.Button('Effets spéciaux', nil, {}, true, {
                onSelected = function()
                end
            }, fireWorksEvent)
        end)

        RageUI.IsVisible(truckEvent, function()
            RageUI.Button('Faire un Event Fourgon (Simple)', 'Le joueur doit uniquement ramassé les billets !', {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Valider (Y ou N)', function(data)
                        if data == "y" or data == 'Y' then
                            ExecuteCommand('event')
                        elseif data == "n" or data == 'N' then
                            ESX.ShowNotification('Event Annuler')
                        end
                    end)
                end
            })
            RageUI.Button('Faire un Event Fourgon (Complexe)', 'Le joueur doit detruire le camion et ensuite ramassé les billets !', {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Valider (Y ou N)', function(data)
                        if data == "y" or data == 'Y' then
                            ExecuteCommand('event2')
                        elseif data == "n" or data == 'N' then
                            ESX.ShowNotification('Event Annuler')
                        end
                    end)
                end
            })
            -- RageUI.Button('Faire un Event Easter Eggs', nil, {}, true, {
            --     onSelected = function()
            --         KeyboardUtils.use('Valider (Y ou N)', function(data)
            --             if data == "y" or data == 'Y' then
            --                 RageUI.CloseAll()
            --                 TriggerEvent('sunny:event:easter:startLaunch')
            --             elseif data == "n" or data == 'N' then
            --                 ESX.ShowNotification('Event Annuler')
            --             end
            --         end)
            --     end
            -- })
            RageUI.Button('Faire un Event Keys Vehicule', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Entrez le modèle du véhicule', function(vehicleModel)
                        if vehicleModel and vehicleModel ~= '' then
                            KeyboardUtils.use('Valider (Y ou N)', function(data)
                                if data == "y" or data == 'Y' then
                                    RageUI.CloseAll()
                                    local playerPed = PlayerPedId()
                                    local position = GetEntityCoords(playerPed)
                                    local heading = GetEntityHeading(playerPed)
                                    local zonePosition = position + vector3(5, 5, 0)
                                    local id = math.random(1000)
                                    TriggerServerEvent('events:vehiclesTemporary:server:start', id, {pos = position, heading = heading, marker = zonePosition}, zonePosition, vehicleModel)
                                elseif data == "n" or data == 'N' then
                                    ESX.ShowNotification('Event Annulé')
                                end
                            end)
                        else
                            ESX.ShowNotification('Modèle de véhicule invalide')
                        end
                    end)
                end
            })            
            RageUI.Button('Faire un Event Feu', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Valider (Y ou N)', function(data)
                        if data == "y" or data == 'Y' then
                            RageUI.CloseAll()
                            local position = GetEntityCoords(PlayerPedId())
                            local width = 10.0

                            local id = math.random(1000)
                            TriggerServerEvent('events:fires:server:start', id, position, width)

                        elseif data == "n" or data == 'N' then
                            ESX.ShowNotification('Event Annuler')
                        end
                    end)
                end
            })

            RageUI.Button('Changer la maze bank arena', nil, {}, true, {
                onSelected = function()
                    
                end
            }, mba)

        end)

        local MBA = {
            basketball = {'mba_tribune', 'mba_tarps', 'mba_basketball', 'mba_jumbotron'},
            boxing = {'mba_tribune', 'mba_tarps', 'mba_fighting', 'mba_boxing', 'mba_jumbotron'},
            concert = {'mba_tribune', 'mba_tarps', 'mba_backstage', 'mba_concert', 'mba_jumbotron'},
            curling = {'mba_tribune', 'mba_chairs', 'mba_curling'},
            derby = {'mba_cover', 'mba_terrain', 'mba_derby', 'mba_ring_of_fire'},
            fameorshame = {'mba_tribune', 'mba_tarps', 'mba_backstage', 'mba_fameorshame', 'mba_jumbotron'},
            fashion = {'mba_tribune', 'mba_tarps', 'mba_backstage', 'mba_fashion', 'mba_jumbotron'},
            football = {'mba_tribune', 'mba_chairs', 'mba_field', 'mba_soccer'},
            icehockey = {'mba_tribune', 'mba_chairs', 'mba_field', 'mba_hockey'},
            gokarta = {'mba_cover', 'mba_gokart_01'},
            gokartb = {'mba_cover', 'mba_gokart_02'},
            trackmaniaa = {'mba_trackmania_01', 'mba_cover'},
            trackmaniab = {'mba_trackmania_02', 'mba_cover'},
            trackmaniac = {'mba_trackmania_03', 'mba_cover'},
            trackmaniad = {'mba_trackmania_04', 'mba_cover'},
            mma = {'mba_tribune', 'mba_tarps', 'mba_fighting', 'mba_mma', 'mba_jumbotron'},
            none = {'mba_tribune', 'mba_tarps', 'mba_jumbotron'},
            paintball = {'mba_tribune', 'mba_chairs', 'mba_paintball', 'mba_jumbotron'},
            rocketleague = {'mba_tribune', 'mba_chairs', 'mba_rocketleague'},
            wrestling = {'mba_tribune', 'mba_tarps', 'mba_fighting', 'mba_wrestling', 'mba_jumbotron'},
        }

        RageUI.IsVisible(mba, function()
            for eventName, _ in pairs(MBA) do
                RageUI.Button(eventName, nil, {}, true, {
                    onSelected = function()
                        GlobalState.mba = eventName
                        print("Maze Bank Arena changé pour : " .. eventName)
                    end
                })
            end
        end)

        RageUI.IsVisible(fireWorksEvent, function()
            RageUI.Checkbox('Zone Prédéfinie', nil, adminManagement.EventPos, {}, {
                onChecked = function()
                    adminManagement.EventPos = true
                end,
                onUnChecked = function()
                    adminManagement.EventPos = false
                end
            })
            RageUI.Line()
            if adminManagement.EventPos then
                RageUI.List('Emplacement', adminManagement.EventPosList, adminManagement.EventPosListIndex, nil, {}, true, {
                    onListChange = function(Index)
                        adminManagement.EventPosListIndex = Index
                    end
                })
                RageUI.Checkbox('FireWorks Prédéfinie', nil, adminManagement.EventFireWorksDef, {}, {
                    onChecked = function()
                        adminManagement.EventFireWorksDef = true
                    end,
                    onUnChecked = function()
                        adminManagement.EventFireWorksDef = false
                    end
                })
                if adminManagement.EventFireWorksDef then
                    RageUI.List('Type ( Fireworks )', adminManagement.EventPosListFireWorks, adminManagement.EventPosListFireWorskIndex, nil, {}, true, {
                        onListChange = function(Index, Items)
                            adminManagement.EventPosListFireWorskIndex = Index
                        end
                    })
                else

                end

                RageUI.Button('Temps de l\'evenement', nil, {RightLabel = adminManagement.TimeFireWorks}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Entréer un Temps (Secondes)', function(data)
                            local data = tonumber(data)
                            if data == nil or data == '' or data <= 0 then return end

                            adminManagement.TimeFireWorks = data
                        end)
                    end
                })

                RageUI.Line()

                RageUI.Button('Lancer ( Fireworks )', nil, {}, true, {
                    onSelected = function()
                        if adminManagement.EventFireWorksDef then
                            TriggerServerEvent('sunny:admin:events:fireworks:launchDefinedEvent', adminManagement.EventPosListFireWorks[adminManagement.EventPosListFireWorskIndex], adminManagement.EventPosListData[adminManagement.EventPosListIndex].pos, adminManagement.EventPosListData[adminManagement.EventPosListIndex].pos2, adminManagement.TimeFireWorks)
                        end
                    end
                })
            else
                RageUI.Checkbox('FireWorks Prédéfinie', nil, adminManagement.EventFireWorksDef, {}, {
                    onChecked = function()
                        adminManagement.EventFireWorksDef = true
                    end,
                    onUnChecked = function()
                        adminManagement.EventFireWorksDef = false
                    end
                })
                if adminManagement.EventFireWorksDef then
                    RageUI.List('Type ( Fireworks )', adminManagement.EventPosListFireWorks, adminManagement.EventPosListFireWorskIndex, nil, {}, true, {
                        onListChange = function(Index, Items)
                            adminManagement.EventPosListFireWorskIndex = Index
                        end
                    })
                else
                    RageUI.Button('Entrée un type ( Fireworks )', nil, {}, true, {
                        onSelected = function()
                            KeyboardUtils.use('Nom', function(data)
                                adminManagement.EventFireWorksNotDef = data
                            end)
                        end
                    })
                end

                RageUI.Separator(('Actuellement %s position(s)'):format(#adminManagement.EventFireWorksNotZoneDef))

                RageUI.Button('Définir une position', nil, {}, true, {
                    onSelected = function()
                        local playerCoords = GetEntityCoords(PlayerPedId())
                        adminManagement.EventFireWorksNotZoneDef[#adminManagement.EventFireWorksNotZoneDef+1] = {x = playerCoords.x, y = playerCoords.y, z = playerCoords.z-0.98}
                    end
                })

                RageUI.Button('Retirer la dernière position', nil, {}, true, {
                    onSelected = function()
                        adminManagement.EventFireWorksNotZoneDef[#adminManagement.EventFireWorksNotZoneDef] = nil
                    end
                })

                RageUI.Button('Temps de l\'evenement', nil, {RightLabel = adminManagement.TimeFireWorks}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Entréer un Temps (Secondes)', function(data)
                            local data = tonumber(data)
                            if data == nil or data == '' or data <= 0 then return end

                            adminManagement.TimeFireWorks = data
                        end)
                    end
                })

                RageUI.Line()

                RageUI.Button('Lancer ( Fireworks )', nil, {}, true, {
                    onSelected = function()
                        for k,v in pairs(adminManagement.EventFireWorksNotZoneDef) do
                            if adminManagement.EventFireWorksDef then
                                TriggerServerEvent('sunny:admin:events:fireworks:launchDefinedEvent', adminManagement.EventPosListFireWorks[adminManagement.EventPosListFireWorskIndex], vector3(v.x, v.y, v.z), vector3(v.x, v.y, v.z), adminManagement.TimeFireWorks)
                            else
                                TriggerServerEvent('sunny:admin:events:fireworks:launchDefinedEvent', 'nodef', vector3(v.x, v.y, v.z), vector3(v.x, v.y, v.z), adminManagement.TimeFireWorks, adminManagement.EventFireWorksNotDef)
                            end
                        end
                    end
                })

            end
        end)

        RageUI.IsVisible(openServInfo, function()

            RageUI.Button('Liste des Metiers/Organisation', nil, {RightLabel = '→'}, true, {
                onSelected = function()
                end,
                onActive = function()
                    if not adminManagement.jobsDataLoaded then
                        adminManagement.jobsDataLoaded = true
                        ESX.TriggerServerCallback('sunny:admin:getJobsList', function(data)
                            adminManagement.jobsData = data
                        end)
                    end
                end
            }, openJobList)

           --[[ if (Config.Staff.HavePermission('Modules', 'objects')) then
                RageUI.Button('Liste des Objets', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        WorldProps = WorldProps
                        --jobsProps = exports["Slide"]:getJobProps()
                    end
                }, openObjectsListMenu)
            end]]--

            RageUI.Button('Gestion Staff', nil, {RightLabel = '→'}, true, {
                onSelected = function()

                end
            }, staffGestion)

            RageUI.Button("Gestion des téléphones", nil, {RightLabel = '→'}, true, {}, menuServerOptionsPhone)

            if Config.Staff.HavePermission('ServerOptions', 'announce') then

                RageUI.Button('Effectuer une annonce ( Weazel News )', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        RageUI.CloseAll()
                        exports['core-ui']:OpenWeazelNewsMenu()
                    end
                })

                RageUI.Button('Message de Zone', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        local input = ESX.GetNumberInput("Indiquer la zone (10-100)")
                        if input == nil then
                            ESX.ShowNotification("🚨 Vous devez indiquer un nombre")
                            return
                        end
                
                        if input < 10 or input > 100 then
                            ESX.ShowNotification("~r~La zone doit être entre 10 et 100")
                            return
                        end
                
                        local input2 = ESX.GetTextInput("Indiquer le message")
                        if input2 == nil then
                            ESX.ShowNotification("~r~Le message ne peut pas être nul")
                            return
                        end
                
                        local playerPed = PlayerPedId()
                        local playerCoords = GetEntityCoords(playerPed)
                        local players = ESX.Game.GetPlayersInArea(playerCoords, input)
                        
                        Citizen.CreateThread(function()
                            Citizen.Wait(500)
                            local count = 0
                            local playersIds = {}
                
                            for _, playerId in ipairs(players) do
                                if playerId ~= PlayerId() then
                                    table.insert(playersIds, GetPlayerServerId(playerId))
                                    count = count + 1
                                end
                            end
                
                            if count > 0 then
                                TriggerServerEvent('staff:server:messageZone', playersIds, input2)
                            else
                                ESX.ShowNotification("~r~Aucun joueur trouvé dans la zone spécifiée")
                            end
                        end)
                    end
                })
                RageUI.Button('Revive de Zone', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        local input = ESX.GetNumberInput("Indiquer la zone (10-100)")
                        if input == nil then
                            return ESX.ShowNotification("🚨 Vous devez indiquer un nombre")
                        end

                        if input < 10 or input > 100 then
                            return ESX.ShowNotification("~r~La zone doit être entre 10 et 100")
                        end

                        ExecuteCommand(("reviver %s"):format(input))
                    end
                })
                RageUI.Button('Heal de Zone', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        local input = ESX.GetNumberInput("Indiquer la zone (10-100)")
                        if input == nil then
                            return ESX.ShowNotification("🚨 Vous devez indiquer un nombre")
                        end

                        if input < 10 or input > 100 then
                            return ESX.ShowNotification("~r~La zone doit être entre 10 et 100")
                        end

                        ExecuteCommand(("healer %s"):format(input))
                    end
                })
                RageUI.Button('ATA de Zone', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        local input = ESX.GetNumberInput("Indiquer la zone (10-100)")
                        if input == nil then
                            ESX.ShowNotification("🚨 Vous devez indiquer un nombre")
                            return
                        end
                
                        if input < 10 or input > 100 then
                            ESX.ShowNotification("~r~La zone doit être entre 10 et 100")
                            return
                        end
                
                        local input2 = ESX.GetNumberInput("Type d'ATA (0: normal - 1: cane)")
                        if input2 == nil then
                            ESX.ShowNotification("🚨 Vous devez indiquer un nombre")
                            return
                        end
                
                        if input2 ~= 0 and input2 ~= 1 then
                            ESX.ShowNotification("~r~Le type doit être 0 ou 1")
                            return
                        end
                
                        local input3 = ESX.GetNumberInput("Temps (1-30 minutes)")
                        if input3 == nil then
                            ESX.ShowNotification("🚨 Vous devez indiquer un nombre")
                            return
                        end
                
                        if input3 < 1 or input3 > 30 then
                            ESX.ShowNotification("~r~Le temps doit être supérieur à 1 et inférieur à 30 minutes")
                            return
                        end
                
                        local playerPed = PlayerPedId()
                        local playerCoords = GetEntityCoords(playerPed)
                        local players = ESX.Game.GetPlayersInArea(playerCoords, input)
                        local count = 0
                        local playersIds = {}
                
                        for _, playerId in ipairs(players) do
                            if playerId ~= PlayerId() then
                                table.insert(playersIds, GetPlayerServerId(playerId))
                                count = count + 1
                            end
                        end
                
                        if count > 0 then
                            TriggerServerEvent('admin:server:addZoneAta', playersIds, input2, input3)
                        else
                            ESX.ShowNotification("~r~Aucun joueur trouvé dans la zone spécifiée")
                        end
                    end
                })
            end
        end)
        RageUI.IsVisible(menuServerOptionsPhone, function()
            RageUI.Button("Rechercher un numéro via ID Unique", nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    local input = ESX.GetNumberInput("ID Unique")
                    if input == nil then
                        return ESX.ShowNotification("~r~L'ID unique ne peut pas être nul")
                    end

                    phoneSearchResult = nil

                    ESX.TriggerServerCallback("sunny:getPhoneData", function(data)
                        if not data then
                            return ESX.ShowNotification("~r~Les données entrées sont incorrectes")
                        end

                        phoneSearchResult = data
                    end, input)
                end
            })

            if phoneSearchResult ~= nil then
                RageUI.Separator("Résultat de la recherche:")
                RageUI.Separator(("%s"):format(phoneSearchResult))
            end

            RageUI.Line()

            RageUI.Button("Liste complète des téléphones", nil, {RightLabel = '→'}, true, {
                onSelected = function()
                    adminManagement.PhoneSearch = nil
                    ESX.TriggerServerCallback('sunny:admin:phones:getAll', function(data)
                        adminManagement.PhoneListe = data or {}
                    end)
                end
            }, gestionTelephones)
        end)

        -- ═══════════════════════════════════════════════════════════════════════════
        -- GESTION TELEPHONES AVANCEE
        -- ═══════════════════════════════════════════════════════════════════════════

        RageUI.IsVisible(gestionTelephones, function()
            RageUI.Button('Rechercher', nil, {RightLabel = adminManagement.PhoneSearch or ''}, true, {
                onSelected = function()
                    KeyboardUtils.use('Rechercher (numéro, nom, ID)', function(data)
                        adminManagement.PhoneSearch = data
                    end)
                end
            })

            if adminManagement.PhoneSearch then
                RageUI.Button('❌ Annuler la recherche', nil, {}, true, {
                    onSelected = function()
                        adminManagement.PhoneSearch = nil
                    end
                })
            end

            RageUI.Button('Rafraîchir', nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:admin:phones:getAll', function(data)
                        adminManagement.PhoneListe = data or {}
                        ESX.ShowNotification('~g~Liste téléphones rafraîchie')
                    end)
                end
            })

            RageUI.Line()
            RageUI.Separator(('~b~%s~s~ téléphones'):format(#adminManagement.PhoneListe))

            for k, v in pairs(adminManagement.PhoneListe) do
                local phoneLabel = ('%s - %s'):format(v.phone_number or 'N/A', v.playerName or 'Inconnu')
                local showItem = true

                if adminManagement.PhoneSearch then
                    local searchLower = string.lower(adminManagement.PhoneSearch)
                    showItem = string.match(string.lower(phoneLabel), searchLower) or
                               string.match(string.lower(tostring(v.UniqueID or '')), searchLower) or
                               string.match(string.lower(v.phone_number or ''), searchLower)
                end

                if showItem then
                    RageUI.Button(phoneLabel, ('ID Unique: %s'):format(v.UniqueID or 'N/A'), {RightLabel = '→'}, true, {
                        onSelected = function()
                            adminManagement.SelectedPhone = v
                        end
                    }, gestionTelephonesSelected)
                end
            end
        end)

        RageUI.IsVisible(gestionTelephonesSelected, function()
            if not adminManagement.SelectedPhone then return end
            local phone = adminManagement.SelectedPhone

            RageUI.Separator(('~b~%s~s~'):format(phone.phone_number or 'N/A'))
            RageUI.Separator(('Propriétaire: ~y~%s~s~'):format(phone.playerName or 'Inconnu'))
            RageUI.Separator(('ID Unique: ~g~%s~s~'):format(phone.UniqueID or 'N/A'))

            RageUI.Line()

            RageUI.Button('Modifier le numéro', 'Changer le numéro de téléphone', {RightLabel = phone.phone_number or ''}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nouveau numéro', function(data)
                        if not data or data == '' then return end
                        TriggerServerEvent('sunny:admin:phones:updateNumber', phone.phone_number, data)
                        phone.phone_number = data
                        ESX.ShowNotification('~g~Numéro modifié')
                    end)
                end
            })

            RageUI.Button('Changer le propriétaire', 'Changer via ID Unique', {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nouvel ID Unique', function(data)
                        local uniqueId = tonumber(data)
                        if not uniqueId then return ESX.ShowNotification('~r~ID Unique invalide') end
                        TriggerServerEvent('sunny:admin:phones:changeOwner', phone.phone_number, uniqueId)
                    end)
                end
            })
        end)
        RageUI.IsVisible(staffGestion, function()
            RageUI.Button('Liste des staffs', nil, {}, true, {
                onSelected = function()
                    adminManagement.searchStaff = nil
                    ESX.TriggerServerCallback("Sunny:staff:openList", function(data)
                        adminManagement.gestion_staff.data = data
                        RageUI.Visible(staffGestion_list, true)
                    end)
                end
            })
            RageUI.Button("Liste des reports", nil, {}, true, {
                onSelected = function()
                    adminManagement.searchStaff = nil
                    ESX.TriggerServerCallback("Sunny:staff:openReportList", function(data, best)
                        adminManagement.gestion_staff.data = data
                        adminManagement.gestion_staff.best = best
                        RageUI.Visible(staffGestion_reportList, true)
                    end)
                end
            })

            RageUI.Line()
            RageUI.Separator('~y~Gestion des Grades~s~')

            RageUI.Button('Gestion des Grades', 'Créer, modifier, supprimer des grades staff', {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:admin:staff:getGrades', function(data)
                        adminManagement.StaffGrades = data or {}
                    end)
                end
            }, gestionStaffGrades)
        end)
        
        RageUI.IsVisible(staffGestion_list, function()
            if adminManagement.searchStaff then
                RageUI.Button("Annuler la recherche", nil, {}, true, {
                    onSelected = function()
                        adminManagement.searchStaff = nil
                    end
                })
            else
                RageUI.Button("Rechercher", nil, {}, true, {
                    onSelected = function()
                        local input = ESX.GetTextInput("Entrez les données")
                        if input == nil then
                            return ESX.ShowNotification("~r~Erreurs lors de la saisie des données")
                        end
        
                        adminManagement.searchStaff = input
                    end
                })
            end
        
            for _, v in pairs(adminManagement.gestion_staff.data) do
                local name = v.playerName or "Inconnu"
                local group = v.group or "Inconnu"
        
                if adminManagement.searchStaff == nil then
                    RageUI.Button(name, nil, { RightLabel = group }, true, {
                        onSelected = function()
                        end
                    })
                else
                    if string.match(string.lower(name), string.lower(adminManagement.searchStaff)) then
                        RageUI.Button(name, nil, { RightLabel = group }, true, {
                            onSelected = function()
                            end
                        })
                    end
                end
            end
        end)
        
        RageUI.IsVisible(staffGestion_reportList, function()
            if adminManagement.gestion_staff.best then
                local best = adminManagement.gestion_staff.best
                if best.name then
                    RageUI.Separator("Le meilleur staff de la semaine:")
                    RageUI.Button(("%s - Reports pris: %d"):format(best.name, best.reports.weekly.close), nil, {}, true, {
                        onSelected = function()
                        end
                    })
                else
                    RageUI.Separator("Aucun meilleur staff de la semaine trouvé.")
                end
            end
        
            for _, v in pairs(adminManagement.gestion_staff.data) do
                local playerName = v.playerName or "Inconnu"
                local reportsTaken = v.reports_taken or 0
        
                RageUI.Button(playerName, nil, { RightLabel = "Reports pris: " .. reportsTaken }, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName,
                            'Êtes-vous sûr de vouloir vider l\'inventaire de ce joueur ?',
                            '',
                            function(response)
                                if response then -- Oui
                                    TriggerServerEvent("Sunny:staff:resetReports", playerName) 
                                else -- Non
                                    ESX.ShowNotification("Vous avez annulé l'action")
                                end
                            end
                        )
                    end
                })
            end
        end)

        -- ═══════════════════════════════════════════════════════════════════════════
        -- GESTION STAFF - GRADES ET PERMISSIONS
        -- ═══════════════════════════════════════════════════════════════════════════

        RageUI.IsVisible(gestionStaffGrades, function()
            RageUI.Separator(('~b~%s~s~ grades configurés'):format(#adminManagement.StaffGrades))

            RageUI.Line()

            RageUI.Button('Créer un nouveau grade', nil, {Color = {BackgroundColor = {0, 150, 0, 150}}}, true, {
                onSelected = function()
                    adminManagement.NewStaffGrade = {
                        name = nil,
                        label = nil,
                        color = '#ffffff',
                        priority = 1,
                    }
                end
            }, gestionStaffCreateGrade)

            RageUI.Button('Rafraîchir', nil, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:admin:staff:getGrades', function(data)
                        adminManagement.StaffGrades = data or {}
                        ESX.ShowNotification('~g~Grades rafraîchis')
                    end)
                end
            })

            RageUI.Line()

            for k, v in pairs(adminManagement.StaffGrades) do
                local gradeLabel = ('%s (%s)'):format(v.label or v.name, v.name)
                local colorPreview = v.color or '#ffffff'

                RageUI.Button(gradeLabel, ('Couleur: %s | Priorité: %s'):format(colorPreview, v.priority or 0), {RightLabel = '→'}, true, {
                    onSelected = function()
                        adminManagement.SelectedStaffGrade = v
                        ESX.TriggerServerCallback('sunny:admin:staff:getPermissions', function(perms)
                            adminManagement.StaffPermissions = perms or {}
                        end, v.name)
                    end
                }, gestionStaffGradeSelected)
            end
        end)

        RageUI.IsVisible(gestionStaffGradeSelected, function()
            if not adminManagement.SelectedStaffGrade then return end
            local grade = adminManagement.SelectedStaffGrade

            RageUI.Separator(('~y~%s~s~'):format(grade.label or grade.name))

            RageUI.Button('Modifier le label', nil, {RightLabel = grade.label or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nouveau label', function(data)
                        if not data or data == '' then return end
                        TriggerServerEvent('sunny:admin:staff:updateGrade', grade.name, 'label', data)
                        grade.label = data
                        ESX.ShowNotification('~g~Label modifié')
                    end)
                end
            })

            RageUI.Button('Modifier la couleur HEX', 'Format: #fd6c9e', {RightLabel = grade.color or '#ffffff'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Couleur HEX (ex: #fd6c9e)', function(data)
                        if not data or data == '' then return end
                        if not string.match(data, '^#%x%x%x%x%x%x$') then
                            return ESX.ShowNotification('~r~Format invalide (ex: #fd6c9e)')
                        end
                        TriggerServerEvent('sunny:admin:staff:updateGrade', grade.name, 'color', data)
                        grade.color = data
                        ESX.ShowNotification('~g~Couleur modifiée')
                    end)
                end
            })

            RageUI.Button('Modifier la priorité', nil, {RightLabel = tostring(grade.priority or 0)}, true, {
                onSelected = function()
                    KeyboardUtils.use('Priorité (0-100)', function(data)
                        local priority = tonumber(data)
                        if not priority then return ESX.ShowNotification('~r~Priorité invalide') end
                        TriggerServerEvent('sunny:admin:staff:updateGrade', grade.name, 'priority', priority)
                        grade.priority = priority
                        ESX.ShowNotification('~g~Priorité modifiée')
                    end)
                end
            })

            RageUI.Line()

            RageUI.Button('Gérer les permissions', ('~b~%s~s~ permissions'):format(#adminManagement.StaffPermissions), {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('sunny:admin:staff:getPermissions', function(perms)
                        adminManagement.StaffPermissions = perms or {}
                    end, grade.name)
                end
            }, gestionStaffGradePermissions)

            RageUI.Line()

            if grade.name ~= 'fondateur' and grade.name ~= 'user' then
                RageUI.Button('~r~Supprimer ce grade', nil, {}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName,
                            'Êtes-vous sûr de vouloir supprimer ce grade ?',
                            '',
                            function(response)
                                if response then
                                    TriggerServerEvent('sunny:admin:staff:deleteGrade', grade.name)
                                    ESX.ShowNotification('~g~Grade supprimé')
                                    RageUI.GoBack()
                                    ESX.TriggerServerCallback('sunny:admin:staff:getGrades', function(data)
                                        adminManagement.StaffGrades = data or {}
                                    end)
                                end
                            end
                        )
                    end
                })
            else
                RageUI.Button('~r~Grade protégé (non supprimable)', nil, {}, false, {})
            end
        end)

        RageUI.IsVisible(gestionStaffGradePermissions, function()
            if not adminManagement.SelectedStaffGrade then return end
            local grade = adminManagement.SelectedStaffGrade

            RageUI.Separator(('Permissions pour ~y~%s~s~'):format(grade.label or grade.name))

            RageUI.Line()

            -- Permissions courantes
            local permissions = {
                {name = 'noclip', label = 'Noclip'},
                {name = 'gamertags', label = 'Gamertags'},
                {name = 'blips', label = 'Blips Staff'},
                {name = 'spectate', label = 'Spectate'},
                {name = 'revive', label = 'Revive'},
                {name = 'heal', label = 'Heal'},
                {name = 'goto', label = 'Goto'},
                {name = 'bring', label = 'Bring'},
                {name = 'kick', label = 'Kick'},
                {name = 'ban', label = 'Ban'},
                {name = 'warn', label = 'Warn'},
                {name = 'jail', label = 'Jail'},
                {name = 'announce', label = 'Annonces'},
                {name = 'vehiclespawn', label = 'Spawn Véhicule'},
                {name = 'vehicledelete', label = 'Supprimer Véhicule'},
            }

            for _, perm in ipairs(permissions) do
                local hasPermission = false
                for _, p in pairs(adminManagement.StaffPermissions) do
                    if p.permission == perm.name then
                        hasPermission = p.enabled
                        break
                    end
                end

                RageUI.Checkbox(perm.label, nil, hasPermission, {}, {
                    onChecked = function()
                        TriggerServerEvent('sunny:admin:staff:setPermission', grade.name, perm.name, true)
                        ESX.ShowNotification(('~g~%s activé'):format(perm.label))
                    end,
                    onUnChecked = function()
                        TriggerServerEvent('sunny:admin:staff:setPermission', grade.name, perm.name, false)
                        ESX.ShowNotification(('~r~%s désactivé'):format(perm.label))
                    end
                })
            end
        end)

        RageUI.IsVisible(gestionStaffCreateGrade, function()
            RageUI.Separator('~g~Créer un Grade~s~')

            RageUI.Button('Nom (identifiant)', nil, {RightLabel = adminManagement.NewStaffGrade.name or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom (sans espaces)', function(data)
                        if data and data ~= '' then
                            adminManagement.NewStaffGrade.name = string.lower(string.gsub(data, ' ', '_'))
                        end
                    end)
                end
            })

            RageUI.Button('Label (affiché)', nil, {RightLabel = adminManagement.NewStaffGrade.label or '~r~Non défini~s~'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Label', function(data)
                        if data and data ~= '' then
                            adminManagement.NewStaffGrade.label = data
                        end
                    end)
                end
            })

            RageUI.Button('Couleur HEX', nil, {RightLabel = adminManagement.NewStaffGrade.color or '#ffffff'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Couleur HEX (ex: #fd6c9e)', function(data)
                        if data and string.match(data, '^#%x%x%x%x%x%x$') then
                            adminManagement.NewStaffGrade.color = data
                        else
                            ESX.ShowNotification('~r~Format invalide')
                        end
                    end)
                end
            })

            RageUI.Button('Priorité', nil, {RightLabel = tostring(adminManagement.NewStaffGrade.priority)}, true, {
                onSelected = function()
                    KeyboardUtils.use('Priorité (1-100)', function(data)
                        local priority = tonumber(data)
                        if priority then adminManagement.NewStaffGrade.priority = priority end
                    end)
                end
            })

            RageUI.Line()

            local canCreate = adminManagement.NewStaffGrade.name and adminManagement.NewStaffGrade.label
            if canCreate then
                RageUI.Button('~g~Créer le grade', nil, {Color = {BackgroundColor = {0, 200, 0, 150}}}, true, {
                    onSelected = function()
                        TriggerServerEvent('sunny:admin:staff:createGrade', adminManagement.NewStaffGrade)
                        ESX.ShowNotification('~g~Grade créé avec succès')
                        RageUI.GoBack()
                        Wait(500)
                        ESX.TriggerServerCallback('sunny:admin:staff:getGrades', function(data)
                            adminManagement.StaffGrades = data or {}
                        end)
                    end
                })
            else
                RageUI.Button('~r~Créer (champs requis)', nil, {}, false, {})
            end
        end)


        --[[RageUI.IsVisible(openObjectsListMenu, function()
            if adminManagement.objectFilter == nil then
                RageUI.Button('Rechercher', "Uniquement le nom/id/id du propriétaire est reconnu dans la recherche.", {},
                    true, {
                        onSelected = function()
                            local input = ESX.GetTextInput("Entrez les données")
                            if input == nil then
                                return ESX.ShowNotification("~r~Les données sont incorrectes")
                            end

                            adminManagement.objectFilter = input
                        end
                    })
            else
                RageUI.Button('Annuler la recherche ', false, {}, true, {
                    onSelected = function()
                        adminManagement.objectFilter = nil
                    end
                })
            end

            RageUI.Checkbox("Par id unique", nil, adminManagement.objectFilterUniqueId, {}, {
                onChecked = function()
                    adminManagement.objectFilterUniqueId = true
                end,
                onUnChecked = function()
                    adminManagement.objectFilterUniqueId = false
                end
            })

            RageUI.List("Trier par catégorie :", objectCategories, objectIndex, nil, {}, true, {
                onListChange = function(Index)
                    objectIndex = Index
                end
            })

            if WorldProps ~= nil then
                for k, v in pairs(adminManagement.objectsList) do
                    local propData = v.job == nil and WorldProps[tostring(v.id)] or nil
                    if propData ~= nil then 
                        local model = propData.model 

                        if type(model) == "number" then
                            math.floor(model)
                        end

                        local numericModel = tonumber(model)
                        if numericModel ~= nil then
                            model = math.floor(numericModel)
                        end

                        if type(model) == "string" then
                            local hashKey = GetHashKey(model)
                            if hashKey ~= 0 then
                                model = hashKey
                            end
                        end

                        local propFormat = objectsFormatted[model] or propData
                        v.name = ('%s'):format(propFormat and propFormat.name or "Objet")

                        local filterMatch = not adminManagement.objectFilter or (
                            string.match(string.lower(v.name), string.lower(adminManagement.objectFilter)) or
                            string.match(string.lower(v.owner), string.lower(adminManagement.objectFilter)) or
                            string.match(string.lower(v.id), string.lower(adminManagement.objectFilter))
                        )

                        if adminManagement.objectFilterUniqueId then
                            filterMatch = not adminManagement.objectFilter or
                                string.lower(v.owner) == string.lower(adminManagement.objectFilter)
                        end

                        if filterMatch and ((objectIndex == 1 and v.job == nil) or (objectIndex == 2 and v.job ~= nil)) then
                            RageUI.Button(v.name, false, {}, true, {
                                onActive = function()
                                    local jobName = v.job or "Aucun"

                                    RageUI.Info("",
                                        {
                                            'Propriétaire :',
                                            'Modele :',
                                            'Date : ',
                                            'Metier : '
                                        },
                                        {
                                            v.owner,
                                            propData.model,
                                            v.date,
                                            jobName
                                        })
                                end,
                                onSelected = function()
                                    openSelectedObject.Parent = openObjectsListMenu
                                    adminManagement.objectSelected = {
                                        tableIndex = k,
                                        data = ESX.Table.Merge(propData, v)
                                    }
                                end
                            }, openSelectedObject)
                        end
                    end
                end
            end
        end)]]--

        RageUI.IsVisible(WeaponListIDUnique, function()
            RageUI.Button('Rechercher', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Recherche', function(data)
                        adminManagement.WeaponSearch = data
                    end)
                end
            })
            if adminManagement.WeaponSearch then
                RageUI.Button('❌ Arrêter la Recherche', nil, {}, true, {
                    onSelected = function()
                        adminManagement.WeaponSearch = nil
                    end
                })
            end
            if json.encode(WeaponList) ~= '[]' then
                for k, v in pairs(WeaponList) do
                    local buttonName = ('%s'):format(v.label)
                    
                    if not adminManagement.WeaponSearch or (string.match(string.lower(buttonName), string.lower(adminManagement.WeaponSearch))) then
                        RageUI.Button(buttonName, nil, {}, true, {
                            onSelected = function()
                                exports['prompt']:createPrompt(
                                    SunnyConfigServ.ServerName,
                                    'Confirmez-vous l\'attribution de cette arme ?',
                                    '',
                                    function(response)
                                        if response then -- Oui
                                            TriggerServerEvent('sunny:admin:uniqueid:giveweapon', v.name, adminManagement.UniqueIDSearch[1].UniqueID, v.label, json.decode(adminManagement.UniqueIDSearch[1].loadout))
                                        else -- Non
                                            ESX.ShowNotification('Action annulée')
                                        end
                                    end
                                )
                            end
                        })
                    end
                end
            end
        end)
        
        RageUI.IsVisible(WarnListPlayer, function()
            RageUI.Button('Rechercher', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Recherche', function(data)
                        adminManagement.WarnListSearch = data
                    end)
                end
            })
            if adminManagement.WarnListSearch then
                RageUI.Button('❌ Arrêter la Recherche', nil, {}, true, {
                    onSelected = function()
                        adminManagement.WarnListSearch = nil
                    end
                })
            end
            if json.encode(adminManagement.WarnList) ~= '[]' then
                for k,v in pairs(adminManagement.WarnList) do
                    local buttonName = ('%s (%s)'):format(v.reason, v.author)
                    if not adminManagement.WarnListSearch then
                        RageUI.Button(buttonName, nil, {}, true, {
                            onSelected = function()
                                
                            end
                        })
                    else
                        if (string.match(string.lower(buttonName), string.lower(adminManagement.WarnListSearch))) then
                            RageUI.Button(buttonName, nil, {}, true, {
                                onSelected = function()
                                    
                                end
                            })
                        end
                    end
                end
            end
        end)

        RageUI.IsVisible(WarnListPlayerUniqueID, function()
            RageUI.Button('Rechercher', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Recherche', function(data)
                        adminManagement.WarnListSearch = data
                    end)
                end
            })
            if adminManagement.WarnListSearch then
                RageUI.Button('❌ Arrêter la Recherche', nil, {}, true, {
                    onSelected = function()
                        adminManagement.WarnListSearch = nil
                    end
                })
            end
            if json.encode(adminManagement.WarnList) ~= '[]' then
                for k,v in pairs(adminManagement.WarnList) do
                    local buttonName = ('%s (%s)'):format(v.reason, v.author)
                    if not adminManagement.WarnListSearch then
                        RageUI.Button(buttonName, nil, {}, true, {
                            onSelected = function()
                                
                            end
                        })
                    else
                        if (string.match(string.lower(buttonName), string.lower(adminManagement.WarnListSearch))) then
                            RageUI.Button(buttonName, nil, {}, true, {
                                onSelected = function()
                                    
                                end
                            })
                        end
                    end
                end
            end
        end)

                    function GeneratePlate()
                local plate = ""
                for i = 1, 8 do
                    local randomType = math.random(1, 2)
                    if randomType == 1 then
                        plate = plate .. string.char(math.random(65, 90))
                    else
                        plate = plate .. tostring(math.random(0, 9))
                    end
                end
                return plate
            end

        RageUI.IsVisible(UniqueIDPlayerDataGIVE_VEHICLE, function()
            RageUI.Button(('Modèle = %s'):format(adminManagement.vehicleModel or 'Choisissez un model'), nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Modèle', function(data)
                        adminManagement.vehicleModel = data
                    end)
                end
            })
            RageUI.Button(('Label = %s'):format(adminManagement.vehicleLabel or 'Choisissez un label'), nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Label', function(data)
                        adminManagement.vehicleLabel = data
                    end)
                end
            })
            RageUI.Button(('Type = %s'):format(adminManagement.vehicleType or 'Choisissez un type'), 'car, boat, aircraft', {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Type', function(data)
                        if data ~= 'car' and data ~= 'boat' and data ~= 'aircraft' then return ESX.ShowNotification('❌ Le type n\'est pas valide') end

                        adminManagement.vehicleType = data
                    end)
                end
            })
            RageUI.Checkbox('Boutique', nil, adminManagement.vehicleBoutique, {}, {
                onChecked = function()
                    adminManagement.vehicleBoutique = true
                end,
                onUnChecked = function()
                    adminManagement.vehicleBoutique = false
                end
            })
            RageUI.Button('Garage', 'Ce bouton va vous faire changer de menu', {}, true, {
                onSelected = function()
                    for k,v in pairs(Garages.garage_data.garages) do
                        adminManagement.garageSelected[k] = {active = false, garageid = 1}
                    end

                    RageUI.Visible(UniqueIDPlayerDataGIVE_VEHICLE_GARAGE, true)
                end
            })
            RageUI.Button('Confirmer', nil, {}, true, {
                onSelected = function()
                    ESX.Game.SpawnVehicle(adminManagement.vehicleModel, vector3(748.97686767578, -4407.44140625, -0.65416955947876), GetEntityHeading(PlayerPedId()), function (veh) 
                        local plate = GeneratePlate()
                        local vehicle = lib.getVehicleProperties(veh)
                        vehicle.plate = plate
                        SetVehicleNumberPlateText(veh, plate)

                        TriggerServerEvent('sunny:admin:give_vehicle', adminManagement.UniqueIDSearch[1].UniqueID, {
                            owner = adminManagement.UniqueIDSearch[1].UniqueID,
                            label = adminManagement.vehicleModel,
                            garageid = adminManagement.vehicleGarageid,
                            vehicle = json.encode(vehicle),
                            plate = vehicle.plate,
                            type = adminManagement.vehicleType,
                            boutique = adminManagement.vehicleBoutique
                        })
                        RageUI.CloseAll()
                        DeleteEntity(veh)
                    end)
                end
            })
        end)

        RageUI.IsVisible(UniqueIDPlayerDataGIVE_VEHICLE_GARAGE, function()
            for k,v in pairs(Garages.garage_data.garages) do
                if adminManagement.vehicleType == nil then goto continue end
                if adminManagement.vehicleType ~= v.type then goto continue end

                local isSelected = adminManagement.vehicleGarageid == v.id
                
                RageUI.Button(v.label, nil, {RightLabel = isSelected and '✓' or ''}, true, {
                    onSelected = function()
                            adminManagement.vehicleGarageid = v.id
                        end
                    })

                ::continue::
            end
        end)

        RageUI.IsVisible(changePlayerGroupWithUniqueID, function()
            Config.Staff.Permissions['ServerGroup'][ESX.GetPlayerData().group] = sortGroupTable(Config.Staff.Permissions['ServerGroup'][ESX.GetPlayerData().group])
            for k,v in pairs(Config.Staff.Permissions['ServerGroup'][ESX.GetPlayerData().group]) do
                RageUI.Button(v.label, nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent('sunny:admin:setGroupWithUniqueID', adminManagement.UniqueIDSearch[1].UniqueID, v.value)
                        ESX.ShowNotification('✅ Joueur setgroup avec succès')
                    end
                })
            end
        end)

        RageUI.IsVisible(openCreateSociety, function()
            Society:openCreateMenu()
        end)

        RageUI.IsVisible(openEditSociety, function()
            for k,v in pairs(Society.List) do
                RageUI.Button(('%s | %s'):format(v.name, v.label), nil, {RightBadge = RageUI.BadgeStyle.Star}, true, {
                    onSelected = function()
                        adminManagement.SelectedSociety = v
                    end
                }, openEditSelectedSociety)
            end
        end)


        RageUI.IsVisible(openEditSelectedSociety, function()
            if adminManagement.SocietyMode == 'delete' then
                RageUI.Separator(('~r~Supprimer %s ?'):format(adminManagement.SelectedSociety and adminManagement.SelectedSociety.label or ''))
                RageUI.Line()
                RageUI.Button('~g~Oui, supprimer', nil, {}, true, {
                    onSelected = function()
                        if adminManagement.SelectedSociety then
                            TriggerServerEvent('sunny:admin:deleteSociety', adminManagement.SelectedSociety.name)
                            ESX.ShowNotification(('~r~Société %s supprimée'):format(adminManagement.SelectedSociety.label))
                        end
                        RageUI.GoBack()
                        RageUI.GoBack()
                    end
                })
                RageUI.Button('~r~Non, annuler', nil, {}, true, {
                    onSelected = function()
                        RageUI.GoBack()
                    end
                })
                return
            end

            local playerCoords = GetEntityCoords(PlayerPedId())
            RageUI.Separator(('Nom de la société [~y~%s~s~]'):format(adminManagement.SelectedSociety.name))
            RageUI.Separator(('Label de la société [~y~%s~s~]'):format(adminManagement.SelectedSociety.label))
            RageUI.List('Se téléporter à', adminManagement.SelectedSocietyZoneTeleport, adminManagement.SelectedSocietyZoneTeleportIndex, nil, {}, true, {
                onListChange = function(Index)
                    adminManagement.SelectedSocietyZoneTeleportIndex = Index
                end,
                onSelected = function()
                    local ped = PlayerPedId()
                    if adminManagement.SelectedSocietyZoneTeleportIndex == 1 then
                        if not adminManagement.SelectedSociety.blips.active then ESX.ShowNotification('Le blips n\'est pas activé sur cette entreprise') return end
                        SetEntityCoords(ped, vector3(adminManagement.SelectedSociety.blips.position.x, adminManagement.SelectedSociety.blips.position.y, adminManagement.SelectedSociety.blips.position.z))
                    elseif adminManagement.SelectedSocietyZoneTeleportIndex == 2 then
                        SetEntityCoords(ped, vector3(adminManagement.SelectedSociety.posCoffre.x, adminManagement.SelectedSociety.posCoffre.y, adminManagement.SelectedSociety.posCoffre.z))
                    elseif adminManagement.SelectedSocietyZoneTeleportIndex == 3 then
                        SetEntityCoords(ped, vector3(adminManagement.SelectedSociety.posBoss.x, adminManagement.SelectedSociety.posBoss.y, adminManagement.SelectedSociety.posBoss.z))

                    end

                    ESX.ShowNotification('Téléportation éfféctuée avec succès')
                end
            })
            RageUI.Line()
            RageUI.Button('Informations de la société', nil, {RightBadge = RageUI.BadgeStyle.Star}, true, {
                onSelected = function()
                end
            }, openInformationsSociety)
            RageUI.Button('Gérer les grades', nil, {RightLabel = ('~y~%s~s~'):format(#adminManagement.SelectedSociety.grades)}, true, {
                onSelected = function()
                    print(adminManagement.SelectedSociety.name)
                end
            }, openEditSocietyGrade)
            RageUI.Button('Gérer les employés', nil, {RightLabel = ('~y~%s~s~'):format(#adminManagement.SelectedSociety.employeds)}, true, {
                onSelected = function()
                end
            })


            RageUI.Separator('Modification de la société')

            RageUI.Button('Changer la position du Blips', nil, {}, true, {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)

                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Êtes-vous sûr de vouloir changer la position du blip ?', 
                        '',
                        function(response)
                            if response then -- Oui
                                adminManagement.SelectedSociety.blips.position = {
                                    x = playerCoords.x,
                                    y = playerCoords.y,
                                    z = playerCoords.z
                                }

                                if not adminManagement.SelectedSociety.blips.sprite then
                                    adminManagement.SelectedSociety.blips.sprite = 523
                                end
                                if not adminManagement.SelectedSociety.blips.color then
                                    adminManagement.SelectedSociety.blips.color = 0
                                end 
                                if adminManagement.SelectedSociety.blips.active == nil then
                                    adminManagement.SelectedSociety.blips.active = true
                                end

                                TriggerServerEvent('sunny:admin:editSociety', adminManagement.SelectedSociety.name, adminManagement.SelectedSociety)
                                ESX.ShowNotification('Position du blip modifiée')
                            else -- Non
                                ESX.ShowNotification("Vous avez annulé l'action")
                            end
                        end
                    )
                end
            })

            RageUI.Button('Changer le label', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nouveau label', function(data)
                        if data == nil or data == '' then return end
                        
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName,
                            'Êtes-vous sûr de vouloir changer le label de la société ?',
                            '',
                            function(response)
                                if response then -- Oui
                                    adminManagement.SelectedSociety.label = data
                                    TriggerServerEvent('sunny:admin:editSociety', adminManagement.SelectedSociety.name, adminManagement.SelectedSociety)
                                    ESX.ShowNotification('Label modifié avec succès')
                                else -- Non 
                                    ESX.ShowNotification("Vous avez annulé l'action")
                                end
                            end
                        )
                    end)
                end
            })
            RageUI.Button('Changer la position du coffre', nil, {}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Êtes-vous sûr de vouloir changer la position du coffre ?',
                        '',
                        function(response)
                            if response then -- Oui
                                adminManagement.SelectedSociety.posCoffre = playerCoords
                                TriggerServerEvent('sunny:admin:editSociety', adminManagement.SelectedSociety.name, adminManagement.SelectedSociety)
                                ESX.ShowNotification('Position du coffre modifiée')
                            else -- Non
                                ESX.ShowNotification("Vous avez annulé l'action")
                            end
                        end
                    )
                end
            })
            RageUI.Button('Changer la position du boss', nil, {}, true, {
                onSelected = function()
                    exports['prompt']:createPrompt(
                        SunnyConfigServ.ServerName,
                        'Êtes-vous sûr de vouloir changer la position du boss ?',
                        '',
                        function(response)
                            if response then -- Oui
                                adminManagement.SelectedSociety.posBoss = playerCoords
                                TriggerServerEvent('sunny:admin:editSociety', adminManagement.SelectedSociety.name, adminManagement.SelectedSociety)
                                ESX.ShowNotification('Position du boss modifiée')
                            else -- Non
                                ESX.ShowNotification('Vous avez annulé l\'action')
                            end
                        end
                    )
                end
            })

            RageUI.Checkbox('Vestiaire', nil, adminManagement.SelectedSociety.cloakroom, {}, {
                onChecked = function()
                    adminManagement.SelectedSociety.cloakroom = true
                    TriggerServerEvent('sunny:admin:editSociety', adminManagement.SelectedSociety.name, adminManagement.SelectedSociety)
                end,
                onUnChecked = function()
                    adminManagement.SelectedSociety.cloakroom = false
                    TriggerServerEvent('sunny:admin:editSociety', adminManagement.SelectedSociety.name, adminManagement.SelectedSociety)
                end
            })
            if adminManagement.SelectedSociety.cloakroom == true then
                RageUI.Button('Position du vestaire', nil, {}, true, {
                    onSelected = function()
                        adminManagement.SelectedSociety.cloakpos = GetEntityCoords(Player.playerPed)

                        TriggerServerEvent('sunny:admin:editSociety', adminManagement.SelectedSociety.name, adminManagement.SelectedSociety)
                    end
                })
            end
        end)

        RageUI.IsVisible(openInformationsSociety, function()
                RageUI.Button('Nom:', nil, {RightLabel = "~g~"..adminManagement.SelectedSociety.name}, true, {
                    onSelected = function()
                    end
                })
                RageUI.Button('Label:', nil, {RightLabel = "~g~"..adminManagement.SelectedSociety.label}, true, {
                    onSelected = function()
                    end
                })
                RageUI.Button('Argent de la société:', nil, {RightLabel = "~g~"..(
                    function()
                        if adminManagement.SelectedSociety.coffre and 
                           adminManagement.SelectedSociety.coffre['accounts'] and 
                           type(adminManagement.SelectedSociety.coffre['accounts']) == 'table' then
                            
                            if type(adminManagement.SelectedSociety.coffre['accounts'].society) == 'number' then
                                return adminManagement.SelectedSociety.coffre['accounts'].society.."$"
                            end
                        end
                        return "Pas de données"
                    end)()
                }, true, {
                    onSelected = function()
                    end
                })
                RageUI.Button("Nombre d'employés:", nil, {RightLabel = ('~g~%s~s~'):format(#adminManagement.SelectedSociety.employeds)}, true, {
                    onSelected = function()
                    end
                })
                RageUI.Button("Nombre de grades:", nil, {RightLabel = ('~g~%s~s~'):format(#adminManagement.SelectedSociety.grades)}, true, {
                    onSelected = function()
                    end
                })
            end)


        RageUI.IsVisible(openEditSocietyGrade, function()
            local playerCoords = GetEntityCoords(PlayerPedId())
            RageUI.Separator(('Nom de la société [~y~%s~s~]'):format(adminManagement.SelectedSociety.name))
            RageUI.Separator(('Label de la société [~y~%s~s~]'):format(adminManagement.SelectedSociety.label))
            RageUI.Line()
            RageUI.Button('Ajouter un grade', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Nom du grade', function(data)
                        if data == nil or data == '' then return end

                        KeyboardUtils.use('Label du grade', function(data2)
                            if data2 == nil or data2 == '' then return end

                            KeyboardUtils.use('Salaire du grade', function(data3)
                                if data3 == nil or data3 == '' then return end

                                adminManagement.SelectedSociety.grades[#adminManagement.SelectedSociety.grades+1] = {
                                    grade = #adminManagement.SelectedSociety.grades+1,
                                    name = data,
                                    label = data2,
                                    salary = data3
                                }

                                TriggerServerEvent('sunny:admin:editSociety', adminManagement.SelectedSociety.name, adminManagement.SelectedSociety)
                                RageUI.GoBack()
                            end)
                        end)
                    end)
                end
            })
            RageUI.Line()
            for k,v in pairs(adminManagement.SelectedSociety.grades) do
                RageUI.Button(('%s | %s'):format(v.grade, v.label), nil, {RightBadge = RageUI.BadgeStyle.Star}, true, {
                    onSelected = function()
                        adminManagement.SelectedSocietyGrade = v
                        adminManagement.SelectedSocietyGradeId = k


                        
                    end
                }, openEditGradeMenu)
            end
        end)

        RageUI.IsVisible(openEditGradeMenu, function()
                RageUI.Separator(('Name [~y~%s~s~]'):format(adminManagement.SelectedSocietyGrade.name))
                RageUI.Separator(('Label [~y~%s~s~]'):format(adminManagement.SelectedSocietyGrade.label))
                RageUI.Separator(('Salaire [~y~%s~s~]'):format(adminManagement.SelectedSocietyGrade.salary))
              
                RageUI.Line()
                RageUI.Button('Changer le label', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Nouveau label', function(data)
                            if data == nil or data == '' then return end

                            adminManagement.SelectedSociety.grades[adminManagement.SelectedSocietyGradeId].label = data

                            TriggerServerEvent('sunny:admin:editSociety', adminManagement.SelectedSociety.name, adminManagement.SelectedSociety)
                        end)
                    end
                })

                    RageUI.Button('Changer le nom', nil, {}, true, {
                        onSelected = function()
                            KeyboardUtils.use('Nouveau nom', function(data)
                                if data == nil or data == '' then return end

                                adminManagement.SelectedSociety.grades[adminManagement.SelectedSocietyGradeId].grade = data

                                TriggerServerEvent('sunny:admin:editSociety', adminManagement.SelectedSociety.name, adminManagement.SelectedSociety)
                            end)
                        end
                    })
                    RageUI.Button('Changer le salaire', nil, {}, true, {
                        onSelected = function()
                            KeyboardUtils.use('Nouveau salaire', function(data)
                                if data == nil or data == '' then return end

                                adminManagement.SelectedSociety.grades[adminManagement.SelectedSocietyGradeId].salary = data

                                TriggerServerEvent('sunny:admin:editSociety', adminManagement.SelectedSociety.name, adminManagement.SelectedSociety)
                            end)
                        end
                    })

                    RageUI.Button('Supprimer le grade', nil, {backgroundColor = {255, 0, 0, 0}, RightLabel = '>'}, true, {
                        onSelected = function()
                            adminManagement.SelectedSociety.grades[adminManagement.SelectedSocietyGradeId] = nil

                            TriggerServerEvent('sunny:admin:editSociety', adminManagement.SelectedSociety.name, adminManagement.SelectedSociety)
                        end
                    })
        end)

         --FARMBUILDER--
         
         RageUI.IsVisible(openCreateFarm, function()
            RageUI.Button('Name du job ', nil, {}, true, {
                onSelected = function() 
                    KeyboardUtils.use('Nom du job ( sans espace )', function(string)
                        if string ~= "" then
                            namejob = string
                        end
                    end)
                end
            });
            if namejob ~= nil then
                RageUI.Separator(namejob)
            end
            RageUI.Button('Label du job ', nil, {}, true, {
                onSelected = function() 
                    KeyboardUtils.use('Label du job ( Nom affiché au joueurs )', function(string)
                        if string ~= "" then
                            labeljob = string
                        end
                    end)
                end
            });
            if labeljob ~= nil then
                RageUI.Separator(labeljob)
            end
            RageUI.Button('name de l\'item récolte', nil, {}, true, {
                onSelected = function() 
                    KeyboardUtils.use('Nom de l\'item récolte ( sans espace )', function(string)
                        if string ~= "" then
                            namerecolteitem = string
                        end
                    end)
                end
            });
            if namerecolteitem ~= nil then
                RageUI.Separator(namerecolteitem)
            end
            RageUI.Button('Label de l\'item récolte', nil, {}, true, {
                onSelected = function() 
                    KeyboardUtils.use('Label de l\'item récolte', function(string)
                        if string ~= "" then
                            labelrecolteitem = string
                        end
                    end)
                end
            });
            if labelrecolteitem ~= nil then
                RageUI.Separator(labelrecolteitem)
            end
            RageUI.Button('Position de la récolte', nil, {}, true, {
                onSelected = function() 
                    PositionRecolte = GetEntityCoords(PlayerPedId(), true)
                end
            });
            if PositionRecolte ~= nil then
                RageUI.Separator(PositionRecolte)
            end
            RageUI.Button('name de l\'item traitement ', nil, {}, true, {
                onSelected = function() 
                    KeyboardUtils.use('Nom de l\'item traitement ( sans espace )', function(string)
                        if string ~= "" then
                            nametraitementitem = string
                        end
                    end)
                end
            });
            if nametraitementitem ~= nil then
                RageUI.Separator(nametraitementitem)
            end
            RageUI.Button('Label de l\'item traitement', nil, {}, true, {
                onSelected = function() 
                    KeyboardUtils.use('Label de l\'item traitement', function(string)
                        if string ~= "" then
                            labeltraitementitem = string
                        end
                    end)
                end
            });
            if labeltraitementitem ~= nil then
                RageUI.Separator(labeltraitementitem)
            end
            RageUI.Button('Position du Traitement', nil, {}, true, {
                onSelected = function() 
                    PositionTraitement = GetEntityCoords(PlayerPedId(), true)
                end
            });
            if PositionTraitement ~= nil then
                RageUI.Separator(PositionTraitement)
            end
            RageUI.Button('Position de la vente', nil, {}, true, {
                onSelected = function() 
                    PositionVente = GetEntityCoords(PlayerPedId(), true)
                end
            });
            if PositionVente ~= nil then
                RageUI.Separator(PositionVente)
            end
            RageUI.Button('Position du coffre entreprise', nil, {}, true, {
                onSelected = function() 
                    PositionCoffreEntreprise = GetEntityCoords(PlayerPedId(), true)
                end
            });
            if PositionCoffreEntreprise ~= nil then
                RageUI.Separator(PositionCoffreEntreprise)
            end
            RageUI.Button(SunnyConfigServ.GTACOLOR..'Confirmer', nil, {}, true, {
                onSelected = function() 
                    -- Vérification que tous les champs sont remplis
                    if not namejob or not labeljob or not namerecolteitem or not labelrecolteitem or not PositionRecolte or not nametraitementitem or not labeltraitementitem or not PositionTraitement or not PositionVente or not PositionCoffreEntreprise then
                        ESX.ShowNotification('~r~Erreur : Tous les champs doivent être remplis !')
                        return
                    end
                    
                    TriggerServerEvent('Zigi:CreateFarmEntreprise', namejob, labeljob, namerecolteitem, labelrecolteitem, PositionRecolte, nametraitementitem, labeltraitementitem, PositionTraitement, PositionVente, PositionCoffreEntreprise)
                    
                    -- Réinitialiser les variables
                    namejob = nil
                    labeljob = nil
                    namerecolteitem = nil
                    labelrecolteitem = nil
                    PositionRecolte = nil
                    nametraitementitem = nil
                    labeltraitementitem = nil
                    PositionTraitement = nil
                    PositionVente = nil
                    PositionCoffreEntreprise = nil
                    
                    RageUI.CloseAll()
                end
            });
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(mba) and not RageUI.Visible(tpoints) and not RageUI.Visible(staffGestion_reportList) and not RageUI.Visible(openEditSocietyGrade) and not RageUI.Visible(openEditGradeMenu) and not RageUI.Visible(actionsPersonnel) and not RageUI.Visible(playersList) and not RageUI.Visible(reportsList) and not RageUI.Visible(selectedPlayer) and not RageUI.Visible(accountsPlayer) and not RageUI.Visible(jobPlayer) and not RageUI.Visible(addJobPlayer) and not RageUI.Visible(addJobPlayerList) and not RageUI.Visible(addJobGradeWithJobList) and not RageUI.Visible(changePlayerGroup) and not RageUI.Visible(infoPlayer) and not RageUI.Visible(vehiclesOptions) and not RageUI.Visible(selectedReport) and not RageUI.Visible(accountsReportPlayer) and not RageUI.Visible(jobReportPlayer) and not RageUI.Visible(addJobReportPlayer) and not RageUI.Visible(addJobReportPlayerList) and not RageUI.Visible(addReportJobGradeWithJobList) and not RageUI.Visible(changeReportPlayerGroup) and not RageUI.Visible(infoReportPlayer) and not RageUI.Visible(staffGestion_list) and not RageUI.Visible(staffGestion) and not RageUI.Visible(SearchUniqueID) and not RageUI.Visible(UniqueIDresult) and not RageUI.Visible(UniqueIDPlayerInventory) and not RageUI.Visible(menuServerOptionsPhone) and not RageUI.Visible(serverOptions) and not RageUI.Visible(eventOptions) and not RageUI.Visible(openJobList) and not RageUI.Visible(fireWorksEvent) and not RageUI.Visible(openServInfo) and not RageUI.Visible(UniqueIDPlayerBoutiqueHistory) and not RageUI.Visible(WeaponListIDUnique) and not RageUI.Visible(WarnListPlayer) and not RageUI.Visible(UniqueIDPlayerDataGIVE_VEHICLE) and not RageUI.Visible(UniqueIDPlayerDataGIVE_VEHICLE_GARAGE) and not RageUI.Visible(WarnListPlayerUniqueID) and not RageUI.Visible(changePlayerGroupWithUniqueID) and not RageUI.Visible(truckEvent) and not RageUI.Visible(openEventCreator) and not RageUI.Visible(openCreateSociety) and not RageUI.Visible(openEditSociety) and not RageUI.Visible(openEditSelectedSociety) and not RageUI.Visible(openInformationsSociety) and not RageUI.Visible(UniqueIDPlayerDataGIVE_Item) and not RageUI.Visible(weaponsSell) and not RageUI.Visible(UniqueIDPlayerInventoryWeaponSelect) and not RageUI.Visible(weaponsSellGroupList) and not RageUI.Visible(createDrugs) and not RageUI.Visible(createCircuit) and not RageUI.Visible(editCircuit) and not RageUI.Visible(editCircuit2) and not RageUI.Visible(editPosWithCategorie_drugs)  and not RageUI.Visible(editSellDrugs) and not RageUI.Visible(UniqueIDPlayerWeapponAccesory) and not RageUI.Visible(manageVehicleConcess) and not RageUI.Visible(manageVehicleConcessCreateVehicle) and not RageUI.Visible(manageVehicleConcessCreateVehicleCategorie) and not RageUI.Visible(manageVehicleConcessEdit) and not RageUI.Visible(manageVehicleConcessEditCategorie) and not RageUI.Visible(manageVehicleConcessEditAllCategorie) and not RageUI.Visible(manageVehicleConcessEditAllCategorieEdit) and not RageUI.Visible(manageVehicleConcessEditAllCategorieEditAdd) and not RageUI.Visible(manageVehicleConcessEditAllCategorieEditInformations) and not RageUI.Visible(openCreateFarm) and not RageUI.Visible(manageVehicleBoutique) and not RageUI.Visible(weatherManagement) and
        not RageUI.Visible(gestionArmureries) and not RageUI.Visible(gestionArmureriesListe) and not RageUI.Visible(gestionArmureriesSelected) and not RageUI.Visible(gestionArmureriesItems) and not RageUI.Visible(gestionArmureriesItemSelected) and not RageUI.Visible(gestionArmureriesCreate) and not RageUI.Visible(gestionArmureriesAddItem) and
        not RageUI.Visible(gestionSuperettes) and not RageUI.Visible(gestionSuperettesListe) and not RageUI.Visible(gestionSuperettesSelected) and not RageUI.Visible(gestionSuperettesItems) and not RageUI.Visible(gestionSuperettesItemSelected) and not RageUI.Visible(gestionSuperettesCreate) and not RageUI.Visible(gestionSuperettesAddItem) and
        not RageUI.Visible(gestionTelephones) and not RageUI.Visible(gestionTelephonesSelected) and
        not RageUI.Visible(gestionStaffGrades) and not RageUI.Visible(gestionStaffGradeSelected) and not RageUI.Visible(gestionStaffGradePermissions) and not RageUI.Visible(gestionStaffCreateGrade) and
        not RageUI.Visible(supprimerSocieteMenu) and
        not RageUI.Visible(main) then
            main = RMenu:DeleteType('main')
        end
    end
end

AddEventHandler("staff:addTerritoryEventData", function (name)
    if Config.eventsMenu["Attaque Territoire"]["menu"]["zone"]["list"] == nil then
        Config.eventsMenu["Attaque Territoire"]["menu"]["zone"]["list"] = {}
    end

    table.insert(Config.eventsMenu["Attaque Territoire"]["menu"]["zone"]["list"], name)
end)

AddEventHandler("staff:removeTerritoryEventData", function (name)
    for k, v in pairs(Config.eventsMenu["Attaque Territoire"]["menu"]["zone"]["list"]) do
        if v ~= name then goto continue end

        table.remove(Config.eventsMenu["Attaque Territoire"]["menu"]["zone"]["list"], k)

        ::continue::
    end
end)

RegisterNetEvent('sunny:admin:atazone', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    ESX.ShowNotification('Vous avez été ATA par un Staff')
    ataThread(180, 1)
end)

RegisterKeyMapping('tpmarker', 'Se tp au marker', 'keyboard', 'O')
RegisterCommand('tpmarker', function()
    if (Config.Staff.HavePermission('VehiclesOptions', 'returnveh')) and adminManagement.Service then
        local playerPed = PlayerPedId()
        local waypointBlip = GetFirstBlipInfoId(8)

        if DoesBlipExist(waypointBlip) then
            local waypointCoords = GetBlipInfoIdCoord(waypointBlip)
            local foundGround, groundZ = false, 0.0

            for i = 0, 1000, 25 do
                RequestCollisionAtCoord(waypointCoords.x, waypointCoords.y, i + 0.0)
                Wait(0)

                foundGround, groundZ = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, i + 0.0, false)
                
                if foundGround then
                    waypointCoords = vector3(waypointCoords.x, waypointCoords.y, groundZ + 0.0)
                    break
                end
            end

            if foundGround then
                if IsPedInAnyVehicle(playerPed, false) then
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    SetEntityCoords(vehicle, waypointCoords.x, waypointCoords.y, waypointCoords.z)
                else
                    SetEntityCoords(playerPed, waypointCoords.x, waypointCoords.y, waypointCoords.z)
                end
                ESX.ShowNotification('✅ Téléportation effectuée')
            else
                ESX.ShowNotification('❌ Impossible de trouver le sol à cet endroit')
            end
        else
            ESX.ShowNotification('❌ Aucun waypoint')
        end
    end
end)


local lastTpTime = {} 
local cooldown = 4 * 1000  

RegisterKeyMapping('tpaleatoire', '[STAFF] TP Aléatoire J', 'keyboard', 'i')
RegisterCommand('tpaleatoire', function(source, args)
    local player = tonumber(source)
    local currentTime = GetGameTimer()  
    local playerLastTpTime = lastTpTime[player] or 0  

    if currentTime - playerLastTpTime < cooldown then  
        local timeLeft = (cooldown - (currentTime - playerLastTpTime)) / 1000 
        ESX.ShowNotification("🚨 Veuillez attendre " .. SunnyConfigServ.GTACOLOR .. timeLeft .. " secondes ~s~avant de vous téléporter à nouveau.")
        return
    end

    if not Config.Staff.HavePermission('VehiclesOptions', 'returnveh') or not adminManagement.Service then
        return
    end

    if not adminManagement.NoClip then
        ESX.ShowNotification('🚨 Vous ne pouvez pas vous téléporter tant que le mode NoClip est désactivé !')
        return
    end

    local players = GetActivePlayers()
    local randomPlayer = players[math.random(#players)]

    if randomPlayer == PlayerId() then
        ESX.ShowNotification('🚨 Vous ne pouvez pas vous téléporter à vous-même !')
        return
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(randomPlayer)))
    SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
    lastTpTime[player] = currentTime  
end)

AddEventHandler('playerDropped', function()
    local player = tonumber(source)
    lastTpTime[player] = nil  
end)

CreateThread(function()
    while true do
        Wait(500)
        local playerPed = PlayerPedId()
        
        if adminManagement.Invisible and adminManagement.Service then
            if IsEntityVisible(playerPed) then
                SetEntityVisible(playerPed, false, false)
                SetLocalPlayerVisibleLocally(true)
                SetEntityAlpha(playerPed, 0, false)
            end
        else
            if not IsEntityVisible(playerPed) then
                ResetEntityAlpha(playerPed)
                SetEntityVisible(playerPed, true, false)
            end
        end
    end
end)

CreateThread(function()
    local lastState = nil
    while true do
        Wait(1000)
        local playerPed = PlayerPedId()
        local currentState = adminManagement.Invincible and adminManagement.Service
        
        if currentState ~= lastState then
            print(string.format("[DEBUG Thread] Invincible=%s Service=%s -> État=%s", 
                tostring(adminManagement.Invincible), 
                tostring(adminManagement.Service), 
                currentState and "ON" or "OFF"))
            lastState = currentState
        end
        
        if currentState then
            SetEntityInvincible(playerPed, true)
            SetPlayerInvincible(PlayerId(), true)
        else
            SetEntityInvincible(playerPed, false)
            SetPlayerInvincible(PlayerId(), false)
        end
    end
end)

