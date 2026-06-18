CreateThread(function()
    while ESX == nil or json.encode(ESX.Groups) == '[]' do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(100)
    end

    local function GetPlayerFromUniqueId(uniqueId)
        local uidStr = tostring(uniqueId)
        for _, playerId in ipairs(ESX.GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer and xPlayer.UniqueID and tostring(xPlayer.UniqueID) == uidStr then
                return xPlayer
            end
        end
        return nil
    end

    local groups = {
        {name = 'fondateur', label = 'Fondateur'},
        {name = 'developper', label = 'Développeur'},
        {name = '_dev', label = 'Fondateur'},
        {name = 'gerant', label = 'Gérant'},
        {name = 'responsable', label = 'Responsable'},
        {name = 'superadmin', label = 'Super Administrateur'},
        {name = 'administrateur', label = 'Administrateur'},
        {name = 'moderateur', label = 'Modérateur'},
        {name = 'helpeur', label = 'Helpeur'},
        {name = 'user', label = 'Joueur'}
    }

    RegisterCommand('setgroup', function(source, args, rawCommand)
        if source ~= 0 then
            return
        end

        local uniqueId = tonumber(args[1])
        local group = args[2] and string.lower(args[2]) or nil

        if not uniqueId then
            print("^2╔══════════════════════════════════════╗^7")
            print("^2║    SETGROUP PAR UNIQUEID (CONSOLE)   ║^7")
            print("^2╠══════════════════════════════════════╣^7")
            print("^2║^7  ^3USAGE:^7 setgroup [UniqueID] [groupe]  ^2║^7")
            print("^2╠══════════════════════════════════════╣^7")
            print("^2║         GROUPES DISPONIBLES          ║^7")
            print("^2╠══════════════════════════════════════╣^7")
            for i, g in ipairs(groups) do
                local spacing = string.rep(" ", 18 - #g.name - #g.label)
                print("^2║^7  ^3" .. i .. "^7. ^5" .. g.name .. "^7" .. spacing .. "(" .. g.label .. ")  ^2║^7")
            end
            print("^2╚══════════════════════════════════════╝^7")
            return
        end

        if not group then
            print("^3[ERREUR]^7 Vous devez spécifier un groupe")
            print("^3[USAGE]^7 setgroup [UniqueID] [groupe]")
            local names = {}
            for _, g in ipairs(groups) do table.insert(names, g.name) end
            print("^2[GROUPES]^7 " .. table.concat(names, ", "))
            return
        end

        if not ESX.Groups[group] then
            print("^1[ERREUR]^7 Groupe invalide: " .. group)
            local names = {}
            for _, g in ipairs(groups) do table.insert(names, g.name) end
            print("^2[GROUPES VALIDES]^7 " .. table.concat(names, ", "))
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM users WHERE UniqueID = @UniqueID', {
            ['@UniqueID'] = uniqueId
        }, function(result)
            if not result or not result[1] then
                print("^1[ERREUR]^7 Aucun joueur trouvé avec l'UniqueID: " .. uniqueId)
                return
            end

            local playerData = result[1]
            local playerName = playerData.playerName or playerData.name or "Inconnu"

            MySQL.Async.execute('UPDATE users SET permission_group = @permission_group WHERE UniqueID = @UniqueID', {
                ['@UniqueID'] = uniqueId,
                ['@permission_group'] = group
            }, function(rowsChanged)
                if rowsChanged > 0 then
                    print("^2[SUCCESS]^7 Groupe mis à jour dans la base de données")
                    print("^2[INFO]^7 Joueur: " .. playerName .. " (UniqueID: " .. uniqueId .. ")")
                    print("^2[INFO]^7 Nouveau groupe: " .. group)

                    local xPlayer = GetPlayerFromUniqueId(uniqueId)
                    if xPlayer then
                        xPlayer.setGroup(group)
                        print("^2[INFO]^7 Groupe mis à jour en mémoire pour le joueur connecté")
                        print("^2[INFO]^7 Le joueur devra se reconnecter pour que les changements prennent effet complètement")
                    else
                        print("^2[INFO]^7 Le joueur n'est pas connecté. Le groupe sera appliqué à sa prochaine connexion")
                    end
                else
                    print("^1[ERREUR]^7 Échec de la mise à jour dans la base de données")
                end
            end)
        end)
    end, false)
end)
