VIP = {
    players = {},
    data = {}
}

function VIP.haveVip(UniqueID)
    if VIP.data[UniqueID] then
        return VIP.data[UniqueID].have
    else
        return false
    end
end

exports('haveVip', function(UniqueID)
    return VIP.haveVip(UniqueID)
end)


Citizen.CreateThread(function()
    MySQL.Async.fetchAll('SELECT * FROM vips', {}, function(result)
        for k,v in pairs(result) do
            VIP.players[v.UniqueID] = {
                UniqueID = v.UniqueID,
                have = true,
                time = v.time,
                money = v.money
            }
        end

        -- while true do
        --     Wait(3600000)
        --     for k,v in pairs(VIP.players) do

        --         if v.time > 1 then
        --             VIP.players[k].time -= 1

        --             MySQL.Async.execute('UPDATE vips SET time = @time WHERE UniqueID = @UniqueID', {
        --                 ['@UniqueID'] = VIP.players[k].UniqueID,
        --                 ['@time'] = VIP.players[k].time
        --             }, function()
                        
        --             end)
        --         else
        --             MySQL.Async.execute('DELETE FROM vips WHERE UniqueID = @UniqueID', {
        --                 ['@UniqueID'] = v.UniqueID
        --             }, function()
        --                 VIP.players[k] = nil
        --             end)
        --         end

        --         local player = ReturnPlayerId(VIP.players[k].UniqueID)

        --         if player then
        --             if VIP.players[k] then
        --                 VIP.data[player.UniqueID] = VIP.players[k]
        --                 TriggerClientEvent('sunny:vip:refreshData', player.id, VIP.data[player.UniqueID])
        --             else
        --                 VIP.data[xPlayer.UniqueID] ={
        --                     UniqueID = xPlayer.UniqueID,
        --                     have = false,
        --                     time = 0,
        --                 }
        --                 TriggerClientEvent('esx:showNotification', player.id, 'Information VIP\n\nVotre ~p~VIP~s~ vien de prendre fin')
        --             end
        --         end
        --     end
        -- end
    end)

    CreateThread(function()
        while true do
            Wait(1800000)

            for k,v in pairs(VIP.players) do
                local player = {}
                player[k] = ReturnPlayerId(v.UniqueID)

                if player[k] then
                    local xPlayer = ESX.GetPlayerFromId(player[k].id)

                    if xPlayer then
                        xPlayer.addAccountMoney('bank', 1500)

                        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Information VIP\n\nVous avez reçus ~p~1 500$~s~ sur votre compte en banque')
                    end
                end
            end
        end
    end)
end)

AddEventHandler('esx:playerLoaded', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not VIP.players[xPlayer.UniqueID] then
        VIP.data[xPlayer.UniqueID] = {
            UniqueID = xPlayer.UniqueID,
            have = false,
            time = 0,
            money = false,
        }
    else
        VIP.data[xPlayer.UniqueID] = VIP.players[xPlayer.UniqueID]
        TriggerClientEvent('sunny:vip:refreshData', source, VIP.data[xPlayer.UniqueID])
    end
end)

AddEventHandler('sunny:admin:restart', function()
    local source = source

    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    if not VIP.players[xPlayer.UniqueID] then
        VIP.data[xPlayer.UniqueID] = {
            UniqueID = xPlayer.UniqueID,
            have = false,
            time = 0,
            money = false,
        }
    else
        VIP.data[xPlayer.UniqueID] = VIP.players[xPlayer.UniqueID]
        TriggerClientEvent('sunny:vip:refreshData', source, VIP.data[xPlayer.UniqueID])
    end
end)

