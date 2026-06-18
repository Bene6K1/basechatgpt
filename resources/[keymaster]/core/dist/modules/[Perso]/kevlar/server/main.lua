local MyClientCode = [[
    local InArmour = false

    RegisterNetEvent('sunny:SetArmour')
    AddEventHandler('sunny:SetArmour', function(type)

        InArmour = type
    end)

    AddEventHandler("gameEventTriggered", function(eventName, eventArguments)
        if InArmour then 
            local args = {}
            if eventName == "CEventNetworkEntityDamage" then
                local victimEntity, attackEntity, damage, _, _, fatalBool, weaponUsed, _, _, _, entityType = table.unpack(eventArguments)
                args = { victimEntity, attackEntity, fatalBool == 1, weaponUsed, entityType,
                    math.floor(string.unpack("f", string.pack("i4", damage)))
                }
                if GetEntityType(victimEntity) == 1 then 
                    if victimEntity == PlayerPedId() then 
                        if InArmour then 
                            if GetPedArmour(PlayerPedId()) == 0 then
                                TriggerServerEvent('sunny:BreakKevlar')
                                ExecuteCommand('+ragdoll')
                                InArmour = false
                            end
                        end
                    end
                end
            end
        end
    end)

    function HasKevlar()

        return InArmour
    end
]]

-- local InArmour = false

-- RegisterNetEvent('sunny:SetArmour')
-- AddEventHandler('sunny:SetArmour', function(type)
--     print('kevlar', type)
--     InArmour = type
-- end)

-- AddEventHandler("gameEventTriggered", function(eventName, eventArguments, token)
--     if InArmour then 
--         local args = {}
--         if eventName == "CEventNetworkEntityDamage" then
--             local victimEntity, attackEntity, damage, _, _, fatalBool, weaponUsed, _, _, _, entityType = table.unpack(eventArguments)
--             args = { victimEntity, attackEntity, fatalBool == 1, weaponUsed, entityType,
--                 math.floor(string.unpack("f", string.pack("i4", damage)))
--             }
--             if GetEntityType(victimEntity) == 1 then 
--                 if victimEntity == PlayerPedId() then 
--                     if InArmour then 
--                         if GetPedArmour(PlayerPedId()) == 0 then
--                             TriggerServerEvent('sunny:BreakKevlar')
--                             ExecuteCommand('+ragdoll')
--                             InArmour = false
--                         end
--                     end
--                 end
--             end
--         end
--     end
-- end)

-- function HasKevlar()

--     return InArmour
-- end

local LoadingCode = {}
RegisterNetEvent('sunny:LoadKevlarCode')
AddEventHandler('sunny:LoadKevlarCode', function()
    if not LoadingCode[source] then 
        LoadingCode[source] = true
        TriggerClientEvent('sunny:Kevlar', source, MyClientCode)
    else
        DropPlayer(source, 'Duplicated code')
    end
end)

SunnyConfigServ.eKevlar.PlayerList = {}
SunnyConfigServ.eKevlar.KevPlayList = {}
SunnyConfigServ.eKevlar.tokenPlayer = {}

AddEventHandler('esx:playerLoaded', function()
    local _src = source
    if not SunnyConfigServ.eKevlar.KevPlayList[_src] then 
        SunnyConfigServ.eKevlar.KevPlayList[_src] = _src
        SunnyConfigServ.eKevlar.tokenPlayer[_src] = _src

    end
end)

AddEventHandler("esx:playerDropped", function(reason)
    if SunnyConfigServ.eKevlar.KevPlayList[source] then 
        SunnyConfigServ.eKevlar.KevPlayList[source] = nil
        SunnyConfigServ.eKevlar.tokenPlayer[source] = nil
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(100)
        for k,v in pairs(SunnyConfigServ.eKevlar.PlayerList) do 
            if GetPlayerPed(k) ~= 0 then
                Wait(350)
                if GetPedArmour(GetPlayerPed(k)) == 0 and SunnyConfigServ.eKevlar.KevPlayList[k] then 
                    SunnyConfigServ.eKevlar.KevPlayList[k] = nil
                elseif GetPedArmour(GetPlayerPed(k)) > 0 and SunnyConfigServ.eKevlar.KevPlayList[k] then
                    SunnyConfigServ.eKevlar.KevPlayList[k] = GetPedArmour(GetPlayerPed(k))
                end

                if GetPedArmour(GetPlayerPed(k)) > 0 and not SunnyConfigServ.eKevlar.KevPlayList[k] then
                    SunnyConfigServ.eKevlar.BanAction()
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do Wait(1) end 
    ESX.RegisterUsableItem('kevlar', function(source)
        TriggerEvent('sunny:UseKevlar', source, 'kevlar', 100)
    end)

    ESX.RegisterUsableItem('kevlarmid', function(source)
        TriggerEvent('sunny:UseKevlar', source, 'kevlarmid', 75)
    end)
    
    ESX.RegisterUsableItem('kevlarlow', function(source)
        TriggerEvent('sunny:UseKevlar', source, 'kevlarlow', 50)
    end)
end)

