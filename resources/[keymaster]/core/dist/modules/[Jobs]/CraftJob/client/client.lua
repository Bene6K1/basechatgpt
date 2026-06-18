
local open = false
local isCrafting = false
local menuThreadCreated = false
local isCheckingItems = false
local lastCheckedItem = nil
local lastCheckedTime = 0
local lastMenuToggle = 0
local mainMenu = RageUI.CreateMenu('', 'Craft des items')
mainMenu.Closed = function()
    open = false
    isCrafting = false
    menuThreadCreated = false
end

local craftActionLabels = {
    ['restau_burgershot'] = 'Cuisine BurgerShot',
    ['restau_pops'] = 'Cuisine Pop\'s Diner',
    ['restau_pearls'] = 'Cuisine Pearls',
    ['hornys'] = 'Cuisine Horny\'s',
    ['restau_catcafe'] = 'Cuisine CatCafe'
}

local jobMapping = {
    ['burgershot'] = 'restau_burgershot',
    ['restau_burgershot'] = 'restau_burgershot',
    ['pops'] = 'restau_pops',
    ['restau_pops'] = 'restau_pops',
    ['pearls'] = 'restau_pearls',
    ['restau_pearls'] = 'restau_pearls',
    ['hornys'] = 'hornys',
    ['catcafe'] = 'restau_catcafe',
    ['restau_catcafe'] = 'restau_catcafe'
}

local realJobNames = {
    ['restau_burgershot'] = 'burgershot',
    ['restau_pops'] = 'pops',
    ['restau_pearls'] = 'pearls',
    ['hornys'] = 'hornys',
    ['restau_catcafe'] = 'restau_catcafe'
}

local cachedPlayerData = nil
local lastDataUpdate = 0

function OpenCraftMenu()
    local currentTime = GetGameTimer()

    -- Protection contre les appels multiples rapides
    if (currentTime - lastMenuToggle) < 500 then
        return
    end

    -- Toggle le menu (ouvrir si fermé, fermer si ouvert)
    if open then
        -- Fermer le menu
        open = false
        menuThreadCreated = false
        RageUI.Visible(mainMenu, false)
        cachedPlayerData = nil
        lastMenuToggle = currentTime
        return
    end

    -- Charger les données du joueur
    local pdata = ESX.GetPlayerData()
    local playerJob = pdata.job and pdata.job.name
    local playerJob2 = pdata.job2 and pdata.job2.name
    local configKey = jobMapping[playerJob] or jobMapping[playerJob2]

    -- Vérifier si le joueur a accès à ce menu
    if not configKey or not Config_craftjob.Recipes[configKey] then
        ESX.ShowNotification('~r~Vous n\'avez pas accès à ce menu de craft')
        return
    end

    -- Ouvrir le menu
    lastMenuToggle = currentTime
    open = true
    cachedPlayerData = pdata
    lastDataUpdate = currentTime
    RageUI.Visible(mainMenu, true)

    -- Créer le thread seulement si pas déjà créé
    if not menuThreadCreated then
        Citizen.CreateThread(function()
            menuThreadCreated = true
            while open do
                Wait(0)
                RageUI.IsVisible(mainMenu, function()
                    local pdata = cachedPlayerData or ESX.GetPlayerData()
                    local playerJob = pdata.job and pdata.job.name
                    local playerJob2 = pdata.job2 and pdata.job2.name
                    local configKey = jobMapping[playerJob] or jobMapping[playerJob2]

                    local recipes = configKey and Config_craftjob.Recipes[configKey] or nil
                    if recipes then
                        for craftItem, details in pairs(recipes) do
                            if details and details.ingredients then
                                local ingredientList = ""
                                for _, ingredient in ipairs(details.ingredients) do
                                    ingredientList = ingredientList .. string.format("%d x %s\n", ingredient.count, ingredient.label)
                                end
                                RageUI.Button(details.label, nil, { RightLabel = "→"}, not isCrafting, {
                                    onActive = function()
                                        RageUI.Info(SunnyConfigServ.GTACOLOR..'Information Craft', {'Item : ', '', 'Ingrédients : ', ingredientList, '','','','',''}, {details.label})
                                    end,
                                    onSelected = function()
                                        local currentTime = GetGameTimer()
                                        local itemKey = configKey .. "_" .. craftItem

                                        if isCrafting or isCheckingItems then
                                            return
                                        end

                                        if lastCheckedItem == itemKey and (currentTime - lastCheckedTime) < 1000 then
                                            return
                                        end

                                        isCheckingItems = true
                                        lastCheckedItem = itemKey
                                        lastCheckedTime = currentTime
                                        TriggerServerEvent('craft:verifitem', configKey, craftItem, details.ingredients)
                                        Citizen.SetTimeout(1000, function()
                                            isCheckingItems = false
                                            lastCheckedItem = nil
                                        end)
                                    end
                                })
                            end
                        end
                    else
                        RageUI.Separator('Aucun item disponible')
                    end
                end)
            end
            menuThreadCreated = false
        end)
    end
end

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

RegisterNetEvent('craft:startCrafting')
AddEventHandler('craft:startCrafting', function(job, craftItem, ingredients)
    print("^2[DEBUG CRAFT CLIENT] craft:startCrafting reçu - isCrafting: " .. tostring(isCrafting) .. " - Job: " .. tostring(job) .. " - Item: " .. tostring(craftItem) .. "^0")
    if not isCrafting then
        print("^3[DEBUG CRAFT CLIENT] craft:startCrafting - Mise à jour isCrafting = true^0")
        isCrafting = true
        drawBar(20000, ("Craft de l'item en cours"), function()
            print("^2[DEBUG CRAFT CLIENT] craft:startCrafting - drawBar terminé - Envoi TriggerServerEvent craft:craftItem^0")
            TriggerServerEvent('craft:craftItem', job, craftItem, ingredients)
            print("^3[DEBUG CRAFT CLIENT] craft:startCrafting - Mise à jour isCrafting = false^0")
            isCrafting = false
        end)
    else
        print("^1[DEBUG CRAFT CLIENT] craft:startCrafting BLOCKÉ - isCrafting déjà true^0")
    end
end)


CreateThread(function()
    while ESX == nil do Wait(1) end
    for jobName, craftPoint in pairs(Config_craftjob.CraftPoints) do
        local label = craftActionLabels[jobName] or 'Poste de préparation'
        local realJobName = realJobNames[jobName] or jobName
        local jobTable = {}
        jobTable[realJobName] = true
        if realJobName ~= jobName then
            jobTable[jobName] = true
        end

        AddZones(('craftjob_%s'):format(jobName), {
            Position = vector3(craftPoint.x, craftPoint.y, craftPoint.z),
            Dist = 10,
            Public = false,
            Job = jobTable,
            Job2 = jobTable,
            GradesJob = {},
            InVehicleDisable = true,
            Blip = { Active = false },
            ActionText = label,
            Action = function()
                OpenCraftMenu()
            end
        })
    end
end)

