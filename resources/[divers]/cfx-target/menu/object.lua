function _Object()
    Action_Config = {
        Object = {
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                CloseOnClick = true,
                Label = "Information de l'object",

                Action = {
                    {
                        ("ID de l'objet : %s"):format(LastEntityHit),
                        function()
                        end
                    },
                    {
                        ("Model de l'objet : %s"):format(GetEntityModel(LastEntityHit)),
                        function()
                            SendNUIMessage({type = "copy", text = GetEntityModel(LastEntityHit)})
                        end
                    },
                    {
                        ("Owner de l'objet : %s"):format(NetworkGetEntityOwner(LastEntityHit)),
                        function()
                        end
                    },
                    {
                        ("Position : %s"):format(GetEntityCoords(LastEntityHit)),
                        function()
                        end
                    },
                    {
                        ("Rotation : %s"):format(GetEntityRotation(LastEntityHit)),
                        function()
                        end
                    },
                    {
                        ("Type : %s"):format(GetEntityType(LastEntityHit)),
                        function()
                        end
                    },
                },    
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                CloseOnClick = true,
                Label = "Action Admin",

                Action = {
                    {
                        "Déplacé l'objet",
                        function()
                            Target:MouveEntity(LastEntityHit)
                        end
                    },
                    {
                        "Dupliqué",
                        function()
                            local new = Target:DuplicateEntity(LastEntityHit)
                            Target:MouveEntity(new)
                        end
                    },
                    {
                        "Suprimé",
                        function()
                            SetEntityAsMissionEntity(LastEntityHit, false, false)
                            DeleteObject(LastEntityHit)
                        end
                    },
                },    
            },
        },
    }
end

function _Soda()
    Action_Config = {
        Soda = {
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                Label = "Acheter",
                CloseOnClick = true,
                Action = {
                    {
                        'Coca-cola (~g~10$~s~)', 
                        function() 
                            playAnim('mp_common', 'givetake2_a', 2500)
                            Citizen.Wait(2500)
                            local item = 'coca'
                            local prix = 10
                            TriggerServerEvent('Acheter', item, prix)
                        end
                    },
                    {
                        'Eau (~g~10$~s~)', 
                        function() 
                            playAnim('mp_common', 'givetake2_a', 2500)
                            Citizen.Wait(2500)
                            local item = 'water'
                            local prix = 10
                            TriggerServerEvent('Acheter', item, prix)
                        end
                    },
                    {
                        'Fanta (~g~10$~s~)', 
                        function() 
                            playAnim('mp_common', 'givetake2_a', 2500)
                            Citizen.Wait(2500)
                            local item = 'fanta'
                            local prix = 10
                            TriggerServerEvent('Acheter', item, prix)
                        end
                    },
                },
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                CloseOnClick = true,
                Label = "Information de l'object",

                Action = {
                    {
                        ("ID de l'objet : %s"):format(LastEntityHit),
                        function()
                        end
                    },
                    {
                        ("Model de l'objet : %s"):format(GetEntityModel(LastEntityHit)),
                        function()
                            SendNUIMessage({type = "copy", text = GetEntityModel(LastEntityHit)})
                        end
                    },
                    {
                        ("Owner de l'objet : %s"):format(NetworkGetEntityOwner(LastEntityHit)),
                        function()
                        end
                    },
                    {
                        ("Position : %s"):format(GetEntityCoords(LastEntityHit)),
                        function()
                        end
                    },
                    {
                        ("Rotation : %s"):format(GetEntityRotation(LastEntityHit)),
                        function()
                        end
                    },
                    {
                        ("Type : %s"):format(GetEntityType(LastEntityHit)),
                        function()
                        end
                    },
                },    
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                Label = "Admin",
                Action = {
                    {
                        "Déplacé l'objet",
                        function() 
                            Target:MouveEntity(LastEntityHit)
                        end
                    },
                    {
                        "Dupliqué",
                        function() 
                            local new = Target:DuplicateEntity(LastEntityHit)
                            Target:MouveEntity(new)
                        end
                    },
                    {
                        "Suprimé",
                        function() 
                            SetEntityAsMissionEntity(LastEntityHit, false, false)
                            DeleteObject(LastEntityHit)
                        end
                    },
                },
            },
        },
    }
end

function _Coffee()
    Action_Config = {
        Coffee = {
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                Label = "Acheter",
                CloseOnClick = true,
                Action = {
                    {
                        'Café (~g~10$~s~)', 
                        function() 
                            playAnim('mp_common', 'givetake2_a', 2500)
                            Citizen.Wait(2500)
                            local item = 'coffee'
                            local prix = 10
                            TriggerServerEvent('Acheter', item, prix)
                        end
                    },
                },
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                CloseOnClick = true,
                Label = "Information de l'object",

                Action = {
                    {
                        ("ID de l'objet : %s"):format(LastEntityHit),
                        function()
                        end
                    },
                    {
                        ("Model de l'objet : %s"):format(GetEntityModel(LastEntityHit)),
                        function()
                            SendNUIMessage({type = "copy", text = GetEntityModel(LastEntityHit)})
                        end
                    },
                    {
                        ("Owner de l'objet : %s"):format(NetworkGetEntityOwner(LastEntityHit)),
                        function()
                        end
                    },
                    {
                        ("Position : %s"):format(GetEntityCoords(LastEntityHit)),
                        function()
                        end
                    },
                    {
                        ("Rotation : %s"):format(GetEntityRotation(LastEntityHit)),
                        function()
                        end
                    },
                    {
                        ("Type : %s"):format(GetEntityType(LastEntityHit)),
                        function()
                        end
                    },
                },    
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                Label = "Admin",
                Action = {
                    {
                        "Déplacé l'objet",
                        function() 
                            Target:MouveEntity(LastEntityHit)
                        end
                    },
                    {
                        "Dupliqué",
                        function() 
                            local new = Target:DuplicateEntity(LastEntityHit)
                            Target:MouveEntity(new)
                        end
                    },
                    {
                        "Suprimé",
                        function() 
                            SetEntityAsMissionEntity(LastEntityHit, false, false)
                            DeleteObject(LastEntityHit)
                        end
                    },
                },
            },
        },
    }
end

