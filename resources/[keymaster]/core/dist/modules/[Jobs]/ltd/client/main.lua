totalLTD = 0

local positions
local indexs = {}
local quantities = {}
basket = {}
local basketDescription, totalItems, totalPrice = "", 0, 0
local basketIndex = 1

Citizen.CreateThread(function()
    while ESX == nil do Wait(1) end
    ESX.TriggerServerCallback('getLTDPlayersCount', function(count)
        totalLTD = count
        updateWorldLTD()
    end)
        positions = {
            -- vector3(-48.35, -1757.1, 29.42), -- Ballas
            vector3(1136.01, -982.14, 46.42),
            vector3(1163.37, -323.8, 69.21),
            vector3(-1222.98, -907.09, 12.33),
            vector3(-1487.55, -379.11, 40.16),
            -- vector3(-1968.28, 390.92, 15.04),
            vector3(-3038.94, 585.95, 7.91),
            vector3(-3241.93, 1001.46, 12.83),
            vector3(2557.46, 382.28, 108.62),
            vector3(547.43, 2671.71, 42.15),
            vector3(2678.85, 3280.59, 55.24),
            vector3(1633.8601074219, 3660.5747070312, 34.936645507812),
            vector3(1392.58, 3604.69, 34.98),
            vector3(1698.39, 4924.4, 42.06),
            vector3(1729.31, 6414.06, 35.04),
            -- vector3(25.67, -1346.37, 29.49), -- Families
            -- vector3(-707.655, -914.57, 19.215), -- Little Seoul
            vector3(-2968.109, 391.575, 15.043),
            vector3(-1820.705, 792.394, 138.116),
            vector3(1165.32, 2709.311, 38.157),
            vector3(4818.817, -4309.076, 5.509152),
            vector3(4818.817, -4309.076, 5.509152),
            -- vector3(-525.16339111328, 7558.916015625, 6.5356178283691), -- RoxWood
            -- vector3(-381.91976928711, 7205.7485351562, 18.221349716187), -- RoxWood2
            -- vector3(-3111.9357910156, 6116.2622070312, 7.3085322380066), -- RoxWood3
            -- vector3(7891.7817382812, -849.88439941406, 47.720748901367), -- Las Venturas
        }
end)

RegisterNetEvent('updateLTDCount')
AddEventHandler('updateLTDCount', function(count)
    totalLTD = count
    updateWorldLTD()
end)

function updateWorldLTD()
    for k,v in pairs(positions) do
        local zoneName = ("ltd-world:%s"):format(k)

        if totalLTD > 0 then
            RemoveZone(zoneName)
            ESX.removeBlip(zoneName)
        else
            ESX.addBlips({
                name = zoneName,
                label = "Superette",
                position = v,
                sprite = 52,
                display = 4,
                scale = 0.4,
                color = 3
            })
            AddZones(zoneName, {
                Position = v,
                Dist = 10,
                Public = true,
                Job = nil,
                Job2 = nil,
                GradesJobRequire = false,
                GradesJob = {},
                InVehicleDisable = true,
                Blip = {
                    Active = false,
                    -- Position = vector3(2745.4719238281, 3477.0629882813, 55.671112060547),
                    -- BlipId = 605,
                    -- Color = 46,
                    -- Scale = 0.6,
                    -- Text = '[SERVICE] Supermarché'
                },
                ActionText = 'SUPERETTE',
                Action = function()
                --     if totalLTD > 0 then return ESX.ShowNotification("Ce LTD est actuellement indisponible.") end
                    exports['nv_shop']:OpenShop('shop')
                end
            })
        end
    end

    local sName = SunnyConfigServ.ServerName
    for k,v in pairs(SunnyLTD.ltdCFG.societies) do
        if totalLTD == 0 then
            ESX.removeBlip(k)
        else
            if v.servers ~= nil and v.servers[sName] == nil then 
                goto continue 
            end

            local societyState = Society.List[k]
            local color = (societyState == nil or not societyState.state) and 1 or 2 
            
            ESX.addBlips({
                name = k,
                label = v.label,
                category = 4,
                position = v.bossMenu,
                sprite = 59,
                display = 4,
                scale = 0.5,
                color = color,
            })

            ::continue::
        end
    end
