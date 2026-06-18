function _Vehicule()
    Action_Config = {
        Vehicule = {
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "moderateur" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "administrateur" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "gerant" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "fondateur" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                Label = "~r~Information Véhicule",
                CloseOnClick = false,
                Action = {
                    {
                        ("Nom du véhicule : %s"):format(GetDisplayNameFromVehicleModel(GetEntityModel(LastEntityHit))),
                        function()
                        end
                    },
                    {
                        ("ID du véhicule : %s"):format(LastEntityHit),
                        function()
                        end
                    },
                    {
                        ("Plaque du véhicule : %s"):format(GetVehicleNumberPlateText(LastEntityHit)),
                        function()
                        end
                    },
                },
            },            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "moderateur" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "administrateur" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "gerant" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "fondateur" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                Label = "Porte",
                CloseOnClick = false,
                Action = {
                    {
                        'Avant Gauche',
                        function()
                            dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(LastEntityHit))
                            if dist < 3 then
                                if GetVehicleDoorAngleRatio(LastEntityHit, 0) == 0 then
                                    SetVehicleDoorOpen(LastEntityHit, 0, false, false)
                                else
                                    SetVehicleDoorShut(LastEntityHit, 0, false)
                                end
                            end
                        end
                    },
                    {
                        'Avant Droite',
                        function()
                            dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(LastEntityHit))
                            if dist < 3 then
                                if GetVehicleDoorAngleRatio(LastEntityHit, 1) == 0 then
                                    SetVehicleDoorOpen(LastEntityHit, 1, false, false)
                                else
                                    SetVehicleDoorShut(LastEntityHit, 1, false)
                                end
                            end
                        end
                    },
                    {
                        'Arrière Gauche',
                        function()
                            dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(LastEntityHit))
                            if dist < 3 then
                                if GetVehicleDoorAngleRatio(LastEntityHit, 2) == 0 then
                                    SetVehicleDoorOpen(LastEntityHit, 2, false, false)
                                else
                                    SetVehicleDoorShut(LastEntityHit, 2, false)
                                end
                            end
                        end
                    },
                    {
                        'Arrière Droite',
                        function()
                            dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(LastEntityHit))
                            if dist < 3 then
                                if GetVehicleDoorAngleRatio(LastEntityHit, 3) == 0 then
                                    SetVehicleDoorOpen(LastEntityHit, 3, false, false)
                                else
                                    SetVehicleDoorShut(LastEntityHit, 3, false)
                                end
                            end
                        end
                    },
                    {
                        'Capot',
                        function()
                            dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(LastEntityHit))
                            if dist < 3 then
                                if GetVehicleDoorAngleRatio(LastEntityHit, 4) == 0 then
                                    SetVehicleDoorOpen(LastEntityHit, 4, false, false)
                                else
                                    SetVehicleDoorShut(LastEntityHit, 4, false)
                                end
                            end
                        end
                    },
                    {
                        'Coffre',
                        function()
                            dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(LastEntityHit))
                            if dist < 3 then
                                if GetVehicleDoorAngleRatio(LastEntityHit, 5) == 0 then
                                    SetVehicleDoorOpen(LastEntityHit, 5, false, false)
                                else
                                    SetVehicleDoorShut(LastEntityHit, 5, false)
                                end
                            end
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
                Label = "Moteur "..DisplayStateEngine,
                CloseOnClick = false,
                Action = {
                    {
                        'ON',
                        function()
                            StateEngine = true
                            DisplayStateEngine = "~g~Allumé"
                                SetVehicleEngineOn(LastEntityHit, true, false, true)
                                SetVehicleUndriveable(LastEntityHit, false)
                        end
                    },
                    {
                        'OFF',
                        function()
                            StateEngine = false
                            DisplayStateEngine = "~r~Éteint"
                                SetVehicleEngineOn(LastEntityHit, false, true, true)
                                SetVehicleUndriveable(LastEntityHit, true)
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

                Type = "buttom",
                CloseOnClick = false,
                OnClick = function()
                    SetVehicleFuelLevel(LastEntityHit, 100.0)
                end,
                Label = "Mettre de l'essence",
            },            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = true,
                OnClick = function()
                    local plaque = exports["cfx-target"]:ShowSync('Plaque ? ( MAX 8 )', false, 8., "small_text")
                    SetVehicleNumberPlateText(LastEntityHit, plaque)
                end,
                Label = "Changer la plaque",
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
                   NetworkExplodeVehicle(LastEntityHit, true, true)
                end,
                Label = "Exploser le véhicule",
            },            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = true,
                OnClick = function()
                    Target:MouveEntity(LastEntityHit)
                end,
                Label = "Déplacé",
            },            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = true,                OnClick = function()
                    DeleteEntity(LastEntityHit)
                end,
                Label = "Supprimé",
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = false,
                Label = "Réparer",                OnClick = function()
                    SetVehicleFixed(LastEntityHit)
                end,   
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = false,
                Label = "Nettoyer",                OnClick = function()
                    SetVehicleDirtLevel(LastEntityHit, 0.0)
                end,   
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = false,
                Label = "Déverrouiller",
                OnClick = function()
                local playerPed = PlayerPedId()
                local vehicle = ESX.Game.GetVehicleInDirection()
                local coords = GetEntityCoords(playerPed)
                    SetVehicleDoorsLocked(vehicle, 1)
                    SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                    ESX.ShowNotification('Déverrouillage effectuer avec succès')
                end
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
                Label = "S'attribuer le véhicule",
                OnClick = function()
                    local giveplate = GetVehicleNumberPlateText(LastEntityHit)
                    local vehicleProps = ESX.Game.GetVehicleProperties(LastEntityHit)
                    TriggerServerEvent('DeaDTriX:GiveVehicule', vehicleProps, giveplate)
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
                Label = "Custom",
                OnClick = function()
                    OnCustom(LastEntityHit)
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
                Label = "Rendre immobile",
                OnClick = function()
                    FreezeEntityPosition(LastEntityHit, true)
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
                Label = "Rendre mobile",
                OnClick = function()
                    FreezeEntityPosition(LastEntityHit, false)
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
                Label = "Rotation",
                OnClick = function()
                    local rota = exports["cfx-target"]:ShowSync('Nombre de degré ?', false, 320., "small_text")
                    SetEntityHeading(LastEntityHit, GetEntityHeading(LastEntityHit) + rota)
                end,
            },

        }, 
    }
end