RegisterNetEvent('getPlayerskin')
AddEventHandler('getPlayerskin', function(identifier, cb)
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(users)
		local user, skin = users[1]

		if user.skin then
			skin = json.decode(user.skin)
		end
		cb(skin)
	end)
end)

RegisterNetEvent('sunny:BreakKevlar')
AddEventHandler('sunny:BreakKevlar', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if SunnyConfigServ.eKevlar.KevPlayList[src] then 
        SunnyConfigServ.eKevlar.KevPlayList[src] = nil
    end
    TriggerClientEvent('sunny:SetArmour', src, false)
    TriggerEvent('getPlayerskin', xPlayer.identifier, function(skin)
        if skin.sex == 0 then
            local clothesSkin = {
                ['bproof_1'] = 0, 
                ['bproof_2'] = 0,
            }
            TriggerClientEvent(SunnyConfigServ.eKevlar.loadClothesEvent, src, skin, clothesSkin)
        else
            local clothesSkin = {
                ['bproof_1'] = 0, 
                ['bproof_2'] = 0,
            }
            TriggerEvent(SunnyConfigServ.eKevlar.loadClothesEvent, src, skin, clothesSkin)
        end
    end)
end)

AddEventHandler('sunny:UseKevlar', function(src, type, count)
    local src = src
    local xPlayer = ESX.GetPlayerFromId(src)

    if (xPlayer) then 
        local itemCount = exports.ox_inventory:Search(src, 'count', type) or 0
        if itemCount > 0 then
            local currentArmour = GetPedArmour(GetPlayerPed(src))
            if not SunnyConfigServ.eKevlar.KevPlayList[src] or currentArmour == 0 then
                if currentArmour == 0 then
                    SunnyConfigServ.eKevlar.KevPlayList[src] = nil
                end
              local removed = exports.ox_inventory:RemoveItem(src, type, 1)
              if not removed or removed == 0 then
                xPlayer.showNotification("Impossible d'utiliser le kevlar.")
                return
              end
              SunnyConfigServ.eKevlar.KevPlayList[src] = count
              SetPedArmour(GetPlayerPed(src), count)
              TriggerEvent('getPlayerskin', xPlayer.identifier, function(skin)
                  if skin.sex == 0 then
                      local clothesSkin = {
                          ['bproof_1'] = SunnyConfigServ.eKevlar.skin.male.kevID, 
                          ['bproof_2'] = SunnyConfigServ.eKevlar.skin.male.textureID,
                      }
                      TriggerClientEvent(SunnyConfigServ.eKevlar.loadClothesEvent, src, skin, clothesSkin)
                  else
                      local clothesSkin = {
                          ['bproof_1'] = SunnyConfigServ.eKevlar.skin.female.kevID, 
                          ['bproof_2'] = SunnyConfigServ.eKevlar.skin.female.textureID,
                      }
                      TriggerEvent(SunnyConfigServ.eKevlar.loadClothesEvent, src, skin, clothesSkin)

                  end
              end)
              TriggerClientEvent('sunny:SetArmour', src, true)
              sendLog(("Le Joueur (%s - %s) viens d'utiliser son kevlar"):format(xPlayer.name, xPlayer.UniqueID ), {
                author = society,
                fields = {
                    {title = 'Player', subtitle = xPlayer.name},
                    {title = 'ID Unique', subtitle = xPlayer.UniqueID},
                    {title = 'Identifier', subtitle = xPlayer.identifier},
                },
                channel = 'kevlar'
            })
            else
                xPlayer.showNotification('Vous avez déjà un kevlar')
            end
        end
    end
end)

