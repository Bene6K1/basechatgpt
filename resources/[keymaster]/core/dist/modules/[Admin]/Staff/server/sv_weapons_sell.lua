Citizen.CreateThread(function()
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS `selling_weapons` (
            name LONGTEXT DEFAULT NULL,
            label LONGTEXT DEFAULT NULL
        );
    ]])

    RegisterNetEvent('sunny:weapons:load', function()
        local source = source
        
        MySQL.Async.fetchAll('SELECT * FROM selling_weapons', {}, function(result)
            local table = {}
            for k,v in pairs(result) do
                table[v.name] = true
            end

            TriggerClientEvent('sunny:weapons:load', source, table)
        end)
    end)

    ESX.RegisterServerCallback('sunny:weapons:getSelling', function(source, cb)
        MySQL.Async.fetchAll('SELECT * FROM selling_weapons', {}, function(result)
            if not result then
                cb({})
                return
            end
            
            local tb = {}
            for k,v in pairs(result) do
                table.insert(tb, {
                    name = v.name,
                    label = v.label
                })
            end
            cb(tb)
        end)
    end)

    RegisterNetEvent('sunny:weapons:sell:add', function(data)
        local source = source
        local xPlayerB = ESX.GetPlayerFromId(source)
        if xPlayerB.getGroup() == 'user' then return end
        
        if not data or not data.name or not data.label then
            TriggerClientEvent('esx:showNotification', source, '~r~Données invalides')
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM selling_weapons WHERE name = @name', {
            ['@name'] = data.name
        }, function(result)
            if result[1] then
                TriggerClientEvent('esx:showNotification', source, '~r~Ce groupe est déjà défini comme vendeur d\'armes')
            else
                MySQL.Async.execute('INSERT INTO selling_weapons (name, label) VALUES (@name, @label)', {
                    ['@name'] = data.name,
                    ['@label'] = data.label
                }, function()
                    TriggerClientEvent('esx:showNotification', source, '~g~Groupe ajouté avec succès comme vendeur d\'armes')
                end)
            end
        end)
    end)

    RegisterNetEvent('sunny:weapons:sell:delete', function(name)
        local source = source
        local xPlayerB = ESX.GetPlayerFromId(source)
        if xPlayerB.getGroup() == 'user' then return end
        
        if not name then 
            TriggerClientEvent('esx:showNotification', source, '~r~Nom de groupe invalide')
            return 
        end

        MySQL.Async.execute('DELETE FROM selling_weapons WHERE name = @name', {
            ['@name'] = name,
        }, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('esx:showNotification', source, '~g~Groupe supprimé avec succès des vendeurs d\'armes')
            else
                TriggerClientEvent('esx:showNotification', source, '~r~Ce groupe n\'était pas vendeur d\'armes')
            end
        end)
    end)
end)