RegisterNetEvent('sunny:properties:trunk:refresh', function(propertiesID, k)
    if k == nil then
    else
        if Properties.PropertiesList and Properties.PropertiesList[propertiesID] then
            Properties.PropertiesList[propertiesID].trunk = k
        else
            --print(("[PropertiesClient][TrunkRefresh] WARNING: Properties.PropertiesList or Properties.PropertiesList[%s] is nil when attempting to refresh trunk. Cannot set trunk data."):format(tostring(propertiesID)))
        end
    end
end)


local used = false

function Properties:openTrunkMenu(k)
    if not Properties.PropertiesList or not Properties.PropertiesList[k] then
        ESX.ShowNotification("ERREUR: Données de propriété non chargées ou introuvables pour l'ID: " .. tostring(k))
        -- print(('[PropertiesClient][Trunk] ERROR: Properties.PropertiesList or Properties.PropertiesList[%s] is nil. Cannot open trunk menu.'):format(tostring(k)))
        return
    end

    -- print("----------------------------------------")
    -- print("[DEBUG] Ouverture du coffre de la propriété ID: " .. tostring(k))
    
    local propertyOwnerId = Properties.PropertiesList[k].owner
    local playerUniqueId = ESX.PlayerData.UniqueID
    
    local ownerIdString = tostring(propertyOwnerId)
    local playerIdString = tostring(playerUniqueId)
    
    -- print("[DEBUG] Owner ID (brut): " .. tostring(propertyOwnerId) .. " (type: " .. type(propertyOwnerId) .. ")")
    -- print("[DEBUG] Player ID (brut): " .. tostring(playerUniqueId) .. " (type: " .. type(playerUniqueId) .. ")")
    -- print("[DEBUG] Owner ID (string): " .. ownerIdString)
    -- print("[DEBUG] Player ID (string): " .. playerIdString)
    -- print("[DEBUG] Comparaison IDs égaux?: " .. tostring(ownerIdString == playerIdString))
    -- print("[DEBUG] Le coffre est ouvert: " .. tostring(Properties.PropertiesList[k].coffreOpen))
    
    if Properties.PropertiesList[k].trunk then
        -- print("[DEBUG] État du code: " .. tostring(Properties.PropertiesList[k].trunk.code and Properties.PropertiesList[k].trunk.code.active))
        -- print("[DEBUG] Code bloqué: " .. tostring(Properties.PropertiesList[k].trunk.code and Properties.PropertiesList[k].trunk.code.blocked))
    else
        -- print("[DEBUG] Trunk data is nil")
    end
    -- print("----------------------------------------")

    Properties.PropertiesList[k].trunkUnLockedCount = Properties.PropertiesList[k].trunkUnLockedCount or 3
    used = false

    if type(Properties.PropertiesList[k].trunk) ~= 'table' then
        Properties.PropertiesList[k].trunk = {}
        -- print(('[PropertiesClient][Trunk] WARNING: Properties.PropertiesList[%s].trunk was not a table. Initialized as empty table.'):format(tostring(k)))
    end

    if not Properties.PropertiesList[k].trunk.code then
        Properties.PropertiesList[k].trunk.code = { active = false, blocked = false, code = nil }
        -- print(('[PropertiesClient][Trunk] WARNING: Properties.PropertiesList[%s].trunk.code was nil. Initialized with default structure.'):format(tostring(k)))
    end

    if Properties.PropertiesList[k].trunk['code'] and Properties.PropertiesList[k].trunk['code'].active == true and Properties.PropertiesList[k].trunk['code'].code ~= nil then
        Properties.PropertiesList[k].trunkUnLocked = false
        -- print("[DEBUG] Coffre configuré comme verrouillé car un code est actif")
    else
        Properties.PropertiesList[k].trunkUnLocked = true
        -- print("[DEBUG] Coffre configuré comme déverrouillé car aucun code actif")
    end
    
    local main = RageUI.CreateMenu('', 'Actions Disponibles')
    local money = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    local items = RageUI.CreateSubMenu(main, '', 'Actions Disponibles') 
    local playerInventory = RageUI.CreateSubMenu(items, '', 'Actions Disponibles')
    local weapons = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    local playerWeapons = RageUI.CreateSubMenu(weapons, '', 'Actions Disponibles')
    local codeOptions = RageUI.CreateSubMenu(main, '', 'Actions Disponibles')
    main.Closed = function()
        FreezeEntityPosition(PlayerPedId(), false)
    end
    RageUI.Visible(main, not RageUI.Visible(main))
    FreezeEntityPosition(PlayerPedId(), true)
    while main do Wait(1)
        RageUI.IsVisible(main, function()
            local pd = Properties:ReturnPropertiesData(k)
            local timeLeft = tonumber(pd.time) or 0
               
            -- CORRECTION de la vérification de propriétaire
            -- Convertir explicitement les deux ID en chaînes pour comparaison
            local ownerIdString = tostring(pd.owner)
            local playerIdString = tostring(ESX.PlayerData.UniqueID)
            local isOwner = ownerIdString == playerIdString
            
            -- print("[DEBUG] Dans le menu, isOwner: " .. tostring(isOwner))
            -- print("[DEBUG] coffreOpen: " .. tostring(pd.coffreOpen))
            -- print("[DEBUG] Comparaison de '" .. ownerIdString .. "' avec '" .. playerIdString .. "'")
            
            -- CORRECTION: Si le joueur est propriétaire OU si le coffre est ouvert
            if not isOwner and pd.coffreOpen == false then
                -- print("[DEBUG] Accès refusé: Utilisateur n'est pas propriétaire ET coffre fermé")
                RageUI.Separator('Le coffre est verrouillé')
                goto continue
            end
            
            -- print("[DEBUG] Accès autorisé: Utilisateur est propriétaire OU coffre ouvert")
            
            -- Si pas de code configuré
            if not Properties.PropertiesList[k].trunk['code'] or Properties.PropertiesList[k].trunk['code'].active == false then
                -- print("[DEBUG] Affichage du menu pour configurer un code")
                RageUI.Button('Entrer un code', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Taper le CODE', function(data)
                            if data == nil then return end
                            Properties.PropertiesList[k].trunk['code'].active = true
                            Properties.PropertiesList[k].trunk['code'].code = data
                            TriggerServerEvent('sunny:properties:trunk:updateCode', k, Properties.PropertiesList[k].trunk['code'])
                            print("[DEBUG] Code configuré: " .. tostring(data))
                        end)
                    end
                })
                RageUI.Button('Ne pas utiliser de code', nil, {}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName,
                            'Êtes-vous sûr de vouloir ne pas utiliser de code ?',
                            '',
                            function(response)
                                if response then -- Oui
                                    Properties.PropertiesList[k].trunk['code'].active = 'none'
                                    TriggerServerEvent('sunny:properties:trunk:updateCode', k, Properties.PropertiesList[k].trunk['code'])
                                    -- print("[DEBUG] Option sans code sélectionnée")
                                else -- Non
                                    ESX.ShowNotification('Action annulée') 
                                end
                            end
                        )
                    end
                })
                
                goto continue
            end

            if Properties.PropertiesList[k].trunkUnLocked == false and 
               Properties.PropertiesList[k].trunk['code'].active == true and 
               Properties.PropertiesList[k].trunk['code'].blocked == false then
                
                -- print("[DEBUG] Affichage de l'option pour entrer le code")
                RageUI.Button('Entrer le code du coffre', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Taper le code du coffre', function(data)
                            -- print("[DEBUG] Tentative de code: " .. tostring(data))
                            -- print("[DEBUG] Code attendu: " .. tostring(Properties.PropertiesList[k].trunk['code'].code))
                            
                            if Properties.PropertiesList[k].trunk['code'].code ~= data then
                                -- print("[DEBUG] Code incorrect")
                                if not isOwner then
                                    if not used then
                                        Properties.PropertiesList[k].trunkUnLockedCount = 3
                                    end
                                    used = true
                                    Properties.PropertiesList[k].trunkUnLockedCount = Properties.PropertiesList[k].trunkUnLockedCount - 1
                                    ESX.ShowNotification(('Mauvais code il te reste %s essai(s)'):format(Properties.PropertiesList[k].trunkUnLockedCount))
                                    -- print("[DEBUG] Essais restants: " .. tostring(Properties.PropertiesList[k].trunkUnLockedCount))
                                    
                                    if Properties.PropertiesList[k].trunkUnLockedCount <= 0 then
                                        Properties.PropertiesList[k].trunk['code'].blocked = true
                                        TriggerServerEvent('sunny:properties:trunk:updateCode', k, Properties.PropertiesList[k].trunk['code'])
                                        -- print("[DEBUG] Coffre bloqué après trop d'essais")
                                    end
                                else
                                    ESX.ShowNotification('Mauvais code. Essayez à nouveau.')
                                end
                            else
                                -- print("[DEBUG] Code correct!")
                                Properties.PropertiesList[k].trunkUnLocked = true
                                ESX.ShowNotification('Code correct, coffre déverrouillé.')
                            end
                        end)
                    end
                })
                
                if isOwner then
                    -- print("[DEBUG] Affichage de l'option de déverrouillage propriétaire")
                    RageUI.Button('Déverrouiller en tant que propriétaire', nil, {}, true, {
                        onSelected = function()
                            Properties.PropertiesList[k].trunkUnLocked = true
                            ESX.ShowNotification('Coffre déverrouillé avec vos clés.')
                            -- print("[DEBUG] Coffre déverrouillé par le propriétaire")
                        end
                    })
                end
                
                goto continue
            end

            if Properties.PropertiesList[k].trunk['code'] and Properties.PropertiesList[k].trunk['code'].blocked then
                -- print("[DEBUG] Affichage du message de coffre bloqué")
                RageUI.Separator('~r~Le coffre est bloqué~s~')
                
                if isOwner then
                    RageUI.Button('Débloquer le coffre', nil, {}, true, {
                        onSelected = function()
                            Properties.PropertiesList[k].trunk['code'].blocked = false
                            Properties.PropertiesList[k].trunkUnLockedCount = 3
                            TriggerServerEvent('sunny:properties:trunk:updateCode', k, Properties.PropertiesList[k].trunk['code'])
                            ESX.ShowNotification('Coffre débloqué avec succès.')
                            -- print("[DEBUG] Coffre débloqué par le propriétaire")
                        end
                    })
                else
                    RageUI.Button('Contacter le service de maintenance', nil, {}, true, {
                        onSelected = function()
                            ESX.ShowNotification('Veuillez contacter le propriétaire pour débloquer le coffre.')
                        end
                    })
                end
                goto continue
            end

            -- print("[DEBUG] Affichage du contenu du coffre")
            
            if Properties.PropertiesList[k].entrepot == 1 or Properties.PropertiesList[k].entrepot == true then
                RageUI.Separator(('Poids du coffre ~y~%s/KG~s~'):format(Properties.PropertiesList[k].pound))
            end

            RageUI.Button('Argent(s)', nil, {}, true, {
                onSelected =  function()
                end
            }, money)
            
            RageUI.Button('Item(s)', nil, {}, true, {
                onSelected = function()
                end
            }, items)
            
            -- RageUI.Button('Arme(s)', nil, {}, true, {
            --     onSelected = function()
            --     end
            -- }, weapons)

            RageUI.WLine()
            RageUI.Button('Gestion du coffre', nil, {}, true, {
                onSelected = function()
                end
            }, codeOptions)

            ::continue::
        end)

        RageUI.IsVisible(money, function()
            RageUI.Button('Déposer de l\'argent', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Montant à déposer', function(data)
                        local data = tonumber(data)
                        if data == nil or data <= 0 then return end

                        TriggerServerEvent('sunny:properties:trunk:actionsMoney', k, 'cash', data, 'add')
                    end)
                end
            })
            RageUI.Button('Déposer de l\'argent sale', nil, {}, true, {
                onSelected = function()
                    KeyboardUtils.use('Montant à déposer', function(data)
                        local data = tonumber(data)
                        if data == nil or data <= 0  then return end

                        TriggerServerEvent('sunny:properties:trunk:actionsMoney', k, 'black_money', data, 'add')
                    end)
                end
            })
            RageUI.WLine()
            RageUI.Button('Cash', nil, {RightLabel = '~r~'..Properties.PropertiesList[k].trunk['accounts'].cash..'$'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Montant à déposer', function(data)
                        local data = tonumber(data)
                        if data == nil or data <= 0  then return end

                        TriggerServerEvent('sunny:properties:trunk:actionsMoney', k, 'cash', data, 'remove')
                    end)
                end
            })
            RageUI.Button('Argent Sale', nil, {RightLabel = '~r~'..Properties.PropertiesList[k].trunk['accounts'].black_money..'$'}, true, {
                onSelected = function()
                    KeyboardUtils.use('Montant à déposer', function(data)
                        local data = tonumber(data)
                        if data == nil or data <= 0  then return end

                        TriggerServerEvent('sunny:properties:trunk:actionsMoney', k, 'black_money', data, 'remove')
                    end)
                end
            })
        end)

        RageUI.IsVisible(items, function()
            RageUI.Button('Déposer un objet', nil, {}, true, {
                onSelected = function()
                end
            }, playerInventory)
            RageUI.WLine()
            for _,v in pairs(Properties.PropertiesList[k].trunk['items']) do
                RageUI.Button(v.label, nil, {RightLabel = '~r~'..tostring(v.count)}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Quantité', function(data)
                            local amount = tonumber(data)

                            if amount == nil then
                                ESX.ShowNotification("Quantité invalide: la valeur entrée n\\'est pas un nombre.")
                                return
                            end
                            if amount <= 0 then
                                ESX.ShowNotification("La quantité doit être un nombre positif.")
                                return
                            end

                            TriggerServerEvent('sunny:properties:trunk:actionsCoffre', k, v, amount, 'remove', 'item', _)
                        end)
                    end
                })
            end
        end)

        RageUI.IsVisible(playerInventory, function()
            ESX.PlayerData = ESX.GetPlayerData()
            for _,v_player in pairs(ESX.PlayerData.inventory) do
                RageUI.Button(v_player.label, nil, {RightLabel = '~r~'..tostring(v_player.count)}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Quantité', function(data)
                            local amount = tonumber(data)

                            if amount == nil then
                                ESX.ShowNotification("Quantité invalide: la valeur entrée n\\'est pas un nombre.")
                                return
                            end
                            if amount <= 0 then
                                ESX.ShowNotification("La quantité doit être un nombre positif.")
                                return
                            end

                            TriggerServerEvent('sunny:properties:trunk:actionsCoffre', k, v_player, amount, 'add', 'item')
                        end)
                    end
                })
            end
        end)

        RageUI.IsVisible(weapons, function()
            RageUI.Button('Déposer une arme', nil, {}, true, {
                onSelected = function()

                end
            }, playerWeapons)
            RageUI.WLine()
            for _,v in pairs(Properties.PropertiesList[k].trunk['weapons']) do
                RageUI.Button(v.label, nil, {RightLabel = '~r~'..v.ammo}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName, 
                            'Êtes-vous sûr de vouloir retirer cette arme ?',
                            '',
                            function(response)
                                if response then -- Oui
                                    TriggerServerEvent('sunny:properties:trunk:actionsCoffre', k, v, v.ammo, 'remove', 'weapon', v.number, _)
                                else -- Non
                                    ESX.ShowNotification('Action annulée')
                                end
                            end
                        )
                    end
                })
                
            end
        end)

        RageUI.IsVisible(playerWeapons, function()
            ESX.PlayerData.loadout = ESX.GetPlayerData().loadout
            for _,v in pairs(ESX.PlayerData.loadout) do
                if HasPedGotWeapon(Player.playerPed, GetHashKey(v.name)) then
                    RageUI.Button(v.label, nil, {RightLabel = '~r~'..v.ammo}, true, {
                        onSelected = function()
                            if SunnyConfigServ.PermanantWeapon[v.name] then return end
                            exports['prompt']:createPrompt(
                                SunnyConfigServ.ServerName,
                                'Êtes-vous sûr de vouloir ajouter cette arme ?',
                                '',
                                function(response)
                                    if response then -- Oui
                                        TriggerServerEvent('sunny:properties:trunk:actionsCoffre', k, v, v.ammo, 'add', 'weapon', v.number, _)
                                    else -- Non
                                        ESX.ShowNotification('Action annulée')
                                    end
                                end
                            )
                        end
                    })
                    
                end
            end
        end)

        RageUI.IsVisible(codeOptions, function()    
            if Properties:ReturnPropertiesData(k).trunk['code'].active == true then
                RageUI.Button('Changer de code', nil, {}, true, {
                    onSelected = function()
                        KeyboardUtils.use('Nouveau code', function(data)
                            Properties.PropertiesList[k].trunk['code'].code = data

                            TriggerServerEvent('sunny:properties:trunk:updateCode', k, Properties.PropertiesList[k].trunk['code'])
                        end)
                    end
                })
            end
            if Properties:ReturnPropertiesData(k).trunk['code'].active == true then
                RageUI.Button('Désactiver le code', nil, {}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName,
                            'Êtes-vous sûr de vouloir désactiver le code ?',
                            '',
                            function(response)
                                if response then -- Oui
                                    Properties.PropertiesList[k].trunk['code'].active = 'none'
                                    TriggerServerEvent('sunny:properties:trunk:updateCode', k, Properties.PropertiesList[k].trunk['code'])
                                else -- Non
                                    ESX.ShowNotification('Action annulée')
                                end
                            end
                        )
                    end
                })
                
            end
            if Properties:ReturnPropertiesData(k).trunk['code'].active == 'none' then
                RageUI.Button('Activer le code', nil, {}, true, {
                    onSelected = function()
                        exports['prompt']:createPrompt(
                            SunnyConfigServ.ServerName,
                            'Êtes-vous sûr de vouloir activer le code ?',
                            '',
                            function(response)
                                if response then -- Oui
                                    KeyboardUtils.use('Taper un CODE', function(data2)
                                        if data2 and data2 ~= "" then
                                            Properties.PropertiesList[k].trunk['code'].active = true
                                            Properties.PropertiesList[k].trunk['code'].code = data2

                                            TriggerServerEvent('sunny:properties:trunk:updateCode', k, Properties.PropertiesList[k].trunk['code'])
                                        else
                                            ESX.ShowNotification('Le code ne peut pas être vide')
                                        end
                                    end)
                                else -- Non
                                    ESX.ShowNotification('Action annulée')
                                end
                            end
                        )
                    end
                })
                
            end
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(money) and not RageUI.Visible(items) and not RageUI.Visible(playerInventory) and not RageUI.Visible(weapons) and not RageUI.Visible(playerWeapons) and not RageUI.Visible(codeOptions) then
            main = RMenu:DeleteType('main')
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end