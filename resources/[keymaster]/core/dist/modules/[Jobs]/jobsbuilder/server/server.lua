RegisterServerEvent('Zigi:CreateFarmEntreprise')
AddEventHandler('Zigi:CreateFarmEntreprise', function(namejob, labeljob, namerecolteitem, labelrecolteitem, PositionRecolte, nametraitementitem, labeltraitementitem, PositionTraitement, PositionVente, PositionCoffreEntreprise)
    local _source = source
    
    if not namejob or not labeljob or not namerecolteitem or not labelrecolteitem or not PositionRecolte or not nametraitementitem or not labeltraitementitem or not PositionTraitement or not PositionVente or not PositionCoffreEntreprise then
        TriggerClientEvent('esx:showNotification', _source, '~r~Erreur : Tous les champs doivent être remplis !')
        return
    end
    
    MySQL.Async.execute("INSERT INTO `jobs` (`name`, `label`) VALUES (@name, @label)", {
        ['@name'] = namejob,
        ['@label'] = labeljob
    }, function()
        MySQL.Async.execute("INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES (@job_name, @grade, @name, @label, @salary)", {
            ['@job_name'] = namejob,
            ['@grade'] = 0,
            ['@name'] = 'recrue',
            ['@label'] = 'Recrue',
            ['@salary'] = 20
        })
        MySQL.Async.execute("INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES (@job_name, @grade, @name, @label, @salary)", {
            ['@job_name'] = namejob,
            ['@grade'] = 1,
            ['@name'] = 'employe',
            ['@label'] = 'Employé',
            ['@salary'] = 40
        })
        MySQL.Async.execute("INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES (@job_name, @grade, @name, @label, @salary)", {
            ['@job_name'] = namejob,
            ['@grade'] = 2,
            ['@name'] = 'boss',
            ['@label'] = 'Patron',
            ['@salary'] = 80
        })

        MySQL.Async.execute("INSERT INTO `player_entreprise` (`type`, `name`, `label`, `PosVestiaire`, `PosCustom`, `PosBoss`, `namerecolteitem`, `PosRecolte`, `nametraitementitem`, `PosTraitement`, `PosVente`) VALUES (@type, @name, @label, @PosVestiaire, @PosCustom, @PosBoss, @namerecolteitem, @PosRecolte, @nametraitementitem, @PosTraitement, @PosVente) ", {
            ['@type'] = 'Farm',
            ['@name'] = namejob,
            ['@label'] = labeljob,
            ['@PosVestiaire'] = nil,
            ['@PosCustom'] = nil,
            ['@PosBoss'] = json.encode(PositionCoffreEntreprise),
            ['@namerecolteitem'] = namerecolteitem,
            ['@PosRecolte'] = json.encode(PositionRecolte),
            ['@nametraitementitem'] = nametraitementitem,
            ['@PosTraitement'] = json.encode(PositionTraitement),
            ['@PosVente'] = json.encode(PositionVente)
        })

        MySQL.Async.execute("INSERT INTO `items` (`name`, `label`) VALUES (@name, @label) ", {
            ['@name'] = namerecolteitem,
            ['@label'] = labelrecolteitem
        })
        MySQL.Async.execute("INSERT INTO `items` (`name`, `label`) VALUES (@name, @label) ", {
            ['@name'] = nametraitementitem,
            ['@label'] = labeltraitementitem
        })

        MySQL.Async.execute('INSERT INTO society_data (name, label, posCoffre, posBoss, permissions, blips, cloakroom, clothes, cloakpos) VALUES (@name, @label, @posCoffre, @posBoss, @permissions, @blips, @cloakroom, @clothes, @cloakpos)', {
            ['@name'] = namejob,
            ['@label'] = labeljob,
            ['@posCoffre'] = json.encode({x = 0, y = 0, z = 0}),
            ['@posBoss'] = json.encode(PositionCoffreEntreprise),
            ['@permissions'] = json.encode({}),
            ['@blips'] = json.encode({sprite = 0, color = 0, position = {x = 0, y = 0, z = 0}, active = false}),
            ['@cloakroom'] = false,
            ['@clothes'] = json.encode({}),
            ['@cloakpos'] = json.encode('none')
        }, function()
            if Society and Society.List then
                Society.List[namejob] = {
                    name = namejob,
                    label = labeljob,
                    permissions = {},
                    posCoffre = {x = 0, y = 0, z = 0},
                    posBoss = PositionCoffreEntreprise,
                    cloakroom = false,
                    clothes = {},
                    cloakpos = 'none',
                    grades = {},
                    state = false,
                    coffre = {
                        ['items'] = {},
                        ['weapons'] = {},
                        ['items_boss'] = {},
                        ['weapons_boss'] = {},
                        ['accounts'] = {
                            society = 0,
                            cash = 0,
                            black_money = 0
                        },
                        blips = {
                            sprite = 0,
                            color = 0,
                            position = {x = 0, y = 0, z = 0},
                            active = false
                        }
                    }
                }

                TriggerClientEvent('sunny:society:add', -1, namejob, Society.List[namejob])
            end

            TriggerEvent('esx:getAllJobs')
            
            TriggerClientEvent('esx:showNotification', _source, '✅ Le Job ~g~'..labeljob..'~s~ a été créé avec succès !')
            TriggerEvent('sunny:RefreshFarmSociety')
        end)
    end)
end)

