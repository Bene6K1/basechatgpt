RegisterServerEvent('esx_skin:save')
AddEventHandler('esx_skin:save', function(skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	-- Guard against nil player (e.g., invalid source or ESX not ready)
	if not xPlayer or not xPlayer.identifier then
		return
	end

	MySQL.Async.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(skin),
		['@identifier'] = xPlayer.identifier
	})
end)

ESX.RegisterServerCallback('esx_skin:getPlayerSkin', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	-- Guard against nil player (e.g., called too early or invalid source)
	if not xPlayer then
		cb(nil, nil)
		return
	end

	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		local user, skin = users and users[1] or nil

		local jobSkin = {
			skin_male = xPlayer.job and xPlayer.job.skin_male or nil,
			skin_female = xPlayer.job and xPlayer.job.skin_female or nil
		}

		if user and user.skin then
			skin = json.decode(user.skin)
		end

		cb(skin, jobSkin)
	end)
end)

RegisterCommand('skin', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if source ~= 0 then
		if xPlayer.getGroup() == 'user' then return end
	end

	local player = ReturnPlayerId(args[1])

	if not player then
		if source ~= 0 then
			TriggerClientEvent('sunny:openSkinMenu', source)
		end
	else
		TriggerClientEvent('sunny:openSkinMenu', player.id)
	end
end)

RegisterNetEvent('sunny:skin:restart', function()
	local source = source

	TriggerClientEvent('sunny:skin:restart', source)
end)