ESX = nil



TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('esx:discardInventoryItem')
AddEventHandler('esx:discardInventoryItem', function(item, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer and count > 0 then
		local currentItem = xPlayer.getInventoryItem(item)
		if currentItem and currentItem.count >= count then
			xPlayer.removeInventoryItem(item, count)
		end
	end
end)

RegisterServerEvent('esx:modelChanged')
AddEventHandler('esx:modelChanged', function(id)
	TriggerClientEvent('esx:modelChanged', id)
end)

ESX.RegisterUsableItem('pistol_ammo_box', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		xPlayer.removeInventoryItem('pistol_ammo_box', 1)
		xPlayer.addInventoryItem('pistol_ammo', 24)
	end
end)

ESX.RegisterUsableItem('smg_ammo_box', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		xPlayer.removeInventoryItem('smg_ammo_box', 1)
		xPlayer.addInventoryItem('smg_ammo', 30)
	end
end)

ESX.RegisterUsableItem('rifle_ammo_box', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		xPlayer.removeInventoryItem('rifle_ammo_box', 1)
		xPlayer.addInventoryItem('rifle_ammo', 30)
	end
end)

ESX.RegisterUsableItem('shotgun_ammo_box', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		xPlayer.removeInventoryItem('shotgun_ammo_box', 1)
		xPlayer.addInventoryItem('shotgun_ammo', 16)
	end
end)



for k, v in pairs(Config.Weapons) do
	ESX.RegisterUsableItem(v.item, function(playerId)
		TriggerClientEvent('kotonier:equipWeapon', playerId, k)
	end)

end