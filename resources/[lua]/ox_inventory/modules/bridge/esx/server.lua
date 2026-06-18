local Inventory = require 'modules.inventory.server'
local Items = require 'modules.items.server'

AddEventHandler('esx:playerDropped', server.playerDropped)

AddEventHandler('esx:setJob', function(source, job, lastJob)
	local inventory = Inventory(source)
	if not inventory then return end
	inventory.player.groups[lastJob.name] = nil
	inventory.player.groups[job.name] = job.grade
end)

local ESX

SetTimeout(500, function()
    lib.checkDependency('es_extended', '1.6.0', true)

	ESX = exports.es_extended:getSharedObject()
    local customInventory = ESX.GetConfig().CustomInventory

	if customInventory ~= nil and customInventory ~= "ox" then
        error('es_extended has not been configured to enable support for ox_inventory!\nEnsure Config.CustomInventory has been set to "ox" in your es_extended resource config.')
    end

	server.UseItem = ESX.UseItem
	server.GetPlayerFromId = ESX.GetPlayerFromId

	local function setupPlayerInventoryBridge(xPlayer)
		if not xPlayer then return end
		local originalAddInventoryItem = xPlayer.addInventoryItem
		local originalRemoveInventoryItem = xPlayer.removeInventoryItem
		local originalCanCarryItem = xPlayer.canCarryItem
		local originalGetInventoryItem = xPlayer.getInventoryItem

		xPlayer.addInventoryItem = function(itemName, count, metadata, slot)
			local inv = Inventory(xPlayer.source)
			if not inv then return originalAddInventoryItem(itemName, count) end
			
			local success, response = Inventory.AddItem(inv, itemName, count, metadata, slot)
			return success
		end

		xPlayer.removeInventoryItem = function(itemName, count, metadata, slot)
			local inv = Inventory(xPlayer.source)
			if not inv then 
				return originalRemoveInventoryItem(itemName, count)
			end
			
			local success, response = Inventory.RemoveItem(inv, itemName, count, metadata, slot)
			return success
		end

		xPlayer.canCarryItem = function(itemName, count, metadata)
			local inv = Inventory(xPlayer.source)
			if not inv then 
				return originalCanCarryItem(itemName, count)
			end
			
			return Inventory.CanCarryItem(inv, itemName, count, metadata)
		end

		xPlayer.getInventoryItem = function(itemName)
			local inv = Inventory(xPlayer.source)
			if not inv then 
				return originalGetInventoryItem(itemName)
			end
			
			local itemCount = Inventory.GetItem(inv, itemName, nil, true)
			local itemData = Items(itemName)
			return {
				name = itemName,
				count = itemCount or 0,
				label = itemData and itemData.label or itemName,
				weight = itemData and itemData.weight or 0,
				usable = itemData and itemData.consume ~= nil or false,
				rare = false,
				canRemove = true
			}
		end
	end

	for playerId, player in pairs(ESX.Players) do
		server.setPlayerInventory(player, player and player.inventory)
		setupPlayerInventoryBridge(player)
	end

	local pendingPlayers = {}

	AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
		pendingPlayers[playerId] = xPlayer
		setupPlayerInventoryBridge(xPlayer)
	end)

	RegisterNetEvent('playerSpawned', function()
		local playerId = source
		local xPlayer = pendingPlayers[playerId] or ESX.GetPlayerFromId(playerId)
		
		if not xPlayer then return end

		local existingInv = Inventory(playerId)
		if existingInv then
			pendingPlayers[playerId] = nil
			return
		end

		Wait(500)

		local playerData = {
			source = playerId,
			identifier = xPlayer.identifier,
			name = xPlayer.getName(),
			sex = xPlayer.get('sex'),
			dateofbirth = xPlayer.get('dateofbirth'),
			groups = {}
		}

		if xPlayer and xPlayer.job and xPlayer.job.name then
			playerData.groups[xPlayer.job.name] = xPlayer.job.grade or 0
		end

		server.setPlayerInventory(playerData)

		Wait(500)
		local inv = Inventory(playerId)
		if inv then
			for accountName, _ in pairs(server.accounts) do
				local itemName = accountName
				local esxAccountName = accountName

				if accountName == 'money' then
					esxAccountName = 'cash'
				end

				local inventoryAmount = Inventory.GetItemCount(inv, itemName) or 0
				local esxAccount = xPlayer.getAccount(esxAccountName)

				if esxAccount then
					local esxAmount = esxAccount.money or 0

					if inventoryAmount ~= esxAmount then
						if inventoryAmount == 0 and esxAmount > 0 then
							Inventory.AddItem(inv, itemName, esxAmount)
						else
							esxAccount.money = inventoryAmount
							xPlayer.triggerEvent('esx:setAccountMoney', esxAccount)
						end
					end
				end
			end
		end

		pendingPlayers[playerId] = nil
end)

server.accounts.black_money = 0

local syncingFromInventory = {}

AddEventHandler('esx:onAddAccountMoney', function(source, account, amount)
	if syncingFromInventory[source] then return end
	
	local inv = Inventory(source)
	if not inv then return end

	local itemName = account.name
	if itemName == 'cash' then
		itemName = 'money'
	end

	if server.accounts[itemName] then
		Inventory.AddItem(inv, itemName, amount)
	end
end)

AddEventHandler('esx:onRemoveAccountMoney', function(source, account, amount)
	if syncingFromInventory[source] then return end

	local inv = Inventory(source)
	if not inv then return end

	local itemName = account.name
	if itemName == 'cash' then
		itemName = 'money'
	end

	if server.accounts[itemName] then
		Inventory.RemoveItem(inv, itemName, amount)
	end
end)

