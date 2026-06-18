banList = {}

CreateThread(function()

    MySQL.Async.fetchAll('SELECT * FROM zban', {}, function(r)
        for k,v in pairs(r) do
            banList[v.identifier] = {
                uniqueid = v.uniqueid,
                identifier = v.identifier,
                time = tonumber(v.time),
                perm = v.perm,
                reason = v.reason, 
            }
        end
    end)
end)

RegisterCommand('ban', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
    if tonumber(source) ~= 0 then
        if not Config.Staff.HavePermission('COMMANDS', 'BAN', xPlayer) then return end
    end

	if args[1] == nil then return end
	if args[2] == nil then return end
	if args[3] == nil then return end

    TriggerEvent('sunny:admin:banSystem:ban', args[1], args[2], table.concat(args, " ", 3))

    local target;
    local targetLicense;
    local retturn = false;

    if json.encode(adminManagement.Players) == '[]' then
        MySQL.Async.fetchAll('SELECT * FROM users WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = tonumber(args[1])
        }, function(r)
            if source == 0 then
                if r[1] == nil then retturn = true return print('Aucun joueur ne corréspond avec l\'UniqueID entré') end
            else
                if r[1] == nil then retturn = true return TriggerClientEvent('esx:showNotification', source, 'Aucun joueur ne corréspond avec l\'UniqueID entré') end
            end

            targetLicense = r[1].identifier
        end)
    else
        for _,p in pairs(adminManagement.Players) do
            if p.UniqueID == tonumber(args[1]) then
                target = p.id
            else
                MySQL.Async.fetchAll('SELECT * FROM users WHERE UniqueID = @UniqueID', {
                    ['@UniqueID'] = tonumber(args[1])
                }, function(r)
                    if source == 0 then
                        if r[1] == nil then retturn = true return print('Aucun joueur ne corréspond avec l\'UniqueID entré') end
                    else
                        if r[1] == nil then retturn = true return TriggerClientEvent('esx:showNotification', source, 'Aucun joueur ne corréspond avec l\'UniqueID entré') end
                    end
    
                    targetLicense = r[1].identifier
                end)
            end
        end
    end

    Wait(1000)

    if not retturn then
        local targetPlayer = ESX.GetPlayerFromId(target)

        if targetPlayer then
            if banList[targetPlayer.identifier] ~= nil then
                if tonumber(source)~= 0 then
                    return TriggerClientEvent('esx:showNotification', source, 'Le joueur est déja ban')
                else
                    return print('Le joueur est déja ban')
                end
            end
        else
            if banList[targetLicense] ~= nil then
            if tonumber(source)~= 0 then
                return TriggerClientEvent('esx:showNotification', source, 'Le joueur est déja ban')
            else
                return print('Le joueur est déja ban')
            end
        end

        end
    
        local banReason;
    
        if tonumber(args[2]) == 0 then 
            banReason = ('Vous avez été ban permanant pour'):format(args[2])
        else
            banReason = ('Vous avez été ban %s heure(s) pour'):format(args[2])
        end
    
        local player = targetPlayer ~= nil and targetPlayer.identifier or targetLicense
    
        MySQL.Async.execute('INSERT INTO zban (uniqueid, identifier, time, perm, reason) VALUE (@uniqueid, @identifier, @time, @perm, @reason)', {
            ['@uniqueid'] = args[1],
            ['@identifier'] = player,
            ['@time'] = tonumber(args[2]),
            ['@perm'] = tonumber(args[2]) == 0 and true or false,
            ['@reason'] = table.concat(args, ' ', 3)
        })
    
        banList[player] = {
            uniqueid = args[1],
            identifier = player,
            time = tonumber(args[2]),
            perm = tonumber(args[2]) == 0 and true or false,
            reason = table.concat(args, ' ', 3), 
        }

        if source ~= 0 then
            local xxxxx = ESX.GetPlayerFromId(source)
            sendLog(('Le staff (%s - %s) a ban (%s- %s) pendant (%s heures)'):format(xxxxx.name, xxxxx.UniqueID, targetPlayer.name, targetPlayer.UniqueID, args[2]), {
                author = 'Ban',
                fields = {
                    {title = 'Staff', subtitle = xxxxx.name},
                    {title = 'ID Unique', subtitle = xxxxx.UniqueID},
                    {title = 'Identifier', subtitle = xxxxx.identifier},
                    {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                },
                channel = 'ban'
            })
        end
        if targetPlayer then
            DropPlayer(targetPlayer.source, banReason..' '..table.concat(args, ' ', 3))
        end
    end
end)

