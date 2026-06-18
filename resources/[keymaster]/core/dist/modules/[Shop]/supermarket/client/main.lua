-- function openSupermarket()
--     local main = RageUI.CreateMenu('', 'Supermarket')

--     RageUI.Visible(main, not RageUI.Visible(main))
--     FreezeEntityPosition(Player.playerPed, true)
--     while main do Wait(1)
--         RageUI.IsVisible(main, function()
--             for k,v in pairs(SunnySupermarket) do
--                 RageUI.Button(v.label, nil, {RightLabel = ('~g~%s$~S~'):format(v.price)}, true, {
--                     onSelected = function()
--                         KeyboardUtils.use('Taper B pour payer en banque ou L en liquide', function(data)
--                             TriggerServerEvent('sunny:supermarket:paidItem', data, v.item, v.price)
--                         end)
--                     end
--                 })
--             end
--         end)

--         if not RageUI.Visible(main) and

--         not RageUI.Visible(main) then
--             main = RMenu:DeleteType('main')
--             FreezeEntityPosition(Player.playerPed, false)
--         end
--     end
-- end

-- function openIphoneShop()
--     Player.playerPed = PlayerPedId()
--     local main = RageUI.CreateMenu('', 'Apple Store')

--     RageUI.Visible(main, not RageUI.Visible(main))
--     FreezeEntityPosition(Player.playerPed, true)
--     while main do Wait(1)
--         RageUI.IsVisible(main, function()
--             RageUI.Button('Téléphone', nil, {RightLabel = ('~g~%s$~S~'):format(350)}, true, {
--                 onSelected = function()
--                     KeyboardUtils.use('Taper B pour payer en banque ou L en liquide', function(data)
--                         TriggerServerEvent('sunny:supermarket:paidItem', data, 'phone', 350)
--                     end)
--                 end
--             })
--         end)

--         if not RageUI.Visible(main) and

--         not RageUI.Visible(main) then
--             main = RMenu:DeleteType('main')
--             FreezeEntityPosition(Player.playerPed, false)
--         end
--     end
-- end

-- function openArmorie()
--     Player.playerPed = PlayerPedId()
--     local main = RageUI.CreateMenu('', 'Armurerie')

--     RageUI.Visible(main, not RageUI.Visible(main))
--     FreezeEntityPosition(Player.playerPed, true)
--     while main do Wait(1)
--         RageUI.IsVisible(main, function()
--             for k,v in pairs(SunnyArmorie.weapons) do
--                 RageUI.Button(v.label, nil, {RightLabel = ('~g~%s$~S~'):format(v.price)}, true, {
--                     onSelected = function()
--                         KeyboardUtils.use('Taper B pour payer en banque ou L en liquide', function(data)
--                             TriggerServerEvent('sunny:supermarket:paidWeapon', data, v.weapon, v.price)
--                         end)
--                     end
--                 })
--             end
--             RageUI.Line()
--             RageUI.Button('Chargeur 9mm', nil, {RightLabel = ('~g~%s$~S~'):format(50)}, true, {
--                 onSelected = function()
--                     KeyboardUtils.use('Quantité', function(count)
--                         local count = tonumber(count)
--                         if not count then return end

--                         CreateThread(function()
--                             KeyboardUtils.use('Taper B pour payer en banque ou L en liquide', function(data)
--                                 TriggerServerEvent('sunny:supermarket:paidWeapon', data, '9mm', 50*count, count)
--                             end)
--                         end)
--                     end)
--                 end
--             })
--             RageUI.Button('Chargeur 12mm', nil, {RightLabel = ('~g~%s$~S~'):format(75)}, true, {
--                 onSelected = function()
--                     KeyboardUtils.use('Quantité', function(count)
--                         local count = tonumber(count)
--                         if not count then return end

--                         CreateThread(function()
--                             KeyboardUtils.use('Taper B pour payer en banque ou L en liquide', function(data)
--                                 TriggerServerEvent('sunny:supermarket:paidWeapon', data, '12gauge', 75*count, count)
--                             end)
--                         end)
--                     end)
--                 end
--             })
--             RageUI.Button('Chargeur 5.56mm', nil, {RightLabel = ('~g~%s$~S~'):format(110)}, true, {
--                 onSelected = function()
--                     KeyboardUtils.use('Quantité', function(count)
--                         local count = tonumber(count)
--                         if not count then return end

--                         CreateThread(function()
--                             KeyboardUtils.use('Taper B pour payer en banque ou L en liquide', function(data)
--                                 TriggerServerEvent('sunny:supermarket:paidWeapon', data, '556mm', 110*count, count)
--                             end)
--                         end)
--                     end)
--                 end
--             })
--             RageUI.Button('Chargeur 7.62mm', nil, {RightLabel = ('~g~%s$~S~'):format(150)}, true, {
--                 onSelected = function()
--                     KeyboardUtils.use('Quantité', function(count)
--                         local count = tonumber(count)
--                         if not count then return end

--                         CreateThread(function()
--                             KeyboardUtils.use('Taper B pour payer en banque ou L en liquide', function(data)
--                                 TriggerServerEvent('sunny:supermarket:paidWeapon', data, '762mm', 150*count, count)
--                             end)
--                         end)
--                     end)
--                 end
--             })
--             RageUI.Button('Chargeur Kal.68', nil, {RightLabel = ('~g~%s$~S~'):format(190)}, true, {
--                 onSelected = function()
--                     KeyboardUtils.use('Quantité', function(count)
--                         local count = tonumber(count)
--                         if not count then return end

--                         CreateThread(function()
--                             KeyboardUtils.use('Taper B pour payer en banque ou L en liquide', function(data)
--                                 TriggerServerEvent('sunny:supermarket:paidWeapon', data, '68kal', 190*count, count)
--                             end)
--                         end)
--                     end)
--                 end
--             })
--             RageUI.Button('Kevlar', nil, {RightLabel = ('~g~%s$~S~'):format(3500)}, true, {
--                 onSelected = function()
--                     KeyboardUtils.use('Taper B pour payer en banque ou L en liquide', function(data)
--                         TriggerServerEvent('sunny:supermarket:paidWeapon', data, 'kevlar', 3500)
--                     end)
--                 end
--             })
--             RageUI.Separator('~y~VIP ZONE~s~')
--             RageUI.Button('Pistolet (Beretta)', nil, {RightLabel = ('~g~%s$~S~'):format(1800000)}, true, {
--                 onSelected = function()
--                     if not VIP.haveVip() then return ESX.ShowNotification('Vous devez possedez le ~p~VIP~s~') end
--                     KeyboardUtils.use('Taper B pour payer en banque ou L en liquide', function(data)
--                         TriggerServerEvent('sunny:supermarket:paidWeapon', data, 'weapon_pistol', 180000)
--                     end)
--                 end
--             })
--         end)