RegisterServerEvent('sunny:vip:animals:saveName')
AddEventHandler('sunny:vip:animals:saveName', function(animalName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    -- Vérifier que le prénom est bien reçu
    if not animalName or animalName == "" then
        TriggerClientEvent('esx:showNotification', source, "❌ Erreur: prénom invalide.")
        return
    end

    -- Enregistrer le prénom dans la base de données
    MySQL.Async.execute("INSERT INTO animals_perm (prenom, owner_identifier) VALUES (@prenom, @owner)",
    {
        ['@prenom'] = animalName,
        ['@owner'] = identifier
    }, function(rowsChanged)
        if rowsChanged > 0 then
            print("DEBUG: Prénom sauvegardé en base -> " .. animalName)
        else
            TriggerClientEvent('esx:showNotification', source, "❌ Erreur lors de la sauvegarde du prénom.")
        end
    end)
end)

local playerAnimalCache = {} -- Stocke si un joueur a déjà un animal

ESX.RegisterServerCallback('sunny:vip:animals:hasAnimal', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    -- Vérifier si on a déjà stocké l'info pour ce joueur
    if playerAnimalCache[identifier] ~= nil then
        cb(playerAnimalCache[identifier])
        return
    end

    -- Requête SQL uniquement si on ne connaît pas encore l'état du joueur
    MySQL.Async.fetchScalar("SELECT COUNT(*) FROM animals_perm WHERE owner_identifier = @owner", {
        ['@owner'] = identifier
    }, function(count)
        local hasAnimal = count and count > 0

        -- Stocker le résultat en cache pour éviter de spammer les logs
        playerAnimalCache[identifier] = hasAnimal

        -- Afficher le print une seule fois par session
        if hasAnimal then
            print("DEBUG SERVEUR: Joueur " .. identifier .. " possède déjà un animal.")
        else
            print("DEBUG SERVEUR: Joueur " .. identifier .. " n'a pas encore d'animal.")
        end

        cb(hasAnimal)
    end)
end)



RegisterServerEvent('sunny:vip:animals:updateModel')
AddEventHandler('sunny:vip:animals:updateModel', function(animalModel)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    -- Vérifier que les données sont bien reçues
    if not animalModel then
        print("DEBUG SERVEUR: Erreur - modèle non reçu !")
        TriggerClientEvent('esx:showNotification', source, "❌ Erreur: modèle invalide.")
        return
    end

    print("DEBUG SERVEUR: Mise à jour du modèle pour le joueur " .. identifier .. " avec le modèle: " .. animalModel)

    -- Mise à jour du modèle dans la base de données
    MySQL.Async.execute("UPDATE animals_perm SET model = @model WHERE owner_identifier = @owner AND model IS NULL",
    {
        ['@model'] = animalModel,
        ['@owner'] = identifier
    }, function(rowsChanged)
        if rowsChanged > 0 then
            print("DEBUG SERVEUR: Modèle mis à jour -> " .. animalModel .. " pour le joueur " .. identifier)
        else
            print("DEBUG SERVEUR: Aucun animal trouvé pour mise à jour pour le joueur " .. identifier)
            TriggerClientEvent('esx:showNotification', source, "❌ Erreur: Aucun animal trouvé pour mise à jour.")
        end
    end)
end)

ESX.RegisterServerCallback('sunny:vip:animals:getAnimalData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    MySQL.Async.fetchAll("SELECT prenom, model FROM animals_perm WHERE owner_identifier = @owner LIMIT 1", {
        ['@owner'] = identifier
    }, function(result)
        if result and #result > 0 then
            local prenom = result[1].prenom or "Inconnu"
            local model = result[1].model or "Non défini"
            print("DEBUG SERVEUR: Prénom -> " .. prenom .. " | Modèle -> " .. model)
            cb(prenom, model)
        else
            print("DEBUG SERVEUR: Aucun animal trouvé pour " .. identifier)
            cb("Inconnu", "Non défini") -- Valeur par défaut
        end
    end)
end)