RegisterNetEvent('sunny:admin:banSystem:banWithAnticheat', function(UniqueID, reason)
    local targetLicense;
    local banReason; 

    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not Config.Staff.HavePermission('COMMANDS', 'BAN', xPlayer) then return end
    UniqueID = UniqueID

    local player = ReturnPlayerId(UniqueID)

    if not player then
        player = xPlayer
    end

    if type(player) ~= "table" then
        player = xPlayer
    end

    targetLicense = player.identifier

    banReason = ('🛡️Slide Anticheat | Vous avez été bannni permanant pour'):format(reason)

    MySQL.Async.execute('INSERT INTO zban (uniqueid, identifier, time, perm, reason) VALUE (@uniqueid, @identifier, @time, @perm, @reason)', {
        ['@uniqueid'] = tonumber(UniqueID),
        ['@identifier'] = targetLicense,
        ['@time'] = 0,
        ['@perm'] = true,
        ['@reason'] = tostring(reason)
    }, function()
        DropPlayer(ReturnPlayerId(UniqueID).id, banReason..' '..reason)
    end)

    banList[targetLicense] = {
        uniqueid = UniqueID,
        identifier = identifier,
        time = tonumber(time),
        perm = true,
        reason = tostring(reason), 
    }
end)

RegisterNetEvent('sunny:admin:banSystem:ban', function(UniqueID, reason)
    if UniqueID == nil or reason == nil then return end

    local target = {}
    target[UniqueID] = {}


    local player = ReturnPlayerId(UniqueID)

    if player then
        -- DropPlayer(player.id, )
    end
end)