local EntrepriseFarmList = {}
local ListeItemRecolt = {}
local ListeItemTraitement = {}

Citizen.CreateThread(function()
    Wait(1500)
    MySQL.Async.fetchAll('SELECT * FROM player_entreprise', {}, function(Entreprise)
        for i=1, #Entreprise, 1 do
            EntrepriseFarmList[Entreprise[i].name] = {}
            EntrepriseFarmList[Entreprise[i].name].type = Entreprise[i].type 
            EntrepriseFarmList[Entreprise[i].name].name = Entreprise[i].name
            EntrepriseFarmList[Entreprise[i].name].label = Entreprise[i].label
            EntrepriseFarmList[Entreprise[i].name].PosBoss = json.decode(Entreprise[i].PosBoss)
            EntrepriseFarmList[Entreprise[i].name].RecolteItem = Entreprise[i].namerecolteitem
            EntrepriseFarmList[Entreprise[i].name].PosRecolte = json.decode(Entreprise[i].PosRecolte)
            EntrepriseFarmList[Entreprise[i].name].TraitementItem = Entreprise[i].nametraitementitem
            EntrepriseFarmList[Entreprise[i].name].PosTraitement = json.decode(Entreprise[i].PosTraitement)
            EntrepriseFarmList[Entreprise[i].name].PosVente = json.decode(Entreprise[i].PosVente)

            -- SECURISATION RECOLTE
            ListeItemRecolt[Entreprise[i].namerecolteitem] = {}
            ListeItemRecolt[Entreprise[i].namerecolteitem].name = Entreprise[i].namerecolteitem
            -- SECURISATION TRAITEMENT
            ListeItemTraitement[Entreprise[i].nametraitementitem] = {}
            ListeItemTraitement[Entreprise[i].nametraitementitem].name = Entreprise[i].nametraitementitem

        end
    end)
end)

RegisterServerEvent('sunny:RefreshFarmSociety', function ()
    EntrepriseFarmList = {}
    ListeItemRecolt = {}
    ListeItemTraitement = {}

    MySQL.Async.fetchAll('SELECT * FROM player_entreprise', {}, function(Entreprise)
        for i=1, #Entreprise, 1 do
            EntrepriseFarmList[Entreprise[i].name] = {}
            EntrepriseFarmList[Entreprise[i].name].type = Entreprise[i].type 
            EntrepriseFarmList[Entreprise[i].name].name = Entreprise[i].name
            EntrepriseFarmList[Entreprise[i].name].label = Entreprise[i].label
            EntrepriseFarmList[Entreprise[i].name].PosBoss = json.decode(Entreprise[i].PosBoss)
            EntrepriseFarmList[Entreprise[i].name].RecolteItem = Entreprise[i].namerecolteitem
            EntrepriseFarmList[Entreprise[i].name].PosRecolte = json.decode(Entreprise[i].PosRecolte)
            EntrepriseFarmList[Entreprise[i].name].TraitementItem = Entreprise[i].nametraitementitem
            EntrepriseFarmList[Entreprise[i].name].PosTraitement = json.decode(Entreprise[i].PosTraitement)
            EntrepriseFarmList[Entreprise[i].name].PosVente = json.decode(Entreprise[i].PosVente)

            -- SECURISATION RECOLTE
            ListeItemRecolt[Entreprise[i].namerecolteitem] = {}
            ListeItemRecolt[Entreprise[i].namerecolteitem].name = Entreprise[i].namerecolteitem
            -- SECURISATION TRAITEMENT
            ListeItemTraitement[Entreprise[i].nametraitementitem] = {}
            ListeItemTraitement[Entreprise[i].nametraitementitem].name = Entreprise[i].nametraitementitem
            print('L\'entreprise ['..Entreprise[i].name..'] à été chargé')
            print('L\'item ['..Entreprise[i].namerecolteitem..'] à été ajouté dans la Whitelist')
            print('L\'item ['..Entreprise[i].nametraitementitem..'] à été ajouté dans la Whitelist')
        end

        TriggerClientEvent('Zigi:SendEntrepriseFarmList', -1, EntrepriseFarmList)
    end)

end)