--         if not RageUI.Visible(main) and

--         not RageUI.Visible(main) then
--             main = RMenu:DeleteType('main')
--             FreezeEntityPosition(Player.playerPed, false)
--         end
--     end
-- end

-- function openShop()
--     Player.playerPed = PlayerPedId()
--     local main = RageUI.CreateMenu('', 'Magazin')

--     RageUI.Visible(main, not RageUI.Visible(main))
--     FreezeEntityPosition(Player.playerPed, true)
--     while main do Wait(1)
--         RageUI.IsVisible(main, function()
--             RageUI.Button('Eau', nil, {RightLabel = ('~g~%s$~S~'):format(50)}, true, {
--                 onSelected = function()
--                     KeyboardUtils.use('Quantité', function(count)
--                         local count = tonumber(count)
--                         if not count then return end

--                         CreateThread(function()
--                             KeyboardUtils.use('Taper B pour payer en banque ou L en liquide', function(data)
--                                 TriggerServerEvent('sunny:supermarket:paidItem', data, 'water', 50*count, count)
--                             end)
--                         end)
--                     end)
--                 end
--             })
--             RageUI.Button('Pain', nil, {RightLabel = ('~g~%s$~S~'):format(50)}, true, {
--                 KeyboardUtils.use('Quantité', function(count)
--                     local count = tonumber(count)
--                     if not count then return end

--                     CreateThread(function()
--                         KeyboardUtils.use('Taper B pour payer en banque ou L en liquide', function(data)
--                             TriggerServerEvent('sunny:supermarket:paidItem', data, 'bread', 50*count, count)
--                         end)
--                     end)
--                 end)
--             })
--         end)

--         if not RageUI.Visible(main) and

--         not RageUI.Visible(main) then
--             main = RMenu:DeleteType('main')
--             FreezeEntityPosition(Player.playerPed, false)
--         end
--     end
-- end

local last = 0
local rentedVehicles = {}

function DrawTextFixed(x, y, text)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(0.45, 0.45)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

-- {spawnName = 'scorcher', label = 'VTT', price = 25},
-- {spawnName = 'faggio', label = 'Scooter Faggio', price = 50},
-- {spawnName = 'gbbriosof', label = 'Voiture Brioso F', price = 150}