-- Gestion sécurisée des personnalisations d'armes VIP (tints/components)
RegisterNetEvent('sunny:vip:applyTint')
AddEventHandler('sunny:vip:applyTint', function(tintId)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local uniqueID = xPlayer.UniqueID
    if not (exports['core']:haveVip(uniqueID)) then return end
    if Config and Config.VIP and Config.VIP.IsFeatureEnabled and not Config.VIP.IsFeatureEnabled('TeintesArmes') then return end
    if type(tintId) ~= 'number' then return end
    TriggerClientEvent('sunny:vip:client:applyTint', src, tintId)
end)

RegisterNetEvent('sunny:vip:applyComponent')
AddEventHandler('sunny:vip:applyComponent', function(weaponName, component)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local uniqueID = xPlayer.UniqueID
    if not (exports['core']:haveVip(uniqueID)) then return end
    if Config and Config.VIP and Config.VIP.IsFeatureEnabled and not Config.VIP.IsFeatureEnabled('CustomArmes') then return end
    if type(weaponName) ~= 'string' or type(component) ~= 'string' then return end
    TriggerClientEvent('sunny:vip:client:applyComponent', src, weaponName, component)
end)

-- Mode Drift VIP (toggle avec validation serveur)
local vipDriftEnabled = {}

RegisterNetEvent('sunny:vip:toggleDrift')
AddEventHandler('sunny:vip:toggleDrift', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local uniqueID = xPlayer.UniqueID
    if not (exports['core']:haveVip(uniqueID)) then return end
    if Config and Config.VIP and Config.VIP.IsFeatureEnabled and not Config.VIP.IsFeatureEnabled('ModeDrift') then return end
    if Config and Config.VIP and Config.VIP.Restrictions and Config.VIP.Restrictions.BlacklistedJobs then
        for _, jobName in ipairs(Config.VIP.Restrictions.BlacklistedJobs) do
            if xPlayer.job and xPlayer.job.name == jobName then return end
        end
    end
    vipDriftEnabled[src] = not vipDriftEnabled[src]
    TriggerClientEvent('sunny:vip:client:toggleDrift', src, vipDriftEnabled[src] == true)
end)
RegisterNetEvent('sunny:vip:recieveMoney')
AddEventHandler('sunny:vip:recieveMoney', function()
    local src = source  
    if not src then
        --print("Erreur : Source est nil.")
        return
    end

    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer then
		local uniqueID = xPlayer.UniqueID  
		if exports['core']:haveVip(uniqueID) then
			if Config and Config.VIP and Config.VIP.IsFeatureEnabled and not Config.VIP.IsFeatureEnabled('RecupererArgent') then
				TriggerClientEvent('esx:showNotification', src, "Cette fonctionnalité VIP est désactivée.")
				return
			end
            -- Atomic UPDATE to prevent race condition (double-claim exploit)
            MySQL.Async.execute('UPDATE vips SET money = 1 WHERE UniqueID = @UniqueID AND (money IS NULL OR money != 1)', {
                ['@UniqueID'] = uniqueID
            }, function(affectedRows)
                if affectedRows == 0 then
                    TriggerClientEvent('esx:showNotification', src, 'Vous avez déjà récupéré votre argent VIP.')
                else
                    VIP.players[uniqueID].money = 1
                    VIP.data[uniqueID] = VIP.players[uniqueID]
                    TriggerClientEvent('sunny:vip:refreshData', src, VIP.data[uniqueID])
                    local rewardMoney = (Config and Config.VIP and Config.VIP.GetValue and Config.VIP.GetValue('Rewards','Money')) or 100000
                    xPlayer.addAccountMoney('cash', rewardMoney)
                    TriggerClientEvent('esx:showNotification', src, 'Vous venez de récupérer ~g~100.000$')
                end
            end)
        else
            TriggerClientEvent('esx:showNotification', src, "Vous n'avez pas le VIP")
        end
    else
        --print("Joueur non trouvé pour l'ID source: " .. tostring(src))
    end
end)