RegisterServerEvent('Zigi:initFarmSociety')
AddEventHandler('Zigi:initFarmSociety', function()
    TriggerClientEvent('Zigi:SendEntrepriseFarmList', source, EntrepriseFarmList)
end)

local PlyaerJobFarm = {}

local function Activity(source, itemRecolte, type, ItemTraitement, society)
    if PlyaerJobFarm[source] then
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == 1 then -- Récolte
            if ListeItemRecolt[itemRecolte] == nil then
                DropPlayer(source, 'Désynchronisation avec les Entreprises de farm')
            else
                if ListeItemRecolt[itemRecolte].name == itemRecolte then
                    local total = 1
                    if boost_farm.have(xPlayer.UniqueID) then
                        total = total * 2
                    end
                    
                    local canCarry = true
                    if GetResourceState('ox_inventory') == 'started' then
                        canCarry = exports.ox_inventory:CanCarryItem(source, itemRecolte, total) or false
                    else
                        canCarry = xPlayer.canCarryItem(itemRecolte, total) or false
                    end
                    
                    if not canCarry then 
                        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez de place dans votre inventaire") 
                        TriggerClientEvent('framework:stopActivity', source) 
                        return 
                    end

                    TriggerClientEvent('framework:farmanimation', source)
                    Citizen.Wait(1500)
                    
                    if GetResourceState('ox_inventory') == 'started' then
                        exports.ox_inventory:AddItem(source, itemRecolte, total)
                    else
                        xPlayer.addInventoryItem(itemRecolte, total)
                    end
                    TriggerClientEvent('esx:showNotification', source, ('🌿 Vous avez récolté ~y~+%s~s~'):format(total))
                    sendLog(("Le Joueur (%s - %s) vient de récolter (x%s - %s) pour la société (%s) "):format(xPlayer.name, xPlayer.UniqueID, total, itemRecolte, xPlayer.job.label), {
                        author = xPlayer.job.label,
                        fields = {
                            {title = 'Player', subtitle = xPlayer.name},
                            {title = 'ID Unique', subtitle = xPlayer.UniqueID},
                            {title = 'Identifier', subtitle = xPlayer.identifier},
                            {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                        },
                        channel = 'reco_jobfarm'
                    })
                    Activity(source, itemRecolte, type, ItemTraitement, society)
                    TriggerEvent("esx:recolteentreprise", source, itemRecolte, society)
                end
            end
        elseif type == 2 then -- Traitement
            if ListeItemRecolt[itemRecolte] == nil or ListeItemTraitement[ItemTraitement] == nil then
                DropPlayer(source, 'Désynchronisation avec les Entreprises de farm')
            else
                if ListeItemRecolt[itemRecolte].name == itemRecolte and ListeItemTraitement[ItemTraitement].name == ItemTraitement then  
                    local total = 1
                    if boost_farm.have(xPlayer.UniqueID) then
                        total = total * 2
                    end
                    
                    local canCarry = true
                    if GetResourceState('ox_inventory') == 'started' then
                        canCarry = exports.ox_inventory:CanCarryItem(source, ItemTraitement, total) or false
                    else
                        canCarry = xPlayer.canCarryItem(ItemTraitement, total) or false
                    end
                    
                    if not canCarry then 
                        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez de place dans votre inventaire") 
                        return 
                    end	
                    local Quantity = 0
                    if GetResourceState('ox_inventory') == 'started' then
                        Quantity = exports.ox_inventory:GetItem(source, itemRecolte, nil, true) or 0
                    else
                        local inventoryItem = xPlayer.getInventoryItem(itemRecolte)
                        if inventoryItem then
                            Quantity = inventoryItem.count or 0
                        end
                    end
                    
                    if Quantity <= 0 then
                        xPlayer.showNotification('Vous n\'avez rien à traiter')
                        TriggerClientEvent('framework:stopActivity', source) 
                    else
                        local total = 1
                        if boost_farm.have(xPlayer.UniqueID) then
                            total = total * 2
                        end

                        TriggerClientEvent('framework:farmanimation', source)
                        Citizen.Wait(1500)
                        
                        if GetResourceState('ox_inventory') == 'started' then
                            exports.ox_inventory:RemoveItem(source, itemRecolte, total)
                            exports.ox_inventory:AddItem(source, ItemTraitement, total)
                        else
                            xPlayer.removeInventoryItem(itemRecolte, total)
                            xPlayer.addInventoryItem(ItemTraitement, total)
                        end
                        TriggerClientEvent('esx:showNotification', source, ('🌿 Vous avez traité ~y~+%s~s~'):format(total))
                        sendLog(("Le Joueur (%s - %s) vient de traiter (x%s - %s) pour la société (%s) "):format(xPlayer.name, xPlayer.UniqueID, total, ItemTraitement, xPlayer.job.label), {
                            author = xPlayer.job.label,
                            fields = {
                                {title = 'Player', subtitle = xPlayer.name},
                                {title = 'ID Unique', subtitle = xPlayer.UniqueID},
                                {title = 'Identifier', subtitle = xPlayer.identifier},
                                {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                            },
                            channel = 'trait_jobfarm'
                        })
                        Activity(source, itemRecolte, type, ItemTraitement, society)
                        TriggerEvent("esx:traitemententreprise", source, ItemTraitement, society)
                    end
                end
            end
        elseif type == 3 then -- Vente
            if ListeItemTraitement[ItemTraitement] == nil then
                DropPlayer(source, 'Désynchronisation avec les Entreprises de farm')
            else
                if ListeItemTraitement[ItemTraitement].name == ItemTraitement then
                    local Quantity = 0
                    if GetResourceState('ox_inventory') == 'started' then
                        Quantity = exports.ox_inventory:GetItem(source, ItemTraitement, nil, true) or 0
                    else
                        local inventoryItem = xPlayer.getInventoryItem(ItemTraitement)
                        if inventoryItem then
                            Quantity = inventoryItem.count or 0
                        end
                    end
                    
                    if Quantity <= 0 then
                        xPlayer.showNotification('Vous n\'avez rien à vendre')
                        TriggerClientEvent('framework:stopActivity', source) 
                    else					
                        local societyy = Society:getSociety(xPlayer.job.name)
                        TriggerClientEvent('framework:farmanimation', source)
                        Citizen.Wait(1500)
                        
                        if GetResourceState('ox_inventory') == 'started' then
                            exports.ox_inventory:RemoveItem(source, ItemTraitement, 1)
                        else
                            xPlayer.removeInventoryItem(ItemTraitement, 1)
                        end
                        societyy.addSocietyMoney(25)
                        xPlayer.addAccountMoney('bank', 25)
                        TriggerClientEvent('esx:showNotification', source, ('🌿 Vous avez vendu ~y~-1'))
                        sendLog(("Le Joueur (%s - %s) vient de vendre (x1 - %s) pour la société (%s) "):format(xPlayer.name, xPlayer.UniqueID, ItemTraitement, xPlayer.job.label), {
                            author = xPlayer.job.label,
                            fields = {
                                {title = 'Player', subtitle = xPlayer.name},
                                {title = 'ID Unique', subtitle = xPlayer.UniqueID},
                                {title = 'Identifier', subtitle = xPlayer.identifier},
                                {title = "Discord", subtitle = ESX.GetIdentifierFromId(source, "discord:")},
                            },
                            channel = 'vente_jobfarm'
                        })
                        Activity(source, itemRecolte, type, ItemTraitement, society)
                        TriggerEvent("esx:venteentreprise", source, ItemTraitement, society)
                    end
                end
            end
        else
            DropPlayer(source, 'Désynchronisation avec les Entreprises de farm')
        end
    end
end





RegisterServerEvent('framework:startActivity')
AddEventHandler('framework:startActivity', function(position, itemRecolte, type, ItemTraitement, society)
	if #(GetEntityCoords(GetPlayerPed(source)) - vector3(position.x, position.y, position.z)) < 100 then
		PlyaerJobFarm[source] = true
		Activity(source, itemRecolte, type, ItemTraitement, society)
	else
		TriggerEvent('Zigilpb_fantadmin:ban', source, source, 'Tricher est interdit ( Activité Légal )', 0)
	end
end)

RegisterServerEvent('framework:stopActivity')
AddEventHandler('framework:stopActivity', function()
	PlyaerJobFarm[source] = false
end)