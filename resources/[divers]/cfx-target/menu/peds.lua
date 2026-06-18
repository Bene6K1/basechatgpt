function _Peds()
    Action_Config = {
        Peds = {
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = false,
                Label = ("ID : %s"):format(LastEntityHit or "Inconnu"),
                OnClick = function()end,
            },            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = false,
                OnClick = function()
                    DeleteEntity(LastEntityHit)
                end,
                Label = "Supprimer",
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
                OnClick = function()
                    Target:MouveEntity(LastEntityHit)
                end,
                Label = "Déplacé",
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
                Label = "Téléporté sur lui",
                OnClick = function()
                    SetEntityCoords(PlayerPedId(), GetEntityCoords(LastEntityHit))
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
                Label = "Téléporté à moi",
                CloseOnClick = false,
                OnClick = function()
                    SetEntityCoords(LastEntityHit, GetEntityCoords(PlayerPedId()))
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
                Label = "Options arme",
                CloseOnClick = false,
                Action = {
                    {
                        "Donner une arme",
                        function()
                            local arme = exports["cfx-target"]:ShowSync("Arme a donner ? ( pas de weapon_ )", false, 320., "small_text")
                            GiveWeaponToPed(LastEntityHit, 'weapon_'..arme, 250, false, true)
                        end
                    },
                    {
                        "Retirer Toute ces armes",
                        function()
                            RemoveAllPedWeapons(LastEntityHit)
                        end
                    },
                },
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "mod", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "admin", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                Label = "Options apparence",
                CloseOnClick = false,
                Action = {
                    {
                        "Prendre l'aparence",
                        function()
                            model = GetEntityModel(LastEntityHit)
                            SetPlayerModel(PlayerId(), model)
                            SetPedDefaultComponentVariation(PlayerPedId())
                        end
                    },
                    {
                        "Reprendre son apparence",
                        function()
                             ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                local isMale = skin.sex == 0
                                TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                        TriggerEvent('skinchanger:loadSkin', skin)
                                        TriggerEvent('esx:restoreLoadout')
                                    end)
                                end)
                            end)
                        end
                    },
                    {
                        "Changer la tenue",
                        function()
                            SetPedRandomComponentVariation(LastEntityHit, true)
                        end
                    },
                },
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "mod", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "admin", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                Label = "Options Mobilité",
                CloseOnClick = false,
                Action = {
                    {
                        "Rendre immobile",
                        function()
                            FreezeEntityPosition(LastEntityHit, true)
                        end
                    },
                    {
                        "Rendre mobile",
                        function()
                             FreezeEntityPosition(LastEntityHit, false)
                         end
                    },
                    {
                        "Rendre invincible",
                        function()
                            SetEntityInvincible(LastEntityHit, true)
                        end
                    },
                    {
                        "Faire fuir",
                        function()
                            TaskSmartFleePed(LastEntityHit, PlayerPedId(), 100.0, -1, false, false)
                        end
                    },
                    {
                        "Apaiser",
                        function()
                            ClearPedTasksImmediately(LastEntityHit)
                        end
                    },
                },
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "mod", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "admin", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = true,
                Label = "Faire les poches",
                OnClick = function()
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)
                    local npcCoords = GetEntityCoords(LastEntityHit)
                    local distance = #(playerCoords - npcCoords)
                    
                    if distance > 1.5 then
                        if GetResourceState('nc-pickpocket') == 'started' then
                            TriggerEvent('nc-pickpocket:client:notify', "Vous devez être plus proche du PNJ", "error")
                        else
                            TriggerEvent('chat:addMessage', {
                                color = {255, 0, 0},
                                multiline = true,
                                args = {"Erreur", "Vous devez être plus proche du PNJ"}
                            })
                        end
                        return
                    end
                    
                    if not IsPedAPlayer(LastEntityHit) and 
                       not IsPedDeadOrDying(LastEntityHit, 1) and 
                       not IsPedInAnyVehicle(LastEntityHit, false) then
                        
                        if GetResourceState('nc-pickpocket') == 'started' then
                            TriggerEvent('nc-pickpocket:client:startPickpocket', LastEntityHit)
                        else
                            TriggerEvent('chat:addMessage', {
                                color = {255, 255, 0},
                                multiline = true,
                                args = {"Info", "Le système de pickpocket n'est pas disponible"}
                            })
                        end
                    else
                        TriggerEvent('chat:addMessage', {
                            color = {255, 0, 0},
                            multiline = true,
                            args = {"Erreur", "Ce PNJ ne peut pas être pickpocketé"}
                        })
                    end
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
                Label = "Animations",
                CloseOnClick = true,
                Action = {
                    {
                        'Donner une claque',
                        function()
                            pram = {
                                ['Requester'] = {
                                    ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'plyr_takedown_front_slap', ['Flags'] = 0,
                                },
                                ['Accepter'] = {
                                    ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'victim_takedown_front_slap', ['Flags'] = 0, ['Attach'] = {
                                        ['Bone'] = 9816,
                                        ['xP'] = 0.05,
                                        ['yP'] = 1.15,
                                        ['zP'] = -0.05,
                                    
                                        ['xR'] = 0.0,
                                        ['yR'] = 0.0,
                                        ['zR'] = 180.0,
                                    }
                                }
                            }
                            ClearPedTasksImmediately(LastEntityHit)
                            ClearPedTasksImmediately(PlayerPedId())
                            RequestAnimDict(pram['Requester']['Dict'])
                            while not HasAnimDictLoaded(pram['Requester']['Dict']) do
                                print("Chargement de l'animation en cours...")
                                Citizen.Wait(0)
                            end
                            AttachEntityToEntity(PlayerPedId(), LastEntityHit, GetPedBoneIndex(LastEntityHit, pram['Accepter']['Attach']['Bone']), pram['Accepter']['Attach']['xP'], pram['Accepter']['Attach']['yP'], pram['Accepter']['Attach']['zP'], pram['Accepter']['Attach']['xR'], pram['Accepter']['Attach']['yR'], pram['Accepter']['Attach']['zR'], true, true, false, true, 1, true)
                            TaskPlayAnim(PlayerPedId(), pram['Requester']['Dict'], pram['Requester']['Anim'], 8.0, -8.0, -1, pram['Requester']['Flags'], 0, false, false, false)
                            TaskPlayAnim(LastEntityHit, pram['Accepter']['Dict'], pram['Accepter']['Anim'], 8.0, -8.0, -1, pram['Accepter']['Flags'], 0, false, false, false)
                            Citizen.Wait(1000)
                            while IsEntityPlayingAnim(PlayerPedId(), pram['Requester']['Dict'], pram['Requester']['Anim'], 3) do
                                Citizen.Wait(0)
                            end
                            DetachEntity(PlayerPedId(), true, false)
                            ClearPedTasksImmediately(LastEntityHit)
                            ClearPedTasksImmediately(PlayerPedId())
                        end,
                    },
                    {
                        'Serrer la main',
                        function()
                            pram = {
                                ['Requester'] = {
                                    ['Type'] = 'animation', ['Dict'] = 'mp_common', ['Anim'] = 'givetake1_a', ['Flags'] = 0,
                                },
                                ['Accepter'] = {
                                    ['Type'] = 'animation', ['Dict'] = 'mp_common', ['Anim'] = 'givetake1_b', ['Flags'] = 0, ['Attach'] = {
                                        ['Bone'] = 9816,
                                        ['xP'] = 0.075,
                                        ['yP'] = 1.0,
                                        ['zP'] = 0.0,
                        
                                        ['xR'] = 0.0,
                                        ['yR'] = 0.0,
                                        ['zR'] = 180.0,
                                    }
                                }
                            }
                            ClearPedTasksImmediately(LastEntityHit)
                            ClearPedTasksImmediately(PlayerPedId())
                            RequestAnimDict(pram['Requester']['Dict'])
                            while not HasAnimDictLoaded(pram['Requester']['Dict']) do
                                print("Chargement de l'animation en cours...")
                                Citizen.Wait(0)
                            end
                            AttachEntityToEntity(PlayerPedId(), LastEntityHit, GetPedBoneIndex(LastEntityHit, pram['Accepter']['Attach']['Bone']), pram['Accepter']['Attach']['xP'], pram['Accepter']['Attach']['yP'], pram['Accepter']['Attach']['zP'], pram['Accepter']['Attach']['xR'], pram['Accepter']['Attach']['yR'], pram['Accepter']['Attach']['zR'], true, true, false, true, 1, true)
                            TaskPlayAnim(PlayerPedId(), pram['Requester']['Dict'], pram['Requester']['Anim'], 8.0, -8.0, -1, pram['Requester']['Flags'], 0, false, false, false)
                            TaskPlayAnim(LastEntityHit, pram['Accepter']['Dict'], pram['Accepter']['Anim'], 8.0, -8.0, -1, pram['Accepter']['Flags'], 0, false, false, false)
                            Citizen.Wait(1000)
                            while IsEntityPlayingAnim(PlayerPedId(), pram['Requester']['Dict'], pram['Requester']['Anim'], 3) do
                                Citizen.Wait(0)
                            end
                            DetachEntity(PlayerPedId(), true, false)
                            ClearPedTasksImmediately(LastEntityHit)
                            ClearPedTasksImmediately(PlayerPedId())
                        end,
                    },

                },
            },
        },
    }
end