RegisterNetEvent('sunny:vip:recieveArme')
AddEventHandler('sunny:vip:recieveArme', function()
    local src = source  
    if not src then
        return
    end

    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer then
        local uniqueID = xPlayer.UniqueID  
		if exports['core']:haveVip(uniqueID) then
			if Config and Config.VIP and Config.VIP.IsFeatureEnabled and not Config.VIP.IsFeatureEnabled('RecupererArme') then
				TriggerClientEvent('esx:showNotification', src, "Cette fonctionnalité VIP est désactivée.")
				return
			end
			if Config and Config.VIP and Config.VIP.Restrictions and Config.VIP.Restrictions.BlacklistedJobs then
				for _, jobName in ipairs(Config.VIP.Restrictions.BlacklistedJobs) do
					if xPlayer.job and xPlayer.job.name == jobName then
						TriggerClientEvent('esx:showNotification', src, "Action non autorisée pour votre métier.")
						return
					end
				end
			end
            -- Atomic UPDATE to prevent race condition (double-claim exploit)
            MySQL.Async.execute('UPDATE vips SET arme = "ok" WHERE UniqueID = @UniqueID AND (arme IS NULL OR arme != "ok")', {
                ['@UniqueID'] = uniqueID
            }, function(affectedRows)
                if affectedRows == 0 then
                    TriggerClientEvent('esx:showNotification', src, 'Vous avez déjà récupéré votre arme VIP.')
                else
                    local weaponName = (Config and Config.VIP and Config.VIP.GetValue and Config.VIP.GetValue('Rewards','WeaponName')) or 'PISTOL'
                    local weaponAmmo = (Config and Config.VIP and Config.VIP.GetValue and Config.VIP.GetValue('Rewards','WeaponAmmo')) or 100
                    if type(weaponAmmo) ~= 'number' then weaponAmmo = 100 end
                    local weaponItemName = string.lower(weaponName)
                    if not exports.ox_inventory:CanCarryItem(src, weaponItemName, 1) then
                        -- Rollback: reset arme status since we can't give the weapon
                        MySQL.Async.execute('UPDATE vips SET arme = NULL WHERE UniqueID = @UniqueID', {
                            ['@UniqueID'] = uniqueID
                        })
                        TriggerClientEvent('esx:showNotification', src, "Inventaire plein, impossible de recevoir l'arme VIP.")
                        return
                    end

                    local added = exports.ox_inventory:AddItem(src, weaponItemName, 1, {
                        ammo = weaponAmmo,
                        durability = 100
                    })

                    if not added then
                        -- Rollback: reset arme status since AddItem failed
                        MySQL.Async.execute('UPDATE vips SET arme = NULL WHERE UniqueID = @UniqueID', {
                            ['@UniqueID'] = uniqueID
                        })
                        TriggerClientEvent('esx:showNotification', src, "Erreur lors de l'ajout de l'arme VIP.")
                        return
                    end

                    TriggerClientEvent('sunny:vip:refreshData', src, VIP.data[uniqueID])

                    TriggerClientEvent('esx:showNotification', src, 'Vous venez de recevoir votre ~g~Pistolet VIP~s~.')
                end
            end)
        else
            TriggerClientEvent('esx:showNotification', src, "Vous n'avez pas le VIP")
        end
    end
end)



RegisterCommand('addVip', function(source, args)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if source ~= 0 then
        if not Config.Staff.HavePermission('VIP', 'ADD', xPlayer) then return end
    end

    args[1] = tonumber(args[1])
    args[2] = tonumber(args[2])

    if args[1] == nil then return end
    if args[2] == nil then return end

    if not VIP.players[args[1]] then 
        VIP.players[args[1]] = {
            UniqueID = args[1],
            have = true,
            time = args[2]
        }

        MySQL.Async.execute('INSERT INTO vips (UniqueID, time, money) VALUES (@UniqueID, @time, @money)', {
            ['@UniqueID'] = args[1],
            ['@time'] = args[2],
            ['@money'] = false
        }, function()
            sendLog(('Ajout VIP (ID - %s) (%s heures)'):format(args[1], args[2]), {
                author = xPlayer.name,
                fields = {
                    {title = 'ID Unique', subtitle = args[1]},
                    {title = 'Temps VIP', subtitle = args[2]},
                },
                channel = 'vip_management'
            })
        end)

        local player = ReturnPlayerId(args[1])

        if player then
            VIP.data[player.UniqueID] = VIP.players[args[1]]
            TriggerClientEvent('sunny:vip:refreshData', player.id, VIP.data[player.UniqueID])
        end
    else
        if source ~= 0 then
            return TriggerClientEvent('esx:showNotification', source, 'Le joueur possède déjà le '..SunnyConfigServ.GTACOLOR..'VIP~s~')
        else
            return print('Le joueur possède déjà le VIP')
        end
    end
end)


