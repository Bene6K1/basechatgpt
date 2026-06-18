function SunnyCraftWeapons:openMoltenSteel()
    local main = RageUI.CreateMenu('', 'Actions Disponibles')
    local count = false

    ESX.TriggerServerCallback('sunny:getIem', function(cb)
        count = cb
        -- print('Callback slide:getIem:', cb)
    end)

    RageUI.Visible(main, not RageUI.Visible(main))
    FreezeEntityPosition(Player.playerPed, true)
    
    while main do
        Wait(1)
        RageUI.IsVisible(main, function()
            RageUI.Separator('Acier à fondre')
            RageUI.Line()
            for k,v in pairs(ESX.GetPlayerData().inventory) do
                if v.name ~= 'treatedsteel' then goto continue end

                RageUI.Button(v.label, nil, {RightLabel = '~r~Quantité(s): '..v.count}, not SunnyCraftWeapons.fond, {
                    onSelected = function()
                        KeyboardUtils.use('Quantité à fondre', function(data)
                            local data = tonumber(data)
                            if data == nil or data < 10 then return end
                            if data > v.count then return ESX.ShowNotification('Vous n\'en possédez pas assez') end
                            if data >= 50 then return ESX.ShowNotification('Il n\'y a pas assez de place dans le bac') end

                            SunnyCraftWeapons.loadpercent = 0.0
                            SunnyCraftWeapons.count = 0.00006

                            SunnyCraftWeapons.count = SunnyCraftWeapons.count * (50 / data)

                            SunnyCraftWeapons.fond = true

                            SunnyCraftWeapons.fondCount = data
                        end)
                    end
                })

                if SunnyCraftWeapons.fond then
                    RageUI.PercentagePanel(SunnyCraftWeapons.loadpercent, "Fonte des métaux en cours (~y~" .. math.floor(SunnyCraftWeapons.loadpercent * 100) .. "%~s~)", "", "", function(a, percent) end)
                    if SunnyCraftWeapons.loadpercent < 1.0 then
                        SunnyCraftWeapons.loadpercent = SunnyCraftWeapons.loadpercent + SunnyCraftWeapons.count
                    else
                        SunnyCraftWeapons.loadpercent = 0
                        SunnyCraftWeapons.fond = false

                        TriggerServerEvent('sunny:craft:fond', SunnyCraftWeapons.fondCount)
                    end
                end

                ::continue::
            end

            if not count then
                RageUI.Separator('~r~Vous ne possédez pas d\'acier traité')
            end
        end)

        if not RageUI.Visible(main) then
            main = RMenu:DeleteType('main')
            FreezeEntityPosition(Player.playerPed, false)
        end
    end
end


function SunnyCraftWeapons:getQuantityMoneyWithItemPrice(price)
    ESX.PlayerData = ESX.GetPlayerData()
    for k,v in pairs(ESX.PlayerData.accounts) do
        if v.name == 'black_money' then
            if v.money < tonumber(price) then return false end
        end
    end

    return true
end

function SunnyCraftWeapons:setPlayerAnim()
    Player.playerPed = PlayerPedId()
end

function SunnyCraftWeapons:getInvenotryItem(item)
    ESX.PlayerData = ESX.GetPlayerData()
    for k,v in pairs(ESX.PlayerData.inventory) do
        if v.name ~= item then
            return v
        end
    end
end

function SunnyCraftWeapons:openCraftWeapons()
    local main = RageUI.CreateMenu('', 'Actions Disponibles')

    RageUI.Visible(main, not RageUI.Visible(main))
    FreezeEntityPosition(Player.playerPed, true)

    while main do
        Wait(1)
        RageUI.IsVisible(main, function()
            for k,v in pairs(SunnyCraftWeapons.Weapons) do
                local buttonName = ('%s'):format(v.label)
                RageUI.Button(buttonName, nil, {RightLabel = ('~g~%s$~s~'):format(v.price)}, not SunnyCraftWeapons.crafting, {
                    onActive = function()
                        RageUI.Info('Informations de la création', {
                            'Prix',
                            'Acier fondu nécessaire',
                            'Fil de fer nécessaire',
                            'Outil requis',
                            'Temps de la création'
                        },
                        {
                            v.price..' $',
                            v.acierFondue..' L',
                            v.filFer..' cm',
                            'Soudeuse',
                            v.time..' minutes'
                        })
                    end,
                    onSelected = function()
                        local access = false
                        ESX.TriggerServerCallback('sunny:getItem2', function(cb1)
                            if cb1 then
                                ESX.TriggerServerCallback('sunny:getItem3', function(cb2)
                                    if cb2 then
                                        access = true
                                        -- print('Access granted')
                                    else
                                        ESX.ShowNotification('Vous ne possédez pas assez de fil de fer.')
                                    end
                                end, 'wire')
                            else
                                ESX.ShowNotification('Vous ne possédez pas assez d\'acier fondu.')
                            end
                        end, 'melted_steel')

                        Wait(500)

                        if not access then return end

                        if not SunnyCraftWeapons:getQuantityMoneyWithItemPrice(v.price) then
                            return ESX.ShowNotification('Vous n\'avez pas l\'argent nécessaire')
                        end

                        SunnyCraftWeapons.crafting = true

                        TriggerServerEvent('sunny:weapons:paid', v.price, v.acierFondue, v.filFer)
                        CreateThread(function()
                            RageUI.CloseAll()
                            local timeRemaining = v.time -- Copie locale pour ne pas modifier la config
                            local weaponName = v.name
                            local weaponLabel = v.label
                            while SunnyCraftWeapons.crafting do
                                Wait(10000)
                                timeRemaining = timeRemaining - 1
                                if timeRemaining <= 0 then
                                    SunnyCraftWeapons.crafting = false
                                    TriggerServerEvent('sunny:weapons:give', weaponName, weaponLabel)
                                end
                            end
                        end)
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




local loadede = false
local tt = {}

RegisterNetEvent('sunny:weapons:load', function(table)
    tt = table
    loadede = true
end)

CreateThread(function()
    local permi
    while not ESXLoaded do Wait(1) end
    while not loadede do Wait(1) end
    AddZones('fonderie', {
        Position = vector3(1084.9197998047, -2002.4211425781, 31.402545928955),
        Dist = 10,
        Public = false,
        Job = tt,
        Job2 = tt,
        GradesJob = {},
        InVehicleDisable = true,
        Blip = {
            Active = true,
            Position = vector3(1084.9197998047, -2002.4211425781, 31.402545928955),
            BlipId = 253,
            Color = 1,
            Scale = 0.5,
            Text = 'Fonderie'
        },
        ActionText =('pour intéragir'):format(UTILS.COLORCODE),
        Action = function()
            SunnyCraftWeapons:openMoltenSteel()
        end
    })
    AddZones('craft_weapons', {
        Position = vector3(1014.667175, 2905.561035, 41.386265),
        Dist = 10,
        Public = false,
        Job = tt,
        Job2 = tt,
        GradesJob = {},
        InVehicleDisable = true,
        Blip = {
            Active = false,
            Position = vector3(1015.645, 2905.471, 41.36798),
            BlipId = 784,
            Color = 1,
            Scale = 0.5,
            Text = 'Craft D\'arme'
        },
        marker = false,
        ActionText =('pour intéragir'):format(UTILS.COLORCODE),
        Action = function()
            SunnyCraftWeapons:openCraftWeapons()
        end
    })
end)