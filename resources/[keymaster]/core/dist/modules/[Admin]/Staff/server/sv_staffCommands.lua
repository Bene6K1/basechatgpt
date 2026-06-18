function ReturnPlayerId(UniqueID)
	for _,p in pairs(adminManagement.Players) do
		if p.UniqueID == tonumber(UniqueID) then
			return p
		end
	end

	return false
end

function adminManagement:getPlayerFromUniqueID(UniqueID)
	for _,p in pairs(adminManagement.Players) do
		if p.UniqueID == tonumber(UniqueID) then
			local xPlayer = ESX.GetPlayerFromId(p.source)
			local isStaff = adminManagement.Service[p.UniqueID] or false
			return isStaff, xPlayer
		end
	end

	return false, false
end

function ReturnPlayerIdUseESXfunctions(UniqueID)
	for _,p in pairs(adminManagement.Players) do
		if p.UniqueID == tonumber(UniqueID) then
			return ESX.Players[tonumber(p.id)]
		end
	end

	return false
end

RegisterCommand('setgroup', function(source, args)
	if source ~= 0 then
		local myPlayer = ESX.GetPlayerFromId(source)
		if not Config.Staff.HavePermission('ManagePlayers', 'changegroup', myPlayer) then
			return
		end
	end
	local xPlayer = ReturnPlayerId(args[1])

	if xPlayer then
		if args[2] == nil then return end
		if not ESX.Groups[args[2]] then return end

		local playerSet = ESX.GetPlayerFromId(xPlayer.id)
		playerSet.setGroup(args[2])

		adminManagement.staffList[playerSet.source].group = playerSet.getGroup()
		adminManagement.Players[playerSet.source].group = playerSet.getGroup()

		TriggerClientEvent('sunny:admin:restart', playerSet.source)
		adminManagement:UpdateStaffs()
	end
end)