RegisterNetEvent('sunny:vip:buy')
AddEventHandler('sunny:vip:buy', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    local vipCost = 1250
    local vipDuration = 720 

    local player = PlayersList:GetPlayerById(source)

    if player:getCoins() < vipCost then
        TriggerClientEvent('esx:showNotification', source, "~r~Vous ne possédez pas les points requis~s~")
        return
    end

    if not VIP.players[xPlayer.UniqueID] then
        VIP.players[xPlayer.UniqueID] = {
            UniqueID = xPlayer.UniqueID,
            have = true,
            time = vipDuration 
        }

        MySQL.Async.execute('INSERT INTO vips (UniqueID, time, money) VALUES (@UniqueID, @time, @money)', {
            ['@UniqueID'] = xPlayer.UniqueID,
            ['@time'] = vipDuration,
            ['@money'] = false
        }, function()
            local player = ReturnPlayerId(xPlayer.UniqueID)
            if player then
                VIP.data[player.UniqueID] = VIP.players[xPlayer.UniqueID]
                TriggerClientEvent('sunny:vip:refreshData', player.id, VIP.data[player.UniqueID])
            end
        end)

        player:removeCoins(vipCost)
        player:addUsedCoins(vipCost)

        MySQL.Async.execute('INSERT INTO boutique_history (uniqueid, data) VALUE (@uniqueid, @data)', {
            ['@uniqueid'] = xPlayer.UniqueID,
            ['@data'] = ('Vous avez acheté VIP 1 mois pour %s coins'):format(vipCost)
        }, function()
            TriggerClientEvent('boutique:update', xPlayer.source, player:getCoins(), player:getUsedCoins(), player:getRecompense())
            TriggerClientEvent('esx:showNotification', source, 'Vous avez acheté ~g~VIP 1 mois~s~ pour ' .. vipCost .. ' coins.')
        end)

    else
        TriggerClientEvent('esx:showNotification', source, 'Vous possédez déjà le ~g~VIP~s~.')
    end
end)

RegisterNetEvent('sunny:vip:renew')
AddEventHandler('sunny:vip:renew', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    local vipCost = 1250
    local vipDuration = 720 

    local player = PlayersList:GetPlayerById(source)

    if player:getCoins() < vipCost then
        TriggerClientEvent('esx:showNotification', source, "~r~Vous ne possédez pas les points requis~s~")
        return
    end

    MySQL.Async.fetchAll('SELECT * FROM vips WHERE UniqueID = @UniqueID', {
        ['@UniqueID'] = xPlayer.UniqueID
    }, function(result)
        if #result > 0 then
            local newTime = result[1].time + vipDuration
            MySQL.Async.execute('UPDATE vips SET time = @time WHERE UniqueID = @UniqueID', {
                ['@UniqueID'] = xPlayer.UniqueID,
                ['@time'] = newTime
            }, function()
                if VIP.players[xPlayer.UniqueID] then
                    VIP.players[xPlayer.UniqueID].time = newTime
                else
                    VIP.players[xPlayer.UniqueID] = {
                        UniqueID = xPlayer.UniqueID,
                        have = true,
                        time = newTime
                    }
                end

                VIP.data[xPlayer.UniqueID] = VIP.players[xPlayer.UniqueID]
                TriggerClientEvent('sunny:vip:refreshData', source, VIP.data[xPlayer.UniqueID])

                player:removeCoins(vipCost)
                player:addUsedCoins(vipCost)

                MySQL.Async.execute('INSERT INTO boutique_history (uniqueid, data) VALUE (@uniqueid, @data)', {
                    ['@uniqueid'] = xPlayer.UniqueID,
                    ['@data'] = ('Vous avez renouvelé VIP pour 1 mois pour %s coins'):format(vipCost)
                }, function()
                    TriggerClientEvent('boutique:update', xPlayer.source, player:getCoins(), player:getUsedCoins(), player:getRecompense())
                    TriggerClientEvent('esx:showNotification', source, 'Vous avez renouvelé ~g~VIP 1 mois~s~ pour ' .. vipCost .. ' coins.')
                end)
            end)
        else
            TriggerClientEvent('esx:showNotification', source, 'Vous ne possédez pas encore le ~g~VIP~s~. Achetez-le d\'abord.')
        end
    end)
end)


