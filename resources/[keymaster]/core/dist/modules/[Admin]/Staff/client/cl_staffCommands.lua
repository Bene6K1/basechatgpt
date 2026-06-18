function ReturnPlayerId(UniqueID)
	for _,p in pairs(adminManagement.Players) do
		if p.UniqueID == tonumber(UniqueID) then
			return p
		end
	end

	return false
end

function adminManagement:StaffCommand(CommandName, permissionData, permissionName, func)
    RegisterCommand(CommandName, function(...)
        if Config.Staff.HavePermission(permissionData, permissionName) then
            func(...)
        end
    end)
end

RegisterCommand('limp', function(_, args)
    if not adminManagement.Service then return end
    local player = ReturnPlayerId(args[1])
    if player then
        TriggerServerEvent('sunny:admin:command:limp', player.id, tonumber(args[2] or 60))
    end
end)

RegisterNetEvent('sunny:admin:command:limp')
AddEventHandler('sunny:admin:command:limp', function(time)
    TriggerEvent('ata:client:applyEffect', time)
end)

RegisterCommand('adminMenu', function()
    if not Config.Staff.HavePermission('Menu', 'openMenu') then return end

    adminManagement:staffMenu()
end)

-- RegisterCommand('noclipAdminSlide', function()
--     NoClip()
-- end)

RegisterCommand('annonce', function(_, args)
    if Config.Staff.HavePermission('ServerOptions', 'announce') then
        if table.concat(args, ' ') == nil or table.concat(args, ' ') == '' then return end
        TriggerServerEvent('sunny:admin:announce', table.concat(args, ' '))
    end
end)

-- RegisterCommand('heal', function(_, args)
--     if not adminManagement.Service then return end
--     local player = ReturnPlayerId(args[1])
--     if player then
--         TriggerServerEvent('sunny:admin:command:heal', ReturnPlayerId(args[1]).id)
--     else
--         TriggerServerEvent('sunny:admin:command:heal', 0)
--     end
-- end)

RegisterCommand('staffbypass', function()
    if ESX.PlayerData.group == 'fondateur' or ESX.PlayerData.group == 'responsable' then
        TriggerServerEvent('sunny:admin:service')
        ExecuteCommand("revive")
        ExecuteCommand("Le Papillon sort ses ailes")
    else
        return ESX.ShowNotification('Erreur Ou bien mauvais grade')
    end
end)

RegisterCommand('warn', function(source, args)
    if not adminManagement.Service then return end
    if args[1] == nil then return end
    TriggerServerEvent('sunny:admin:warn', args[1], table.concat(args, ' ', 2))
end)

RegisterCommand('soundReport', function()
    if not (Config.Staff.HavePermission('Modules', 'reportsSong')) then return end
    adminManagement.SongReports = not adminManagement.SongReports
end)


RegisterKeyMapping('adminMenu', 'Menu Admin', 'keyboard', 'F10')
-- RegisterKeyMapping('noclipAdminSlide', 'Raccourci Noclip', 'keyboard', 'F11')

-- Fonction pour réparer un véhicule (staff uniquement)
local function StaffRepairVehicle()
    if not adminManagement.Service then
        return ESX.ShowNotification('~r~Vous devez être en service staff !')
    end

    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle == 0 then
        vehicle = ESX.Game.GetClosestVehicle(GetEntityCoords(playerPed))
    end

    if vehicle == 0 or not DoesEntityExist(vehicle) then
        return ESX.ShowNotification('~r~Aucun véhicule à proximité !')
    end

    TriggerServerEvent('sunny:staff:fix', NetworkGetNetworkIdFromEntity(vehicle))
end

-- Commandes /fix et /repair - Réservées au staff (alias)
RegisterCommand('fix', StaffRepairVehicle)
RegisterCommand('repair', StaffRepairVehicle)

-- Event pour exécuter le fix staff après validation serveur
RegisterNetEvent('sunny:staff:doFix', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(vehicle) then return end

    NetworkRequestControlOfEntity(vehicle)
    local timeout = 0
    while not NetworkHasControlOfEntity(vehicle) and timeout < 100 do
        Wait(10)
        timeout = timeout + 1
    end

    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleUndriveable(vehicle, false)
    SetVehicleEngineHealth(vehicle, 1000.0)
    SetVehicleBodyHealth(vehicle, 1000.0)
    SetVehiclePetrolTankHealth(vehicle, 1000.0)
    SetVehicleEngineOn(vehicle, true, true, false)
    ESX.ShowNotification('~g~Véhicule réparé avec succès !')
end)