function _Ground()
    Action_Config = {
        Ground = {
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "mod", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "admin", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                                             -- SI VOUS NE METTEZ RIEN DANS LES "" ALORS LE GROUPE NE POURRA PAS VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = false,
                Label = "Afficher un message (temporaire)",
                OnClick = function()
                    local text = exports["cfx-target"]:ShowSync('Text ?', false, 320, "small_text")
                    local taille = exports["cfx-target"]:ShowSync('Taille ?', false, 320, "small_text")
                    local distance = exports["cfx-target"]:ShowSync('Distance ?', false, 320, "small_text")
                    local coords = LastCoordsHit
                    while true do
                        Citizen.Wait(0) 
                        if GetDistanceBetweenCoords(coords, GetEntityCoords(GetPlayerPed(-1))) < distance + 0.0 then
                            ESX.Game.Utils.DrawText3D(coords, text, taille)
                        end
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
                                             -- SI VOUS NE METTEZ RIEN DANS LES "" ALORS LE GROUPE NE POURRA PAS VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = false,
                Label = "Vous téléporter ici",
                OnClick = function()
                    SetEntityCoords(PlayerPedId(), LastCoordsHit)
                end,
            },
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "mod", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "admin", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "_dev", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE& TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "owner", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                                             -- SI VOUS NE METTEZ RIEN DANS LES "" ALORS LE GROUPE NE POURRA PAS VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = false,
                Label = "Déposer un objet",
                OnClick = function()
                    obj_model = exports["cfx-target"]:ShowSync('model', false, 320, "small_text")
                    if IsModelValid(obj_model) then
                        RequestModel(obj_model)
                        while not HasModelLoaded(obj_model) do
                            Wait(0)
                        end
                        obj = CreateObject(obj_model, LastCoordsHit, true, true, true)
                        SetEntityAsMissionEntity(obj, true, true)
                        SetModelAsNoLongerNeeded(obj_model)
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
                                             -- SI VOUS NE METTEZ RIEN DANS LES "" ALORS LE GROUPE NE POURRA PAS VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = false,
                Label = "Posé un véhicule",
                OnClick = function()
                    veh_model = exports["cfx-target"]:ShowSync('model', false, 320, "small_text")
                    if IsModelValid(veh_model) then
                        RequestModel(veh_model)
                        while not HasModelLoaded(veh_model) do
                            Wait(0)
                        end
                        veh = CreateVehicle(veh_model, LastCoordsHit, GetEntityHeading(PlayerPedId()), true, true)
                        SetEntityAsMissionEntity(veh, true, true)
                        SetVehicleOnGroundProperly(veh)
                        SetModelAsNoLongerNeeded(veh_model)
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
                                             -- SI VOUS NE METTEZ RIEN DANS LES "" ALORS LE GROUPE NE POURRA PAS VOIR LE BOUTON !

                Type = "buttom",
                CloseOnClick = false,
                Label = "Posé un peds",
                OnClick = function()
                    ped_model = exports["cfx-target"]:ShowSync('Peds', false, 320., "small_text")
                    if IsModelValid(ped_model) then
                        RequestModel(ped_model)
                        while not HasModelLoaded(ped_model) do
                            Wait(0)
                        end
                        ped = CreatePed(4, ped_model, LastCoordsHit, GetEntityHeading(PlayerPedId()), true, true)
                        SetEntityAsMissionEntity(ped, true, true)
                        SetModelAsNoLongerNeeded(ped_model)
                    end
                end,
            },
        },
    }
end