function openLocation(type, h)
    Player.playerPed = PlayerPedId()
    local main = RageUI.CreateMenu('', 'Location')

    RageUI.Visible(main, not RageUI.Visible(main))
    FreezeEntityPosition(Player.playerPed, true)

    local vehicles = {
        {spawnName = 'faggio', label = 'Scooter Faggio', price = 25},
        {spawnName = 'faggio', label = 'Voiturette Club', price = 50},
        {spawnName = 'kanjosj', label = 'Voiture Kanjos J', price = 150}
    }

    while main do 
        Wait(1)
        RageUI.IsVisible(main, function()
            for _, vehicle in pairs(vehicles) do
                RageUI.Button(vehicle.label, "Le temps de location est de 15min !", {RightLabel = ('~g~%s$~s~'):format(vehicle.price)}, true, {
                    onSelected = function()
                        local currentime = GetGameTimer()
                        if currentime - last >= 120000 then
                            exports['prompt']:createPrompt(
                                SunnyConfigServ.ServerName,
                                ('Confirmez-vous la location de %s pour %s$ ?'):format(vehicle.label, vehicle.price),
                                '',
                                function(response)
                                    if response then -- Oui
                                        ESX.TriggerServerCallback('sunny:getMoney', function(hasMoney)
                                            if hasMoney then
                                                ESX.ShowNotification(('💲 Vous avez payé ~g~%s$~s~ pour %s'):format(vehicle.price, vehicle.label))
                                                ESX.Game.SpawnVehicle(vehicle.spawnName, type, h, function(spawnedVehicle)
                                                    last = GetGameTimer()
                                                    local vehicleId = NetworkGetNetworkIdFromEntity(spawnedVehicle)
                                                    rentedVehicles[vehicleId] = {
                                                        vehicle = spawnedVehicle,
                                                        rentTime = GetGameTimer()
                                                    }
                                                    RageUI.CloseAll() -- Fermeture du menu après location
                                                    FreezeEntityPosition(Player.playerPed, false) -- Déverrouillage du joueur
                                                    Citizen.CreateThread(function()
                                                        while rentedVehicles[vehicleId] do
                                                            Wait(0)
                                                            local playerPed = PlayerPedId()
                                                            local playerVeh = GetVehiclePedIsIn(playerPed, false)
                                                            if playerVeh == spawnedVehicle then
                                                                local remainingTime = 900000 - (GetGameTimer() - rentedVehicles[vehicleId].rentTime)
                                                                if remainingTime <= 0 then
                                                                    ESX.ShowNotification('⏰ Le temps de location est écoulé. Le véhicule va être supprimé.')
                                                                    DeleteEntity(spawnedVehicle)
                                                                    rentedVehicles[vehicleId] = nil
                                                                    break
                                                                else
                                                                    local minutes = math.floor(remainingTime / 60000)
                                                                    local seconds = math.floor((remainingTime % 60000) / 1000)
                                                                    local timeText = ('%sTemps restant: %02d:%02d'):format(SunnyConfigServ.GTACOLOR, minutes, seconds)
                                                                    DrawTextFixed(0.97, 0.97, timeText)
                                                                end
                                                            end
                                                        end
                                                    end)
                                                end)
                                            else
                                                ESX.ShowNotification('💲 ~r~Vous n\'avez pas assez d\'argent~s~')
                                            end
                                        end)
                                    else -- Non
                                        ESX.ShowNotification("Achat annulé")
                                    end
                                end
                            )
                        else
                            local tempderemain = 120000 - (currentime - last)
                            ESX.ShowNotification(('🕒 Veuillez patienter ~r~%d secondes~s~ avant de racheter un véhicule'):format(math.ceil(tempderemain / 1000)))
                        end
                    end
                })
            end
        end)

        if not RageUI.Visible(main) then
            main = RMenu:DeleteType('main')
            FreezeEntityPosition(Player.playerPed, false)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        for vehicleId, data in pairs(rentedVehicles) do
            if GetGameTimer() - data.rentTime >= 900000 then
                ESX.ShowNotification('⏰ Le temps de location est écoulé. Le véhicule va être supprimé.')
                DeleteEntity(data.vehicle)
                rentedVehicles[vehicleId] = nil
            end
        end
    end
end)