RegisterNetEvent('sunny:RemoveKevlar')
AddEventHandler('sunny:RemoveKevlar', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if SunnyConfigServ.eKevlar.KevPlayList[src] and GetPedArmour(GetPlayerPed(src)) > 0 then
        if GetPedArmour(GetPlayerPed(src)) > 24 and GetPedArmour(GetPlayerPed(src)) < 50 then
            exports.ox_inventory:AddItem(src, 'kevlarlow', 1) 
            SunnyConfigServ.eKevlar.KevPlayList[src] = nil
        elseif GetPedArmour(GetPlayerPed(src)) > 49 and GetPedArmour(GetPlayerPed(src)) < 75 then
            exports.ox_inventory:AddItem(src, 'kevlarmid', 1) 
            SunnyConfigServ.eKevlar.KevPlayList[src] = nil
        elseif GetPedArmour(GetPlayerPed(src)) > 74 and GetPedArmour(GetPlayerPed(src)) <= 100 then
            exports.ox_inventory:AddItem(src, 'kevlar', 1) 
            SunnyConfigServ.eKevlar.KevPlayList[src] = nil
        end
        TriggerEvent('getPlayerskin', xPlayer.identifier, function(skin)
            if skin.sex == 0 then
                local clothesSkin = {
                    ['bproof_1'] = 0, 
                    ['bproof_2'] = 0,
                }
                TriggerClientEvent(SunnyConfigServ.eKevlar.loadClothesEvent, src, skin, clothesSkin)
            else
                local clothesSkin = {
                    ['bproof_1'] = 0, 
                    ['bproof_2'] = 0,
                }
                TriggerEvent(SunnyConfigServ.eKevlar.loadClothesEvent, src, skin, clothesSkin)
            end
        end)
        SetPedArmour(GetPlayerPed(src), 0)
        xPlayer.showNotification('Votre kevlar à été remis dans votre inventaire')
        TriggerClientEvent('sunny:SetArmour', src, false)
    else
        xPlayer.showNotification('Vous n\'avez pas de kevlar')
    end
end)

AddEventHandler('playerDropped', function (reason)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if (xPlayer) then
        if SunnyConfigServ.eKevlar.KevPlayList[src] then
            if SunnyConfigServ.eKevlar.KevPlayList[src] > 24 and SunnyConfigServ.eKevlar.KevPlayList[src] < 50 then
                exports.ox_inventory:AddItem(src, 'kevlarlow', 1) 
            elseif SunnyConfigServ.eKevlar.KevPlayList[src] > 49 and SunnyConfigServ.eKevlar.KevPlayList[src] < 75 then
                exports.ox_inventory:AddItem(src, 'kevlarmid', 1) 
            elseif SunnyConfigServ.eKevlar.KevPlayList[src] > 74 and SunnyConfigServ.eKevlar.KevPlayList[src] <= 100 then
                exports.ox_inventory:AddItem(src, 'kevlar', 1) 
            end
        end
    end
end)

exports('useKevlar', function(...)
    local arg1 = select(1, ...)
    local arg2 = select(2, ...)
    local arg3 = select(3, ...)
    local arg4 = select(4, ...)
    local arg5 = select(5, ...)
    
    local actualInventory = nil
    local actualItem = nil
    
    for i = 1, 5 do
        local arg = select(i, ...)
        if arg and type(arg) == 'table' then
            if arg.id and type(arg.id) == 'number' then
                actualInventory = arg
            elseif arg.name then
                actualItem = arg
            end
        end
    end
    
    if not actualInventory then
        actualInventory = arg4
    end
    if not actualItem then
        actualItem = arg3
    end
    
    if not actualInventory or type(actualInventory) ~= 'table' or not actualInventory.id then
        print('[useKevlar] Erreur: inventaire invalide')
        return
    end
    
    if not actualItem or type(actualItem) ~= 'table' or not actualItem.name then
        print('[useKevlar] Erreur: item invalide')
        return
    end
    
    local source = actualInventory.id
    local itemName = actualItem.name
    
    local count = 100 
    if itemName == 'kevlarmid' then
        count = 75
    elseif itemName == 'kevlarlow' then
        count = 50
    end
    
    TriggerEvent('sunny:UseKevlar', source, itemName, count)
end)