end

local function actualizeBasket(basket, catalogId)
    local catalog = SunnyLTD.ltdCFG.catalogs[catalogId]
    local labels = SunnyLTD.ltdCFG.labels
    local basketDescription = "\n\n"
    local totalItems = 0
    local totalPrice = 0

    for k,v in pairs(basket) do 
        basketDescription = ("%s\nx%s %s."):format(basketDescription, v, labels[k])
        totalItems = totalItems + v
        totalPrice = totalPrice + (v * catalog[k])
    end

    return basketDescription, totalItems, totalPrice
end

function MenuLtdF6()
    local MainLtd = RageUI.CreateMenu('', 'Actions Disponibles')

    RageUI.Visible(MainLtd, not RageUI.Visible(MainLtd))
    while MainLtd do Wait(1)
        RageUI.IsVisible(MainLtd, function()
            RageUI.Checkbox('Statut de l\'entreprise', 'Quand cette case est cochée votre ENTREPRISE est notée comme ouverte', Society.List[ESX.PlayerData.job.name].state, {}, {
                onChecked = function()
                    TriggerServerEvent('sunny:jobs:updateSocietyStatus', true)
                    TriggerServerEvent('LtdInserviceTacpt', true)
                end,
                onUnChecked = function()
                    TriggerServerEvent('sunny:jobs:updateSocietyStatus', false)
                    TriggerServerEvent('LtdInserviceTacpt', false)
                end
            })
            
            RageUI.Button("Montrer son badge", nil, {}, true, {
                onSelected = function()
                ShowJobBadge(ESX.PlayerData.job.name)
                end
                })
                RageUI.Line()
                RageUI.Button('Faire une facture', nil, {}, true, {
                    onSelected = function()
                        local player, distance = ESX.Game.GetClosestPlayer()
                        if distance == -1 or distance > 3 then return ESX.ShowNotification('Personne aux alentours') end
                        KeyboardUtils.use('Montant', function(data)
                            local data = tonumber(data)
    
                            if data == nil or data <= 0  then return end
    
                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), ('society_%s'):format(ESX.GetPlayerData().job.name), ESX.GetPlayerData().job.label, data)
                        end)
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
             end)

      

        if not RageUI.Visible(MainLtd) then
            MainLtd = RMenu:DeleteType('MainLtd')
        end
    end
end

RegisterCommand('MenuLtdF6VV', function()
    if ESX.PlayerData.job.name == 'ltd_littleseoul' or ESX.PlayerData.job.name == 'ltd_paletobay' or ESX.PlayerData.job.name == 'ltd_f4l' or ESX.PlayerData.job.name == 'ltd_ballas' then 

    MenuLtdF6()
    end
end)

RegisterKeyMapping('MenuLtdF6VV', 'Menu Ltd', 'keyboard', 'F6')