RegisterCommand('unban', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if tonumber(source) ~= 0 then
        if not adminManagement.Service[xPlayer.UniqueID] then return TriggerClientEvent('esx:showNotification', source, 'Vous n\'êtes pas en service') end
        if not Config.Staff.HavePermission('COMMANDS', 'UNBAN', xPlayer) then return end
    end

    if args[1] == nil then return end

    local targetLicense;

    MySQL.Async.fetchAll('SELECT * FROM users WHERE UniqueID = @UniqueID', {
        ['@UniqueID'] = tonumber(args[1])
    }, function(r)
        if r[1] == nil then
            if source == 0 then
                return print('Aucun joueur ne corréspond avec l\'UniqueID entré')
            else
                return TriggerClientEvent('esx:showNotification', source, 'Aucun joueur ne corréspond avec l\'UniqueID entré')
            end
        end

        if banList[r[1].identifier] == nil then
            if source == 0 then
                return print('Aucun joueur n\'est ban avec l\'UniqueID entré')
            else
                return TriggerClientEvent('esx:showNotification', source, 'Aucun joueur n\'est ban avec l\'UniqueID entré')
            end
        else
            MySQL.Async.execute('DELETE FROM zban WHERE uniqueid = @uniqueid', {
                ['@uniqueid'] = args[1]
            })

            banList[r[1].identifier] = nil

            if source ~= 0 then
                local xxxxx = ESX.GetPlayerFromId(source)
                sendLog(('Le staff (%s - %s) a deban (%s- %s)'):format(xxxxx.name, xxxxx.UniqueID, r[1].playerName, r[1].UniqueID), {
                    author = 'Ban',
                    fields = {
                        {title = 'Staff', subtitle = xxxxx.name},
                        {title = 'ID Unique', subtitle = xxxxx.UniqueID},
                        {title = 'Identifier', subtitle = xxxxx.identifier},
                        {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                    },
                    channel = 'ban'
                })
            end
        end
    end)
end)

local presentCard = {}

while not UTILS do Wait(1) end

presentCard.logoLink = UTILS.LOGOURL

presentCard.card = {
    ['verif'] = {
        ["type"] = "AdaptiveCard",
        ["minHeight"] = "100px",
        ["body"] = {
            {
            type = "Container",
            items = {
                {
                type = "Image",
                url = presentCard.logoLink,
                size = "medium",
                horizontalAlignment = "center",
                style = "person"
                },
                {
                type = "TextBlock",
                horizontalAlignment = "center",
                text = 'Vérification de vos informations ...'
                }
            }
            }
        },
        ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
        ["version"] = "1.2"
    },
    ['connect'] = {
        ["type"] = "AdaptiveCard",
        ["minHeight"] = "100px",
        ["body"] = {
            {
                type = "Container",
                items = {
                    {
                        type = "Image",
                        url = presentCard.logoLink,
                        size = "medium",
                        horizontalAlignment = "center",
                        style = "person"
                    },
                    {
                        type = "TextBlock",
                        horizontalAlignment = "center",
                        text = ('Bienvenue sur %s %s'):format(SunnyConfigServ.Emojie, SunnyConfigServ.ServerName)
                    },
                    {
                        type = "TextBlock",
                        horizontalAlignment = "center",
                        text = 'Vérification de vos informations ...'
                    }
                }
            },
            {
                ["type"] = "ActionSet",
                horizontalAlignment = "center",
                ["actions"] = {
                    {
                        ["type"] = "Action.OpenUrl",
                        ["title"] = "Rejoindre le Discord",
                        ["url"] = SunnyConfigServ.Discord,
                    },
                    {
                        ["type"] = "Action.OpenUrl",
                        ["title"] = "Lire le réglement",
                        ["url"] = SunnyConfigServ.Reglement,
                    }
                }
            }
        },
        ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
        ["version"] = "1.2"
    },
    ['ban'] = {}
}

AddEventHandler('playerConnecting', function(a,b,c)
    if GetPlayerName(source) == 'Antonio Ferrera' then
        c.defer()

            c.presentCard( {
                ["type"] = "AdaptiveCard",
                ["minHeight"] = "100px",
                ["body"] = {
                    {
                    type = "Container",
                    items = {
                        {
                        type = "Image",
                        url = presentCard.logoLink,
                        size = "medium",
                        horizontalAlignment = "center",
                        style = "person"
                        },
                        {
                        type = "TextBlock",
                        horizontalAlignment = "center",
                        text = ('🌴 %s\nRelancer votre client sous un nouveau nom)'):format(SunnyConfigServ.ServerName)
                        }
                    }
                    }
                },
                ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
                ["version"] = "1.2"
            })
    end
    -- ESX.toConsole(GetPlayerName(source)..' se connecte au serveur')
    local license = ''
    for fo, fp in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(fp, 1, string.len("license:")) == "license:" then
            license = fp
        end
    end

    c.defer()
    c.presentCard(presentCard.card['verif'])

    -- Utiliser CreateThread au lieu de Wait pour éviter les timeouts de ticket
    CreateThread(function()
        Wait(3000)

        if SunnyConfigServ.MaintenancePerm.Active then
            if not SunnyConfigServ.MaintenancePerm.Maintenance.Staff[license] then
                c.presentCard( {
                    ["type"] = "AdaptiveCard",
                    ["minHeight"] = "100px",
                    ["body"] = {
                        {
                        type = "Container",
                        items = {
                            {
                            type = "Image",
                            url = presentCard.logoLink,
                            size = "medium",
                            horizontalAlignment = "center",
                            style = "person"
                            },
                            {
                            type = "TextBlock",
                            horizontalAlignment = "center",
                            text = ('🌴 %s\nLe serveur est en maintenance revenez plus tard'):format(SunnyConfigServ.ServerName)
                            }
                        }
                        }
                    },
                    ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
                    ["version"] = "1.2"
                })

                return
            end
        end

        if banList[license] ~= nil then
            local reason;

            if banList[license].perm then
                reason = ('Vous êtes banni permanent de notre serveur !\n\nRaison: %s\nID Unique: %s'):format(banList[license].reason, banList[license].uniqueid)
            else
                reason = ('Vous êtes banni de notre serveur !\n\nRaison: %s\nTemps restant: %s heure(s)\nID Unique: %s'):format(banList[license].reason, banList[license].time, banList[license].uniqueid)
            end
            

            presentCard.card['ban'] = {
                ["type"] = "AdaptiveCard",
                ["minHeight"] = "100px",
                ["body"] = {
                    {
                    type = "Container",
                    items = {
                        {
                        type = "Image",
                        url = presentCard.logoLink,
                        size = "medium",
                        horizontalAlignment = "center",
                        style = "person"
                        },
                        {
                        type = "TextBlock",
                        horizontalAlignment = "center",
                        text = reason
                        }
                    }
                    }
                },
                ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
                ["version"] = "1.2"
            }
            
            c.presentCard(presentCard.card['ban'])
        else
            c.presentCard(presentCard.card['connect'])

            -- Utiliser CreateThread au lieu de Wait pour éviter les timeouts
            CreateThread(function()
                Wait(10000)
                c.done()
            end)
        end
    end)
end)

local function banPlayer(source, args)
    if source ~= 0 then
        print('Tentative non autorisée de bannir un joueur par un client.')
        return
    end


    if args[1] == nil then return end
    if args[2] == nil then return end
    if args[3] == nil then return end

    TriggerEvent('sunny:admin:banSystem:ban', args[1], args[2], table.concat(args, " ", 3))

    local target
    local targetLicense
    local retturn = false

    if json.encode(adminManagement.Players) == '[]' then
        MySQL.Async.fetchAll('SELECT * FROM users WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = tonumber(args[1])
        }, function(r)
            if source == 0 then
                if r[1] == nil then retturn = true return print('Aucun joueur ne correspond avec l\'UniqueID entré') end
            else
                if r[1] == nil then retturn = true return TriggerClientEvent('esx:showNotification', source, 'Aucun joueur ne correspond avec l\'UniqueID entré') end
            end

            targetLicense = r[1].identifier
        end)
    else
        for _, p in pairs(adminManagement.Players) do
            if p.UniqueID == tonumber(args[1]) then
                target = p.id
            else
                MySQL.Async.fetchAll('SELECT * FROM users WHERE UniqueID = @UniqueID', {
                    ['@UniqueID'] = tonumber(args[1])
                }, function(r)
                    if source == 0 then
                        if r[1] == nil then retturn = true return print('Aucun joueur ne correspond avec l\'UniqueID entré') end
                    else
                        if r[1] == nil then retturn = true return TriggerClientEvent('esx:showNotification', source, 'Aucun joueur ne correspond avec l\'UniqueID entré') end
                    end

                    targetLicense = r[1].identifier
                end)
            end
        end
    end

    Wait(1000)

    if not retturn then
        local targetPlayer = ESX.GetPlayerFromId(target)

        if targetPlayer then
            if banList[targetPlayer.identifier] ~= nil then
                if tonumber(source) ~= 0 then
                    return TriggerClientEvent('esx:showNotification', source, 'Le joueur est déjà banni')
                else
                    return print('Le joueur est déjà banni')
                end
            end
        else
            if banList[targetLicense] ~= nil then
                if tonumber(source) ~= 0 then
                    return TriggerClientEvent('esx:showNotification', source, 'Le joueur est déjà banni')
                else
                    return print('Le joueur est déjà banni')
                end
            end
        end

        local banReason

        if tonumber(args[2]) == 0 then 
            banReason = 'Vous avez été banni de façon permanente\n Raison: '
        else
            banReason = ('Vous avez été banni %s heure(s) pour'):format(args[2])
        end

        local player = targetPlayer ~= nil and targetPlayer.identifier or targetLicense

        MySQL.Async.execute('INSERT INTO zban (uniqueid, identifier, time, perm, reason) VALUE (@uniqueid, @identifier, @time, @perm, @reason)', {
            ['@uniqueid'] = args[1],
            ['@identifier'] = player,
            ['@time'] = tonumber(args[2]),
            ['@perm'] = tonumber(args[2]) == 0 and true or false,
            ['@reason'] = table.concat(args, ' ', 3)
        })

        banList[player] = {
            uniqueid = args[1],
            identifier = player,
            time = tonumber(args[2]),
            perm = tonumber(args[2]) == 0 and true or false,
            reason = table.concat(args, ' ', 3),
        }

        if source ~= 0 then
            local xxxxx = ESX.GetPlayerFromId(source)
            sendLog(('Le staff (%s - %s) a banni (%s- %s) pendant (%s heures)'):format(xxxxx.name, xxxxx.UniqueID, targetPlayer.name, targetPlayer.UniqueID, args[2]), {
                author = 'Ban',
                fields = {
                    {title = 'Staff', subtitle = xxxxx.name},
                    {title = 'ID Unique', subtitle = xxxxx.UniqueID},
                    {title = 'Identifier', subtitle = xxxxx.identifier},
                    {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                },
                channel = 'ban'
            })
        end
        if targetPlayer then
            DropPlayer(targetPlayer.source, banReason..' '..table.concat(args, ' ', 3))
        end
    end
end

RegisterNetEvent('custom:banPlayer')
AddEventHandler('custom:banPlayer', function(args)
    banPlayer(0, args)
end)

