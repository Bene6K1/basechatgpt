if XMR.Framework == "qb" then
    QBCore = exports["qb-core"]:GetCoreObject()
else
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end


GetPlayer = function(playerId)
    if XMR.Framework == "qb" then
        return QBCore.Functions.GetPlayer(playerId)
    else
        return ESX.GetPlayerFromId(playerId)
    end
end


AddItem = function(player,itemName, count)
	local xPlayer = GetPlayer(player)
	if XMR.Framework == "qb" then
		return xPlayer.Functions.AddItem(itemName, count)
	else
		local ok = pcall(function() xPlayer.addInventoryItem(itemName, count) end)
		if ok then return true end
		if xPlayer.addInventoryItemPerm ~= nil then
			local ok2 = pcall(function() xPlayer.addInventoryItemPerm(itemName, count) end)
			if ok2 then return true end
		end
		return false
	end
end


Notify = function(source, text)
    if XMR.Framework == "qb" then
        return TriggerClientEvent("QBCore:Notify",source, text)
    else
        local xPlayer = GetPlayer(source)
        return xPlayer.showNotification(text)
    end
end

RemoveMoney = function(source, method, price)
    local player = GetPlayer(source)
    if XMR.Framework == "qb" then
        if player.Functions.GetMoney(method) >= price then
            player.Functions.RemoveMoney(method, price)
            return true
        else
            Notify(source, "You don't have enough money.")
        end
    else
		if method == 'cash' then
			if player.getMoney() >= price then
				player.removeMoney(price)
				return true
			else
				Notify(source, "You don't have enough money.")
			end
		else
			local account = player.getAccount(method)
			if account and account.money >= price then
				player.removeAccountMoney(method, price)
				return true
			else
				Notify(source, "You don't have enough money.")
			end
		end
    end
    return false
end