CreateThread(function()
    while not ESXLoaded do Wait(1) end
    -- AddZones('supermarket', {
    --     Position = SunnyConfigServ.LegalShops.SuperMarket,
    --     Dist = 10,
    --     Public = true,
    --     Job = nil,
    --     Job2 = nil,
    --     GradesJob = {},
    --     InVehicleDisable = true,
    --     Blip = {
    --         Active = true,
    --         Position = SunnyConfigServ.LegalShops.SuperMarket,
    --         BlipId = 605,
    --         Color = 46,
    --         Scale = 0.5,
    --         Text = 'Supermarché/IKEA'
    --     },
    --     ActionText = 'pour intéragir',
    --     Action = function()
    --         openUI('supermarket')
    --     end
    -- })

    -- _PEDS.addPed('supermarket', {
    --     model = 'csb_talcc',
    --     position = vector3(2749.48, 3483.425, 55.66621),
    --     heading = 74.422637939453,
    --     scenario = {
    --         active = false,
    --         name = 'WORLD_HUMAN_CLIPBOARD',
    --         count = 0,
    --     },
    --     weapon = {
    --         active = false,
    --         weaponName = 'weapon_musket',
    --     },
    --     floatingText = {
    --         active = true,
    --         text = 'Shokapik',
    --         color = 34,
    --     },
    -- })

    -- AddZones('apple_store', {
    --     Position = vector3(149.6046, -232.9334, 54.424),
    --     Dist = 10,
    --     Public = true,
    --     Job = nil,
    --     Job2 = nil,
    --     GradesJob = {},
    --     InVehicleDisable = true,
    --     Blip = {
    --         Active = true,
    --         Position = vector3(149.6046, -232.9334, 54.424),
    --         BlipId = 459,
    --         Color = 46,
    --         Scale = 0.8,
    --         Text = 'Apple Store'
    --     },
    --     ActionText = 'pour intéragir',
    --     Action = function()
    --         openUI('applestore')
    --     end
    -- })

    -- _PEDS.addPed('apple_store', {
    --     model = 'csb_talcc',
    --     position = vector3(148.7701, -234.561, 54.424),
    --     heading = 341.12155151367,
    --     scenario = {
    --         active = true,
    --         name = 'WORLD_HUMAN_CLIPBOARD',
    --         count = 0,
    --     },
    --     weapon = {
    --         active = false,
    --         weaponName = 'weapon_musket',
    --     },
    --     floatingText = {
    --         active = true,
    --         text = 'Zeno',
    --         color = 34,
    --     },
    -- })

    for k,v in pairs(SunnyArmorie.Pos) do
        AddZones('armuerie_pos_'..k, {
            Position = vector3(v.x, v.y, v.z),
            Dist = 10,
            Public = true,
            Job = nil,
            Job2 = nil,
            GradesJob = {},
            InVehicleDisable = true,
            Blip = {
                Active = true,
                Position = vector3(v.x, v.y, v.z),
                BlipId = 110,
                Color = 1,
                Scale = 0.5,
                Text = 'Armurerie'
            },
            ActionText = 'ARMURERIE',
            Action = function()
                exports['nv_shop']:OpenShop('ammunation')
            end
        })
    end

    for k,v in pairs(SunnyArmorie.AmmuPed) do
        _PEDS.addPed("armuerie_ped_"..k, {
            model = 'csb_talcc',
            position = vector3(v.x, v.y, v.z+1),
            heading = v.a,
            scenario = {
                active = false,
                name = 'WORLD_HUMAN_CLIPBOARD',
                count = 0,
            },
            weapon = {
                active = true,
                weaponName = 'weapon_advancedrifle',
            },
            floatingText = {
                active = true,
                text = 'Pascale',
                color = 34,
            },
        })
    end

    -- for k,v in pairs(SunnyShop) do
    --     AddZones("shop_pos_"..k, {
    --         Position = vector3(v.x, v.y, v.z),
    --         Dist = 10,
    --         Public = true,
    --         Job = nil,
    --         Job2 = nil,
    --         GradesJob = {},
    --         InVehicleDisable = true,
    --         Blip = {
    --             Active = false,
    --             Position = vector3(v.x, v.y, v.z),
    --             BlipId = 110,
    --             Color = 1,
    --             Scale = 0.8,
    --             Text = '24/7'
    --         },
    --         ActionText = 'pour intéragir',
    --         Action = function()
    --             exports['shop']:OpenShop('shop')
    --         end
    --     })
    -- end

    for k,v in pairs(SunnyLocation) do
        AddZones("location_pos_"..k, {
            Position = vector3(v.x, v.y, v.z),
            Dist = 10,
            Public = true,
            Job = nil,
            Job2 = nil,
            GradesJob = {},
            InVehicleDisable = true,
            marker = false,
            Blip = {
                Active = true,
                Position = vector3(v.x, v.y, v.z),
                BlipId = 280,
                Color = 2,
                Scale = 0.5,
                Text = 'Location'
            },
            ActionText = 'LOCATION',
            Action = function()
                openLocation(v.s, v.h)
            end
        })
    end

    for k,v in pairs(SunnyLocationPed) do
        _PEDS.addPed("location_ped_"..k, {
            model = 'csb_talcc',
            position = vector3(v.x, v.y, v.z),
            heading = v.heading,
            scenario = {
                active = true,
                name = 'WORLD_HUMAN_CLIPBOARD',
                count = 0,
            },
            weapon = {
                active = false,
                weaponName = 'weapon_advancedrifle',
            },
            floatingText = {
                active = true,
                text = 'Floyd',
                color = 34,
            },
        })
    end

end)