local function openLTDSeller()
    local job = ESX.GetPlayerData().job
    local society = SunnyLTD.ltdCFG.societies[job.name]

    if society == nil then return end 

    exports['nv_shop']:OpenShop('ltd')

   --[[  RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Citizen.Wait(0)

        closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        closestPosition = GetEntityCoords(GetPlayerPed(closestPlayer))

        if closestDistance ~= -1 and closestDistance <= 3.0 then
            DrawMarker(21, closestPosition.x, closestPosition.y, closestPosition.z + 0.95, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 170, 1, 1, 2, 0, nil, nil, 0)
        end

        RageUI.IsVisible(menu, function()
            RageUI.Button("Vider le panier", false, {}, true, {
                onSelected = function()
                    for k,v in pairs(catalog) do 
                        indexs[k] = 1
                    end

                    basket = {}
                    ESX.ShowNotification("Vous avez vidé le panier.")
                end
            })

            if searchItem == nil then
                RageUI.Button(("Rechercher"):format(), nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use("Entrez le nom de l'item",function(data) 
                            searchItem = data
                        end);
                    end
                })
            else
                RageUI.Button(("Arreter la recherche"):format(), nil, {}, true, {
                    onSelected = function()
                        searchItem = nil
                    end
                })
            end

            for k,v in pairs(catalog) do 
                if searchItem == nil then
                    RageUI.List(("%s (~g~%s$~s~)"):format(labels[k] or k, v), {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, indexs[k], "Sélectionne pour confirmer le choix.", {}, true, {
                        onListChange = function(Index)
                            indexs[k] = Index
                        end,

                        onSelected = function(Index)
                            local currentIndex = indexs[k] - 1
                            
                            if currentIndex <= 0 then 
                                ESX.ShowNotification(("🧺 Vous avez retiré tout les %s du panier."):format(labels[k]))
                            else
                                if basket[k] ~= currentIndex then
                                    ESX.ShowNotification(("🧺 Il y'a désormais x%s %s dans le panier."):format(currentIndex, k))
                                else
                                    ESX.ShowNotification(("🧺 Il y'a déjà x%s %s dans le panier."):format(currentIndex, k))
                                end
                            end

                            basket[k] = currentIndex > 0 and currentIndex or nil

                            basketDescription, totalItems, totalPrice = actualizeBasket(basket, society.catalogId)
                        end
                    })
                else
                    if string.match(string.lower(labels[k]), string.lower(searchItem)) then 
                        RageUI.List(("%s (~g~%s$~s~)"):format(labels[k] or k, v), {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, indexs[k], "Sélectionne pour confirmer le choix.", {}, true, {
                            onListChange = function(Index)
                                indexs[k] = Index
                            end,
    
                            onSelected = function(Index)
                                local currentIndex = indexs[k] - 1
                                
                                if currentIndex <= 0 then 
                                    ESX.ShowNotification(("🧺 Vous avez retiré tout les %s du panier."):format(labels[k]))
                                else
                                    if basket[k] ~= currentIndex then
                                        ESX.ShowNotification(("🧺 Il y'a désormais x%s %s dans le panier."):format(currentIndex, k))
                                    else
                                        ESX.ShowNotification(("🧺 Il y'a déjà x%s %s dans le panier."):format(currentIndex, k))
                                    end
                                end
    
                                basket[k] = currentIndex > 0 and currentIndex or nil
    
                                basketDescription, totalItems, totalPrice = actualizeBasket(basket, society.catalogId)
                            end
                        })
                    end
                end
            end

            RageUI.List("~g~Valider le panier", {"Client", "Moi"}, basketIndex, ("Il y'a %s items pour un total de ~g~%s$~s~.%s"):format(totalItems, totalPrice, basketDescription), {}, true, {
                onListChange = function(Index)
                    basketIndex = Index
                end,
                
                onSelected = function()
                    if json.encode(basket) == '[]' then 
                        ESX.ShowNotification("🧺Le panier est vide.")
                    else
                        if basketIndex == 1 then 
                            if closestDistance ~= -1 and closestDistance <= 3.0 then 
                                TriggerServerEvent('ltd:server:sellBasket', basket, GetPlayerServerId(closestPlayer))
                            else
                                ESX.ShowNotification("Il y a personne à proximité.")
                            end
                        else
                            TriggerServerEvent('ltd:server:sellBasket', basket)
                        end
                    end
                end
            })
        end)

        if not RageUI.Visible(menu) or #(posMenu - Player.coords) > 3.0 then
            menu = RMenu:DeleteType('menu', true)
        end
    end ]]
end


local function getTotalsalesAmount(data)
    local amount = 0
    local sales = 0

    for k,v in pairs(data) do 
        local dayAmount = ((v.day ~= nil and v.day.amount ~= nil and v.day.amount) or (v.amount ~= nil and v.amount)) or 0
        local nightAmount = v.night ~= nil and v.night.amount ~= nil and v.night.amount or 0
        local daysales = ((v.day ~= nil and v.day.sales ~= nil and v.day.sales) or (v.sales ~= nil and v.sales)) or 0
        local nightsales = v.night ~= nil and v.night.sales ~= nil and v.night.sales or 0

        amount = amount + (dayAmount + nightAmount)
        sales = sales + (daysales + nightsales)
    end

    return amount, sales
end

local function openLTDHistory()
   -- if exports["Slide"]:getInPersoMenu() then 
    --    return 
   -- end

    local job = ESX.GetPlayerData().job
    local society = SunnyLTD.ltdCFG.societies[job.name]

    if society == nil then return end 

    local menu = RageUI.CreateMenu(job.label, "Actions Disponible")
    local menu_history = RageUI.CreateSubMenu(menu, job.label, "Actions Disponible")
    local menu_confirm = RageUI.CreateSubMenu(menu, job.label, "Actions Disponible")
    local data = {}
    local totalAmount = 0
    local totalsales = 0
    local searchPlayer = nil

    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Citizen.Wait(0)

        RageUI.IsVisible(menu, function()
            RageUI.Button("Historique de ventes employés", false, {}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback("ltd:server:requestEmployeesHistory", function(result) 
                        if result then 
                            totalAmount, totalsales = getTotalsalesAmount(result)
                            data = result
                            RageUI.Visible(menu_history, true)
                        end
                    end)
                end
            })

            RageUI.Button("~r~Vider l'historique de ventes", false, {}, true, {}, menu_confirm)
        end)

        RageUI.IsVisible(menu_history, function()
            RageUI.Separator(("Somme des bénéfices totaux : ~g~%s$~s~ pour %s ventes."):format(totalAmount, totalsales))


            if searchPlayer == nil then
                RageUI.Button(("Rechercher"):format(), nil, {}, true, {
                    onSelected = function()
                        local input = ESX.GetTextInput("Nom de la personne")
                        if input == nil then
                            return ESX.ShowNotification("~r~Le nom de la personne ne peut pas être nul")
                        end

                        searchPlayer = input
                    end
                })
            else
                RageUI.Button(("Arreter la recherche"):format(), nil, {}, true, {
                    onSelected = function()
                        searchPlayer = nil
                    end
                }) 
            end

            for k, v in pairs(data) do 
                local dayAmount = ((v.day ~= nil and v.day.amount ~= nil and v.day.amount) or (v.amount ~= nil and v.amount)) or 0
                local nightAmount = v.night ~= nil and v.night.amount ~= nil and v.night.amount or 0
                local daysales = ((v.day ~= nil and v.day.sales ~= nil and v.day.sales) or (v.sales ~= nil and v.sales)) or 0
                local nightsales = v.night ~= nil and v.night.sales ~= nil and v.night.sales or 0
                local totalsales = daysales + nightsales
                local totalAmount = dayAmount + nightAmount
                local dayInfos = ("~h~Jour~h~\nNombre de ventes : %s\nSomme : %s$"):format(daysales, dayAmount)
                local nightInfos = ("\n~h~Nuit~h~\nNombre de ventes : %s\nSomme : %s$"):format(nightsales, nightAmount)

                if searchPlayer == nil then 
                    RageUI.Button(("%s (%s)"):format(v.playerName, totalsales), ('%s\n%s'):format(dayInfos, nightInfos), {RightLabel = ("~g~%s$"):format(totalAmount)}, true, {})
                else
                    if string.match(string.lower(v.playerName), string.lower(searchPlayer)) then 
                        RageUI.Button(("%s (%s)"):format(v.playerName, totalsales), ('%s\n%s'):format(dayInfos, nightInfos), {RightLabel = ("~g~%s$"):format(totalAmount)}, true, {})
                    end
                end
            end
        end)

        RageUI.IsVisible(menu_confirm, function()
            RageUI.Button("", false, {LeftBadge = RageUI.BadgeStyle.Alert, RightBadge = RageUI.BadgeStyle.Alert}, true, {})
            RageUI.Button("", false, {LeftBadge = RageUI.BadgeStyle.Alert, RightBadge = RageUI.BadgeStyle.Alert}, true, {})
            RageUI.Button("Supprimer toutes les données de ventes définitivement.", false, {}, true, {
                onSelected = function()
                    TriggerServerEvent('ltd:server:resetDataLTD')
                    RageUI.GoBack()
                end
            })
            RageUI.Button("", false, {LeftBadge = RageUI.BadgeStyle.Alert, RightBadge = RageUI.BadgeStyle.Alert}, true, {})
            RageUI.Button("", false, {LeftBadge = RageUI.BadgeStyle.Alert, RightBadge = RageUI.BadgeStyle.Alert}, true, {})
        end)

        if not RageUI.Visible(menu) and not RageUI.Visible(menu_history) and not RageUI.Visible(menu_confirm) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end

