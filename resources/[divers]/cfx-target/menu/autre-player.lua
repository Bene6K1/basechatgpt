RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(money)
      ESX.PlayerData.money = money
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    for i=1, #ESX.PlayerData.accounts, 1 do
        if ESX.PlayerData.accounts[i].name == account.name then
            ESX.PlayerData.accounts[i] = account
            break
        end
    end
end)

function _Player()
    local black_money
    for i = 1, #ESX.PlayerData.accounts, 1 do
        if ESX.PlayerData.accounts[i].name == 'black_money' then
            black_money = ESX.PlayerData.accounts[i].money
        end
    end
    Action_Config = {
        Player = {
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "mod", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "admin", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = false,
                Label = "ID : "..GetPlayerIdFromPed(LastEntityHit) or "Inconnu",
                OnClick = function()
                end,
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "mod", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "admin", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = false,
                Label = "Nom : "..GetPlayerName(GetPlayerFromServerId(GetPlayerIdFromPed(LastEntityHit))) or "Inconnu",
                OnClick = function()
                end,
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "mod", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "admin", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                CloseOnClick = true,
                Label = "Gesticulation",
                Action = {
                    {
                        "Otage",
                        function()
                            ExecuteCommand('th')
                        end
                    },
                    {
                        "Porter",
                        function()
                            ExecuteCommand('porter')
                        end
                    },
                }
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "mod", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "admin", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                CloseOnClick = true,
                Label = "Donnez de l'argent",
                Action = {
                    {
                        "Votre argent : ~g~"..ESX.Math.GroupDigits(ESX.PlayerData.money),
                        function()
                        end
                    },
                    {
                        "Votre argent (sale) : ~r~"..ESX.Math.GroupDigits(black_money),
                        function()
                        end
                    },
                    {
                        "",
                        function()
                        end
                    },
                    {
                        "Donnez de l'argent (~g~Argent~s~)",
                        function()
                            local quantity = exports["cfx-target"]:ShowSync("Somme d'argent que vous voulez donner", false, 320., "small_text")
                            if tonumber(quantity) then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestDistance ~= -1 and closestDistance <= 3 then
                                    local closestPed = GetPlayerPed(closestPlayer)
                                    if not IsPedSittingInAnyVehicle(closestPed) then
                                        TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_money', 'rien', tonumber(quantity))
                                    else
                                        ESX.ShowNotification('Vous ne pouvez pas donner de l\'argent dans un véhicles')
                                    end
                                else
                                    ESX.ShowNotification('Aucun joueur proche !')
                                end
                            else
                                ESX.ShowNotification('Somme invalid')
                            end
                        end
                    },
                    {
                        "Donnez de l'argent (~r~Argent sale~s~)",
                        function()
                            for i = 1, #ESX.PlayerData.accounts, 1 do
                                if ESX.PlayerData.accounts[i].name == 'black_money' then
                                    local quantity = exports["cfx-target"]:ShowSync("Somme d'argent que vous voulez donner", false, 320., "small_text")
                                    if tonumber(quantity) then
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                        if closestDistance ~= -1 and closestDistance <= 3 then
                                            local closestPed = GetPlayerPed(closestPlayer)
                                            if not IsPedSittingInAnyVehicle(closestPed) then
                                                TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_account', ESX.PlayerData.accounts[i].name, tonumber(quantity))
                                            else
                                                ESX.ShowNotification(_U('Vous ne pouvez pas donner ', 'de l\'argent dans un véhicles'))
                                            end
                                        else
                                            ESX.ShowNotification('Aucun joueur proche !')
                                        end
                                    else
                                        ESX.ShowNotification('Somme invalid')
                                    end
                                end
                            end                          
                        end
                    },
                }
            }, 
            {
                user = "", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "admin", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "_dev", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "owner", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                CloseOnClick = false,
                Label = "Actions (admin)",
                Action = {
                    {
                        'Revive',
                        function()
                            local tPlayer = ESX.GetPlayerIdFromPed(LastEntityHit)
                            if not tPlayer then
                                return
                            end
                            local uniqueId = tPlayer.UniqueID
                            ExecuteCommand('revive '..uniqueId)
                        end
                    },
                    {
                        'Heal',
                        function()
                            local tPlayer = ESX.GetPlayerIdFromPed(LastEntityHit)
                            if not tPlayer then
                                return
                            end
                            local uniqueId = tPlayer.UniqueID
                            ExecuteCommand('heal '..uniqueId)
                        end
                    },
                    {
                        'Feed',
                        function()
                            local tPlayer = ESX.GetPlayerIdFromPed(LastEntityHit)
                            if not tPlayer then
                                return
                            end
                            local uniqueId = tPlayer.UniqueID
                            ExecuteCommand('heal '..uniqueId)
                        end
                    },
                    {
                        'Donner un item',
                        function()
                            local tPlayer = ESX.GetPlayerIdFromPed(LastEntityHit)
                            if not tPlayer then
                                return
                            end
                            local uniqueId = tPlayer.UniqueID
                            local item = exports["cfx-target"]:ShowSync("Entrez nom d'item", false, 320., "small_text")
                            local amount = exports["cfx-target"]:ShowSync("Entrez le nombre d'item a give", false, 320., "small_text")
                            ExecuteCommand('giveitem ' ..uniqueId.." "..item.." "..amount)
                        end
                    },
                    {
                        'Kick',
                        function()
                            local tPlayer = ESX.GetPlayerIdFromPed(LastEntityHit)
                            if not tPlayer then
                                return
                            end
                            local uniqueId = tPlayer.UniqueID
                            local raison = exports["cfx-target"]:ShowSync("Quelle est la raison ?", false, 320., "small_text")
                            TriggerServerEvent('DeaDTrIX:kickjoueur', GetPlayerIdFromPed(LastEntityHit), raison)
                        end
                    },
                    {
                        'Ban',
                        function()
                            local tPlayer = ESX.GetPlayerIdFromPed(LastEntityHit)
                            if not tPlayer then
                                return
                            end
                            local uniqueId = tPlayer.UniqueID
                            local jours = exports["cfx-target"]:ShowSync("Nombre de jours ?", false, 320., "small_text")
                            local Raison = exports["cfx-target"]:ShowSync("la raison ?", false, 320., "small_text")
                            ExecuteCommand('ban '..uniqueId..' '..jours..' '..Raison)
                        end
                    },
                }  
            }
        }
    }
end