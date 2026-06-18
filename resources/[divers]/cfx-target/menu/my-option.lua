function _My()
    local black_money = 0
    local bank = 0
    
    if ESX.PlayerData and ESX.PlayerData.accounts then
        for i = 1, #ESX.PlayerData.accounts, 1 do
            if ESX.PlayerData.accounts[i].name == 'black_money' then
                black_money = ESX.PlayerData.accounts[i].money or 0
            end
            if ESX.PlayerData.accounts[i].name == 'bank' then
                bank = ESX.PlayerData.accounts[i].money or 0
            end
        end
    end
    
    RefreshMoney()
    RefreshMoney2()
    
    if societymoney == nil then
        societymoney = 'rien'
    end
    if societymoney2 == nil then
        societymoney2 = 'rien'
    end
    Action_Config = {

        My = {
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "moderateur" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE MODERATEUR POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "administrateur" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE ADMINISTRATEUR POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = false,
                Label = ("Mon ID Unique : ~b~%s"):format(ESX.PlayerData.UniqueID or "N/A"),
                OnClick = function()
                end,
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "moderateur" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE MODERATEUR POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "administrateur" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE ADMINISTRATEUR POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                CloseOnClick = true,
                Label = "Vos Informations",

                Action = {
                    {
                        ("Mon nom :~b~ %s %s"):format(ESX.PlayerData.firstname or "N/A", ESX.PlayerData.lastname or "N/A"),
                        function()
                        end
                    },                    {
                        "Job : ~b~"..(ESX.PlayerData.job and ESX.PlayerData.job.label or "Aucun"),
                        function()
                        end
                    },
                    {
                        "Organisation : ~b~"..(ESX.PlayerData.job2 and ESX.PlayerData.job2.label or "Aucune"),
                        function()
                        end
                    },
                    {
                        "Votre argent (sur vous) : ~g~"..ESX.Math.GroupDigits(ESX.PlayerData.accounts and ESX.PlayerData.accounts[1] and ESX.PlayerData.accounts[1].money or 0),
                        function()
                        end
                    },
                    {
                        "Votre argent (en bank) : ~b~"..ESX.Math.GroupDigits(bank),
                        function()
                        end
                    },
                    {
                        "Votre argent (sale) : ~r~"..ESX.Math.GroupDigits(black_money),
                        function()
                        end
                    },
                },    
            },            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                CloseOnClick = true,
                Label = "Documents",
                Action = {
                    {
                        "Regarder sa ~b~carte d'identité",
                        function()
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
                        end
                    },
                    {
                        "Montrer sa ~b~carte d'identité",
                        function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestDistance ~= -1 and closestDistance <= 3.0 then
                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
                            else
                                ESX.ShowNotification('Aucun joueur ~r~proche !')
                            end
                        end
                    },
                    {
                        "Regarder son ~g~permis de conduire",
                        function()
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                        end
                    },
                    {
                        "Montrer son ~g~permis de conduire",
                        function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestDistance ~= -1 and closestDistance <= 3.0 then
                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'driver')
                            else
                                ESX.ShowNotification('Aucun joueur ~r~proche !')
                            end
                        end
                    },
                    {
                        "Regarder son ~r~permis port d'arme",
                        function()
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
                        end
                    },
                    {
                        "Montrer son ~r~permis port d'arme",
                        function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestDistance ~= -1 and closestDistance <= 3.0 then
                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'weapon')
                            else
                                ESX.ShowNotification('Aucun joueur ~r~proche !')
                            end
                        end
                    },
                }
            },
            {                
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-entreprise",
                CloseOnClick = true,
                Label = "Entreprise",
                Action = {

------------------------------------------------------------- ACCES MENU QUE POUR LES BOSS -------------------------------------------------------------------------

                    {
                        "Travaille Actuelle : ~b~"..ESX.PlayerData.job.label,
                        function()
                        end
                    },
                    {
                        "Coffre Entreprise : ~g~"..societymoney.. ' $',
                        function()
                        end
                    },
                    {
                        "Recruter le joueur",
                        function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('Aucun joueur proche')
                            else
                                TriggerServerEvent('deadtrix-context:server:recrut', GetPlayerServerId(closestPlayer))
                            end
                        end
                    },
                    {
                        "Promouvoir le joueur",
                        function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('Aucun joueur proche')
                            else
                                TriggerServerEvent('deadtrix-context:server:promote', GetPlayerServerId(closestPlayer))
                            end
                        end
                    },
                    {
                        "Rétrogradé le joueur",
                        function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('Aucun joueur proche')
                            else
                                TriggerServerEvent('deadtrix-context:server:destituer', GetPlayerServerId(closestPlayer))
                            end
                        end
                    },
                    {
                        "Viré le joueur",
                        function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('Aucun joueur proche')
                            else
                                TriggerServerEvent('deadtrix-context:server:virer', GetPlayerServerId(closestPlayer))
                            end
                        end
                    },
                    {
                        "Message aux employés",
                        function()
                            local info = 'patron'
                            local message = exports["cfx-target"]:ShowSync('Veuillez mettre le messsage à envoyer', false, 320., "small_text")
                            TriggerServerEvent('deadtrixcontext:envoyeremployer', info, message)
                        end
                    },
                }
            },            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-organisation",
                CloseOnClick = true,
                Label = "Organisation",
                Action = {

------------------------------------------------------------- ACCES MENU QUE POUR LES BOSS -------------------------------------------------------------------------

                    {
                        "Travaille Actuelle : ~b~"..ESX.PlayerData.job2.label,
                        function()
                        end
                    },
                    {
                        "Coffre Entreprise : ~g~"..societymoney2.. ' $',
                        function()
                        end
                    },
                    {
                        "Recruter le joueur",
                        function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('Aucun joueur proche')
                            else
                                ESX.ShowNotification('Vous avez recruté ~b~' .. GetPlayerName(closestPlayer))
                                TriggerServerEvent('deadtrix-context:server:recrut2', GetPlayerServerId(closestPlayer))
                            end
                        end
                    },
                    {
                        "Promouvoir le joueur",
                        function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('Aucun joueur proche')
                            else
                                ESX.ShowNotification('Vous avez Promu ~b~' .. GetPlayerName(closestPlayer))
                                TriggerServerEvent('deadtrix-context:server:promote2', GetPlayerServerId(closestPlayer))
                            end
                        end
                    },
                    {
                        "Rétrogradé le joueur",
                        function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('Aucun joueur proche')
                            else
                                ESX.ShowNotification('Vous avez Rétrograder ~b~' .. GetPlayerName(closestPlayer))
                                TriggerServerEvent('deadtrix-context:server:derank2', GetPlayerServerId(closestPlayer))
                            end
                        end
                    },
                    {
                        "Viré le joueur",
                        function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('Aucun joueur proche')
                            else
                                ESX.ShowNotification('Vous avez virer ~b~' .. GetPlayerName(closestPlayer))
                                TriggerServerEvent('deadtrix-context:server:virer2', GetPlayerServerId(closestPlayer))
                            end
                        end
                    },
                }
            },            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = true,
                Label = "Me (...)",
                OnClick = function()
                    local imput = exports["cfx-target"]:ShowSync('Entrez un nom', false, 320., "small_text")
                    ExecuteCommand('me '..imput)
                end,
            },            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                CloseOnClick = false,
                Label = "Tp Coordonée",
                Action = {
                    {
                        "Tp avec Coordonée",
                        function()
                            local CoordsX = exports["cfx-target"]:ShowSync('Coordonée X', false, 320., "small_text")
                            local CoordsY = exports["cfx-target"]:ShowSync('Coordonée Y', false, 320., "small_text")
                            local CoordsZ = exports["cfx-target"]:ShowSync('Coordonée Z', false, 320., "small_text")
                            if CoordsX ~= nil and CoordsY ~= nil and CoordsZ ~= nil then
                                SetEntityCoords(LastEntityHit, CoordsX + 0.0, CoordsY + 0.0, CoordsZ + 0.0)
                                ESX.ShowNotification("~s~Vous avez été ~g~téléporté~s~ aux ~b~coordonnées")
                            end
                        end
                    },
                    {
                        "Tp Parking Central",
                        function()
                            SetEntityCoords(LastEntityHit, Config.TeleportOptions.Parking.position.x, Config.TeleportOptions.Parking.position.y, Config.TeleportOptions.Parking.position.z, false, false, false, false)
                        end
                    },
                    {
                        "Tp Centre de police",
                        function()
                            SetEntityCoords(LastEntityHit, Config.TeleportOptions.Police.position.x, Config.TeleportOptions.Police.position.y, Config.TeleportOptions.Police.position.z, false, false, false, false)
                        end
                    },
                    {
                        "Tp Hopital",
                        function()
                            SetEntityCoords(LastEntityHit, Config.TeleportOptions.Hopital.position.x, Config.TeleportOptions.Hopital.position.y, Config.TeleportOptions.Hopital.position.z, false, false, false, false)
                        end
                    },
                    {
                        "Tp Mecano",
                        function()
                            SetEntityCoords(LastEntityHit, Config.TeleportOptions.Mecano.position.x, Config.TeleportOptions.Mecano.position.y, Config.TeleportOptions.Mecano.position.z, false, false, false, false)
                        end
                    },
                    {
                        "Tp Concessionnaire",
                        function()
                            SetEntityCoords(LastEntityHit, Config.TeleportOptions.Concessionnaire.position.x, Config.TeleportOptions.Concessionnaire.position.y, Config.TeleportOptions.Concessionnaire.position.z, false, false, false, false)
                        end
                    },
                    {
                        "Tp Fourriere",
                        function()
                            SetEntityCoords(LastEntityHit, Config.TeleportOptions.Fourriere.position.x, Config.TeleportOptions.Fourriere.position.y, Config.TeleportOptions.Fourriere.position.z, false, false, false, false)
                        end
                    },
                    {
                        "Tp Chilliad",
                        function()
                            SetEntityCoords(LastEntityHit, Config.TeleportOptions.Chilliad.position.x, Config.TeleportOptions.Chilliad.position.y, Config.TeleportOptions.Chilliad.position.z, false, false, false, false)
                        end
                    },
                }
            },            {
                user = "", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                CloseOnClick = true,
                Label = "Actions (admin)",
                Action = {
                    {
                        'Revive',
                        function()
                            ExecuteCommand('revive '..ESX.PlayerData.UniqueID)
                        end
                    },
                    {
                        'Heal',
                        function()
                            ExecuteCommand('heal '..GetPlayerIdFromPed(LastEntityHit))
                        end
                    },
                    {
                        'Feed',
                        function()
                            ExecuteCommand('heal '..GetPlayerIdFromPed(LastEntityHit))
                        end
                    },
                    {
                        'Ouvrir le menu skin',
                        function()
                            ExecuteCommand('skin')
                        end
                    },
                    {
                        'Donner un item',
                        function()
                            local id = exports["cfx-target"]:ShowSync("Entrez un ID pour give", false, 320., "small_text")
                            local item = exports["cfx-target"]:ShowSync("Entrez nom d'item", false, 320., "small_text")
                            local amount = exports["cfx-target"]:ShowSync("Entrez le nombre d'item a give", false, 320., "small_text")
                            ExecuteCommand('giveitem ' ..id.." "..item.." "..amount)
                        end
                    },
                    {
                        'Donner une arme',
                        function()
                            local id = exports["cfx-target"]:ShowSync("Entrez un ID pour give", false, 320., "small_text")
                            local weapon = exports["cfx-target"]:ShowSync("Entrez nom de l'arme", false, 320., "small_text")
                            local amount = exports["cfx-target"]:ShowSync("Entrez le nombre de munition a give", false, 320., "small_text")
                            ExecuteCommand('giveweapon ' ..id.." weapon_"..weapon.." "..amount)
                        end
                    },
                    {
                        'Donner argent (~g~Cash~s~)',
                        function()
                            local amount = exports["cfx-target"]:ShowSync("Somme", false, 320., "small_text")

                                if amount ~= nil then
                                    amount = tonumber(amount)

                                    if type(amount) == 'number' then
                                        TriggerServerEvent('GiveCashBy:DeaDTriX', amount)
                                    end
                                end
                        end
                    },
                    {
                        'Donner argent (~o~Bank~s~)',
                        function()
                            local amount = exports["cfx-target"]:ShowSync("Somme", false, 320., "small_text")

                                if amount ~= nil then
                                    amount = tonumber(amount)

                                    if type(amount) == 'number' then
                                        TriggerServerEvent('GiveBankBy:DeaDTriX', amount)
                                    end
                                end
                        end
                    },
                    {
                        'Donner argent (~r~BlackMoney~s~)',
                        function()
                            local amount = exports["cfx-target"]:ShowSync("Somme", false, 320., "small_text")

                                if amount ~= nil then
                                    amount = tonumber(amount)

                                    if type(amount) == 'number' then
                                        TriggerServerEvent('GiveSaleBy:DeaDTriX', amount)
                                    end
                                end
                        end
                    },
                }  
            }
        },
    }
end