RegisterNetEvent('ltd:client:sendBasketRequest', function(price, emote, totalcost, items, target, employe)
    local finalTimer = GetGameTimer() + 10000
    local response = false
    ESX.ShowNotification(("Vous avez reçu une facture de ~g~%s$~s~.\n\n[<kbd>H</kbd>] pour payer en cash.\n[<kbd>Y</kbd>] pour payer en banque.\n[<kbd>F</kbd>] pour refuser de payer."):format(totalcost), 10000)
    
    Citizen.CreateThread(function()
        while not response and GetGameTimer() <= finalTimer do 
            if IsControlJustPressed(1, 23) then
                --refuser
                TriggerServerEvent('ltd:server:sendBasketResponse', false)
                ESX.ShowNotification("Vous avez refusé de payer.")
                response = true
                if emote then
                    ExecuteCommand('e noway')
                end
            elseif IsControlJustPressed(1, 246) then
                --banque
                TriggerServerEvent('ltd:server:sendBasketResponse', true, totalcost, "bank", target, items, employe)
                response = true
                if emote then
                    ExecuteCommand('e give')
                end
            elseif IsControlJustPressed(1, 74) then 
                --cash
                TriggerServerEvent('ltd:server:sendBasketResponse', true, totalcost,"cash", target, items, employe)
                response = true
                if emote then
                    ExecuteCommand('e give')
                end
            end

            Citizen.Wait(0)
        end

        if not response then
            TriggerServerEvent('ltd:server:sendBasketResponse', false)
            if emote then
                ExecuteCommand('e noway')
            end
        end
    end)
end)    