function server.setPlayerData(player)
	local groups = player.groups or {}

	if player.job and player.job.name then
		groups[player.job.name] = player.job.grade or 0
	end

	return {
		source = player.source,
		name = player.name,
		groups = groups,
		sex = player.sex or (player.variables and player.variables.sex),
		dateofbirth = player.dateofbirth or (player.variables and player.variables.dateofbirth),
	}
end

function server.syncInventory(inv)
	local accounts = Inventory.GetAccountItemCounts(inv)

    if accounts then
        local player = server.GetPlayerFromId(inv.id)
        if player and player.syncInventory then
            player.syncInventory(inv.weight, inv.maxWeight, inv.items, accounts)
        end

		if player and inv.player then
			syncingFromInventory[inv.id] = true

			for accountName, _ in pairs(server.accounts) do
				local itemName = accountName
				local esxAccountName = accountName

				if accountName == 'money' then
					esxAccountName = 'cash'
				end

				local inventoryAmount = Inventory.GetItemCount(inv, itemName) or 0

				local esxAccount = player.getAccount(esxAccountName)
				if esxAccount then
					local esxAmount = esxAccount.money or 0

					if inventoryAmount ~= esxAmount then
						esxAccount.money = inventoryAmount
						player.triggerEvent('esx:setAccountMoney', esxAccount)
					end
				end
			end

			syncingFromInventory[inv.id] = false
		end
    end
end

function server.hasLicense(inv, name)
	return MySQL.scalar.await('SELECT 1 FROM `user_licenses` WHERE `type` = ? AND `owner` = ?', { name, inv.owner })
end

function server.buyLicense(inv, license)
	if server.hasLicense(inv, license.name) then
		return false, 'already_have'
	elseif Inventory.GetItemCount(inv, 'money') < license.price then
		return false, 'can_not_afford'
	end

	Inventory.RemoveItem(inv, 'money', license.price)
	TriggerEvent('esx_license:addLicense', inv.id, license.name)

	return true, 'have_purchased'
end

function server.convertInventory(playerId, items)
	if type(items) == 'table' then
		local player = server.GetPlayerFromId(playerId)
		local returnData, totalWeight = table.create(#items, 0), 0
		local slot = 0

		local isOldFormat = false
		local hasSlotInfo = false

		for k, v in pairs(items) do
			if type(v) == 'number' then
				isOldFormat = true
				break
			elseif type(v) == 'table' and v.slot then
				hasSlotInfo = true
				break
			end
		end

		if player then
			for name in pairs(server.accounts) do
				local accountName = name
				local itemName = name

				if name == 'money' then
					accountName = 'cash'
				end

				local account = player.getAccount(accountName)

				if account then
					local esxMoney = account.money or 0

					local existingMoney = 0
					if isOldFormat then
						existingMoney = items[itemName] or 0
					else
						for _, v in pairs(items) do
							if type(v) == 'table' and v.name == itemName then
								existingMoney = v.count or 0
								break
							end
						end
					end

					if existingMoney == 0 and esxMoney > 0 then
						if isOldFormat then
							items[itemName] = esxMoney
						else
							local maxSlot = 0
							for _, v in pairs(items) do
								if type(v) == 'table' and v.slot and v.slot > maxSlot then
									maxSlot = v.slot
								end
							end
							table.insert(items, {slot = maxSlot + 1, name = itemName, count = esxMoney})
						end
					end
				end
			end
		end

		if isOldFormat then
			for name, count in pairs(items) do
				local item = Items(name)

				if item and count > 0 then
					local metadata = Items.Metadata(playerId, item, false, count)
					local weight = Inventory.SlotWeight(item, {count=count, metadata=metadata})
					totalWeight = totalWeight + weight
					slot = slot + 1
					returnData[slot] = {name = item.name, label = item.label, weight = weight, slot = slot, count = count, description = item.description, metadata = metadata, stack = item.stack, close = item.close}
				end
			end
		else
			for _, v in pairs(items) do
				if type(v) == 'table' and v.name then
					local item = Items(v.name)
					
					if item and v.count and v.count > 0 then
						local metadata = v.metadata or Items.Metadata(playerId, item, false, v.count)
						local weight = Inventory.SlotWeight(item, {count=v.count, metadata=metadata})
						totalWeight = totalWeight + weight
						local itemSlot = v.slot or (slot + 1)
						returnData[itemSlot] = {name = item.name, label = item.label, weight = weight, slot = itemSlot, count = v.count, description = item.description, metadata = metadata, stack = item.stack, close = item.close}
						if not v.slot then slot = slot + 1 end
					end
				end
			end
		end

		return returnData, totalWeight
	end
end

function server.isPlayerBoss(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	return xPlayer.job.grade_name == 'boss'
end

MySQL.ready(function()
	MySQL.insert('INSERT IGNORE INTO `licenses` (`type`, `label`) VALUES (?, ?)', { 'weapon', 'Weapon License'})
end)

function server.getAccountMoney(playerId, account)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		local acc = xPlayer.getAccount(account)

		if acc then
			return acc.money
		end
	end

	return 0
end

function server.removeAccountMoney(playerId, account, amount)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		local acc = xPlayer.getAccount(account)

		if acc and acc.money >= amount then
			xPlayer.removeAccountMoney(account, amount)
			return true
		end
	end

	return false
end

end) -- Fermeture du SetTimeout(500, function() de la ligne 15