RegisterServerEvent('staff:server:messageZone')
AddEventHandler('staff:server:messageZone', function(playersIds, message)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'user' then return end

    for _, playerId in ipairs(playersIds) do
        TriggerClientEvent('esx:showNotification', playerId, message)
        sendLog(('Le staff (%s - %s) a envoyé un message à la zone, message : (%s)'):format(xPlayer.name, xPlayer.identifier, message), {
            author = 'message Zone',
            fields = {
                {title = 'Staff', value = xPlayer.name},
                {title = 'ID Unique', value = xPlayer.identifier},
                {title = 'Message', value = message},
                {title = 'Nombre de Personnes', value = #playersIds}
            },
            channel = 'zonemessage'
        })
    end
end)

RegisterNetEvent('admin:server:addZoneAta')
AddEventHandler('admin:server:addZoneAta', function(playersIds, time)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end

	time = tonumber(time) or 5

	for _, serverId in ipairs(playersIds) do
		local player = ESX.GetPlayerFromId(serverId)
		if player then
			TriggerClientEvent('ata:client:applyEffect', serverId, time)

			sendLog(('Le staff (%s - %s) a mis en ATA une zone (%s minutes)'):format(xPlayer.name, xPlayer.identifier, time), {
				author = 'atazone',
				fields = {
					{title = 'Staff', value = xPlayer.name},
					{title = 'ID Unique', value = xPlayer.identifier}, 
					{title = 'Durée', value = time..' minutes'},
					{title = 'Nombre de Personnes ATA', value = #playersIds}
				},
				channel = 'atazone'
			})
		end
	end
end)

RegisterCommand('reviver', function(source, args)
    local radius = tonumber(args[1])
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end
    if radius == nil or radius < 10 or radius > 100 then
		--print('echec revive all')
       -- if source > 0 then
       --     TriggerClientEvent('chat:addMessage', source, {
        --        args = {"^1SYSTEM", "La zone doit être un nombre entre 10 et 100"}
        --    })
      --  end
        return
    end

    if xPlayer == nil then return end
	--print('1')
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local players = ESX.GetPlayers()
    local revivedCount = 0
	--print('2')
    for _, playerId in ipairs(players) do
        local targetCoords = GetEntityCoords(GetPlayerPed(playerId))
        local distance = #(playerCoords - targetCoords)
        if distance <= radius then
            TriggerClientEvent('sunny:admin:revive', playerId)
            revivedCount = revivedCount + 1
        end
    end
	--print('3')
    if source > 0 then
		TriggerClientEvent('esx:showNotification', source, ("~g~Vous avez revive %d joueur(s) dans une zone de %d mètres"):format(revivedCount, radius))
		sendLog(('Le staff (%s - %s) a revive la zone de (%s- metres)'):format(xPlayer.name, xPlayer.UniqueID, radius), {
			author = 'revive zone',
			fields = {
				{title = 'Staff', subtitle = xPlayer.name},
				{title = 'ID Unique', subtitle = xPlayer.UniqueID},
				{title = 'Identifier', subtitle = xPlayer.identifier},
				{title = "Nombre de Persone Revive", subtitle = revivedCount},
			},
			channel = 'zonerevive'
		})
    end
end)

RegisterCommand('heal', function(source, args)
	local targetPlayer = tonumber(args[1])

	if source == 0 then
		if not targetPlayer then
			return print("Vous devez mettre un ID valide appartenant à un joueur connecté!")
		end
	else
		local xPlayer = ESX.GetPlayerFromId(source)
		if not xPlayer then return end

		local allowed = { 'fondateur', 'gerant', 'responsable', 'superadmin', 'admin', 'modo', 'helper' }
		local grp = xPlayer.getGroup()
		local isAllowed = false
		for _, g in ipairs(allowed) do
			if grp == g then
				isAllowed = true
				break
			end
		end
		if not isAllowed then
			return TriggerClientEvent('esx:showNotification', source, "Vous n'êtes pas autorisé à faire cette commande")
		end
	end

	if not targetPlayer then
		TriggerClientEvent('sunny:admin:command:heal', source)
		return TriggerClientEvent('esx:showNotification', source, "Vous vous êtes bien soigné!")
	end

	if GetPlayerPing(targetPlayer) > 0 then
		if not ESX.GetPlayerFromId(targetPlayer) then return end
	else
		local p = ReturnPlayerId(targetPlayer)
		if not p then return end
		targetPlayer = p.id
	end

	TriggerClientEvent('sunny:admin:command:heal', targetPlayer)
	TriggerClientEvent('esx:showNotification', targetPlayer, "Vous venez d'être soigné par un membre du staff!")

	if source ~= 0 then
		local xPlayer    = ESX.GetPlayerFromId(source)
		local xTarget    = ESX.GetPlayerFromId(targetPlayer)
		TriggerClientEvent('esx:showNotification', source, "Vous avez correctement soigné le joueur visé !")

		sendLog(
			('Le staff (%s - %s) a heal le joueur %s'):format(xPlayer.name, xPlayer.UniqueID, xTarget.name),
			{
				author  = 'Heal de joueur',
				fields  = {
					{ title = 'Staff',     subtitle = xPlayer.name },
					{ title = 'ID Unique', subtitle = xPlayer.UniqueID },
					{ title = 'Identifier',subtitle = xPlayer.identifier },
					{ title = '------------', subtitle = "" },
					{ title = 'Joueur',    subtitle = xTarget.name },
					{ title = 'ID Unique', subtitle = xTarget.UniqueID },
					{ title = 'Identifier',subtitle = xTarget.identifier },
				},
				channel = 'zonerevive'
			}
		)
	end
end)

RegisterCommand('healzone', function(source, args)
	if source == 0 then return print("Vous ne pouvez pas exécuter cette commande depuis la console!") end

	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then return end

	local radiusDist = tonumber(args[1])
	if radiusDist == nil then return print("Vous devez préciser un radius pour exécuter cette commande!") end
	if (radiusDist <= 0) or (radiusDist > 100) then return print("Le radius que vous essayez de transmettre est trop grand ou trop petit. Transmettez une valeur entre 1 et 100.") end

	local players = lib.getNearbyPlayers(GetEntityCoords(GetPlayerPed(source)), radiusDist)
	if players == nil then return print("ERROR: Une erreur s'est produite lors de la récupération des joueurs se trouvant à proximité!") end

	local revivedCount = 0
	for k, v in pairs(players) do
		TriggerClientEvent('sunny:admin:command:heal', v.id)
		revivedCount += 1
	end

	TriggerClientEvent('esx:showNotification', source, ("~g~Vous avez heal %d joueur(s) dans une zone de %d mètres"):format(revivedCount, radiusDist))
	sendLog(('Le staff (%s - %s) a Heal la zone de (%s- metres)'):format(xPlayer.name, xPlayer.UniqueID, radius), {
		author = 'Heal zone',
		fields = {
			{title = 'Staff', subtitle = xPlayer.name},
			{title = 'ID Unique', subtitle = xPlayer.UniqueID},
			{title = 'Identifier', subtitle = xPlayer.identifier},
			{title = "Nombre de Persone Heal", subtitle = revivedCount},
		},
		channel = 'zonerevive'
	})
end)


RegisterCommand('revive', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if source ~= 0 then
		if not Config.Staff.HavePermission('ManagePlayers', 'revive', xPlayer) then return end
	end

	-- Si "me" est passé en argument, revive le joueur qui tape la commande (pas besoin d'être en service)
	if args[1] and string.lower(args[1]) == "me" then
		TriggerClientEvent('sunny:admin:revive', source)
		return
	end

	-- Pour revive les autres, faut être en service
	if source ~= 0 then
		if not adminManagement.Service[xPlayer.UniqueID] then return end
	end

	local uniqueID = tonumber(args[1])
	if not uniqueID then
		print("ID Unique invalide pour la commande revive.")
		return
	end

	local player = ReturnPlayerId(uniqueID)
	if not player then
		print("Aucun joueur trouvé avec l'ID Unique :", args[1])
		return
	end

	if GetPlayerName(player.id) then
		TriggerClientEvent('sunny:admin:revive', player.id)
	end
end)

RegisterCommand('sc', function(source, args)
	if #args <= 0 then return end
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' then return end

	for k,v in pairs(adminManagement.Players) do
		if v.group == 'user' then goto continue end

		TriggerClientEvent('sunny:admin:sc', k, GetPlayerName(source), table.concat(args, " "))
		
		::continue::
	end
end)

RegisterCommand('goto', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if source ~= 0 then
		if not adminManagement.Service[xPlayer.UniqueID] then return end
		if xPlayer.getGroup() == 'user' then return end
	end
	if args[1] == nil then return end

	if not ReturnPlayerId(args[1]) then return end

	TriggerClientEvent('sunny:admin:teleport', source, GetEntityCoords(GetPlayerPed(ReturnPlayerId(args[1]).id)))
end)

RegisterCommand('tp', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not adminManagement.Service[xPlayer.UniqueID] then return end
	if xPlayer.getGroup() == 'user' then return end
	if args[1] == nil then return end

	if not ReturnPlayerId(args[1]) then return end

	TriggerClientEvent('sunny:admin:teleport', ReturnPlayerId(args[1]).id, GetEntityCoords(GetPlayerPed(source)))
end)

RegisterCommand('kick', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if source ~= 0 then
		if not adminManagement.Service[xPlayer.UniqueID] then return end
		if not Config.Staff.HavePermission('COMMANDS', 'KICK', xPlayer) then return end
		if xPlayer.getGroup() == 'user' then return end
	end
	if args[1] == nil then return end
	if args[2] == nil then return end

	if not ReturnPlayerId(args[1]) then return end

	DropPlayer(ReturnPlayerId(args[1]).id, 'Vous avez été déconnectez du serveur\nRaison: '..table.concat(args, ' ', 2))
	sendLog(('Le staff (%s - %s) a kick (%s- %s)'):format(xPlayer.name, xPlayer.UniqueID, args[1], args[1]), {
		author = 'kick',
		fields = {
			{title = 'Staff', subtitle = xPlayer.name},
			{title = 'ID Unique', subtitle = xPlayer.UniqueID},
			{title = 'Identifier', subtitle = xPlayer.identifier},
			{title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
		},
		channel = 'kick'
	})
end)

RegisterCommand('tppc', function(source, args)
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if not adminManagement.Service[xPlayer.UniqueID] then return end
		if xPlayer.getGroup() == "user" then return end
	end

	if args[1] == nil then return end

	local player = ReturnPlayerId(args[1])

	if not player then return end

	TriggerClientEvent('sunny:admin:teleport', player.id, vector3(231.169, -796.4821, 30.57599))
end)

RegisterNetEvent('sunny:fire:start', function(id, coords, with)
	TriggerClientEvent('events:fires:client:start', -1, id, coords, with)
end)

RegisterCommand('patchNote', function(_, args)
	local xPlayer = ESX.GetPlayerFromId(_)
	if _ ~= 0 then
		if xPlayer.getGroup() == "user" then return end
	end
	if xPlayer.getGroup() == "user" then return end
    sendLog(('Nouveau Patchnote par %s'):format('Sunny'), {
        author = 'Slide',
        fields = {
            {title = 'Update', subtitle = table.concat(args, ' ')},
        },
        channel = 'patchnote'
    }, function(data)

    end)
end)

-- Handler serveur pour /fix et /repair (staff uniquement)
RegisterNetEvent('sunny:staff:fix', function(netId)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    -- Liste des rôles autorisés pour /fix
    local allowedRoles = {
        'fondateur', 'developper', 'gerant', 'responsable',
        'superadmin', 'administrateur', 'moderateur', 'helpeur'
    }

    local playerGroup = xPlayer.getGroup()
    local isAllowed = false

    for _, role in ipairs(allowedRoles) do
        if playerGroup == role then
            isAllowed = true
            break
        end
    end

    if not isAllowed then
        return TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas la permission d\'utiliser cette commande !')
    end

    -- Vérifier que le joueur est en service staff
    if not adminManagement.Service[xPlayer.UniqueID] then
        return TriggerClientEvent('esx:showNotification', source, '~r~Vous devez être en service staff !')
    end

    TriggerClientEvent('sunny:staff:doFix', source, netId)

    -- Log de l'action
    sendLog(('Le staff (%s - %s) a utilisé /fix'):format(xPlayer.name, xPlayer.UniqueID), {
        author = 'Fix Véhicule',
        fields = {
            {title = 'Staff', subtitle = xPlayer.name},
            {title = 'ID Unique', subtitle = tostring(xPlayer.UniqueID)},
            {title = 'Identifier', subtitle = xPlayer.identifier},
        },
        channel = 'staffactions'
    })
end)