RegisterNetEvent('ltd:client:updateBasket', function(cart, isPawnShop)
    if isPawnShop then return end

    basket = cart
end)

RegisterNetEvent('ltd:client:buyBasket', function(buyerType, basket, isPawnShop)
    if isPawnShop then return end
    
    local newBasket = {}

    for k,v in pairs(basket) do 
        newBasket[v.name] = v.qtty
    end

    if buyerType == 1 then 
        TriggerServerEvent('ltd:server:sellBasket', newBasket, buyerType)
    else 
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        local closestPosition = GetEntityCoords(GetPlayerPed(closestPlayer))

        if closestDistance ~= -1 and closestDistance <= 3.0 then 
            TriggerServerEvent('ltd:server:sellBasket', newBasket, buyerType, GetPlayerServerId(closestPlayer))
            ESX.ShowNotification("Vous avez bien envoyé la facture.")
        else
            ESX.ShowNotification("Il y a personne à proximité.")
        end
    end
end)



Citizen.CreateThread(function()
    Wait(5000)

    local blipData = SunnyLTD.ltdCFG.blip
    local sName = SunnyConfigServ.ServerName

    for k,v in pairs(SunnyLTD.ltdCFG.societies) do 
        if v.servers ~= nil and v.servers[sName] == nil then 
            goto continue 
        end

        AddZones("ltd_history-"..k, {
            Position = v.historyMenu,
            Dist = 1,
            Public = false,
            Job = {[k] = true},
            Job2 = {},
            GradesJob = {},
            InVehicleDisable = false,
            Blip = {},
            ActionText = 'Consulter l\'historique',
            marker = false,
            Action = function()
                openLTDHistory()
            end
        })

        for catalogId, pos in pairs(v.catalogMenu) do

            AddZones(("ltd-%s-seller:%s"):format(k, catalogId), {
                Position = pos,
                Dist = 1,
                Public = false,
                Job = {[k] = true},
                Job2 = {},
                GradesJob = {},
                InVehicleDisable = false,
                Blip = {},
                ActionText = 'Ouvrir le stand vendeur',
                marker = false,
                Action = function()
                    openLTDSeller()
                end
            })
        end

        ::continue::
    end
end)