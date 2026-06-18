ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterCommand(config.Commandename, function(source, args, rawCommand)
	local targetID = tonumber(args[1])
	local itemtogive = args[2]
	local count = tonumber(args[3])

	if not tonumber(targetID) then print("La commande est : /"..config.Commandename.." [ID Target] [ITEM] [NOMBRE]")
		return
	end
	if not tonumber(count) then print("La commande est : /"..config.Commandename.." [ID Target] [ITEM] [NOMBRE]")
		return
	end

	local target = ESX.GetPlayerFromUniqueID(targetID)

	if not target then
		print("Target Invalid")
		if source > 0 then
			local xPlayer = ESX.GetPlayerFromId(source)
			xPlayer.showNotification("Target Invalide")
		end
		return
	end


    if source > 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		local pGroup = xPlayer.group
		if pGroup == config.Grademin then 
			Givearmeperm(target, itemtogive, count)
		end
    else
        Givearmeperm(target, itemtogive, count)
    end
end, true )


RegisterCommand(config.CommandeRemove, function(source, args, rawCommand)
	local targetID = tonumber(args[1])
	local itemtogive = args[2]
	local count = tonumber(args[3])

	if not tonumber(targetID) then print("La commande est : /"..config.CommandeRemove.." [ID Target] [ITEM] [NOMBRE]")
		return
	end
	if not tonumber(count) then print("La commande est : /"..config.CommandeRemove.." [ID Target] [ITEM] [NOMBRE]")
		return
	end

	local target = ESX.GetPlayerFromUniqueID(targetID)

	if not target then
		print("Target Invalid")
		if source > 0 then
			local xPlayer = ESX.GetPlayerFromId(source)
			xPlayer.showNotification("Target Invalide")
		end
		return
	end

    if source > 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		local pGroup = xPlayer.group
		if pGroup == config.Grademin then 
			Removearmeperm(target, itemtogive, count)
		end
    else
        Removearmeperm(target, itemtogive, count)
    end
end, true )

function Givearmeperm(player, item, count)
	player.addInventoryItemPerm(item, count)
end

function Removearmeperm(player, item, count)
	player.removeInventoryItemPerm(item, count)
end

function GetItemPermFromConfig()
	return config.Perm
end

exports("GetItemPermFromConfig", GetItemPermFromConfig)