RegisterCommand('removeVIP', function(source, args)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if source ~= 0 then
        if not Config.Staff.HavePermission('VIP', 'REMOVE', xPlayer) then return end
    end

    args[1] = tonumber(args[1])

    if args[1] == nil then return end

    if not VIP.players[args[1]] then return end

    VIP.players[args[1]] = nil

    MySQL.Async.execute('DELETE FROM vips WHERE UniqueID = @UniqueID', {
        ['@UniqueID'] = args[1]
    }, function()
        local player = ReturnPlayerId(args[1])

        if player then
            VIP.data[player.UniqueID] = {
                UniqueID = args[1],
                have = false,
                time = 0
            }

            TriggerClientEvent('sunny:vip:refreshData', player.id, VIP.data[player.UniqueID])

            TriggerClientEvent('esx:showNotification', player.id, 'Information VIP\n\nVotre '..SunnyConfigServ.GTACOLOR..'VIP~s~ vient de prendre fin')

            sendLog(('Suppression VIP (%s)'):format(args[1]), {
                author = xPlayer.name,
                fields = {
                    {title = 'ID Unique', subtitle = args[1]},
                    {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                },
                channel = 'vip_management'
            })
        end
    end)
end)

RegisterCommand('addVipTime', function(source, args)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if source ~= 0 then
        if not Config.Staff.HavePermission('VIP', 'ADD', xPlayer) then return end
    end

    args[1] = tonumber(args[1])
    args[2] = tonumber(args[2])

    if args[1] == nil then return end
    if args[2] == nil then return end

    if not VIP.players[args[1]] then return end

    MySQL.Async.execute('UPDATE vips SET time = @time WHERE UniqueID = @UniqueID', {
        ['@UniqueID'] = args[1],
        ['@time'] = VIP.players[args[1]].time + args[2]
    }, function()
        VIP.players[args[1]].time += args[2]

        local player = ReturnPlayerId(args[1])

        if player then
            TriggerClientEvent('sunny:vip:refreshData', player.id, VIP.data[player.UniqueID])
        end
    end)
end)

RegisterNetEvent('sunny:vip:animals:setName', function(entityID, name)
    TriggerClientEvent('sunny:animals:setName', -1, entityID, name)
end)

RegisterNetEvent('sunny:vip:animals:editName', function(entityID, newName)
    TriggerClientEvent('sunny:vip:animals:editName', -1, entityID, newName)
end)

RegisterNetEvent('sunny:vip:animals:removeName', function(entityID)
    TriggerClientEvent('sunny:vip:animals:removeName', -1, entityID)
end)

RegisterNetEvent('sunny:entits:setCoords', function(ped, coords)
    TriggerClientEvent('sunny:en:sertcoords', -1, ped, coords)
end)

RegisterNetEvent('sunny:ips:animals:createPed', function(coords, entityName)
    local source = source

    TriggerClientEvent('sunny:vip:animals:sort', source, coords, entityName)
end)