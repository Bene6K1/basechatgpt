function _sky()
    Action_Config = {
        Sky = {
            {
                user = "user", -- SI VOUS METTEZ "user" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                mod = "moderateur", -- SI VOUS METTEZ "mod" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                admin = "administrateur", -- SI VOUS METTEZ "admin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                superadmin = "superadmin", -- SI VOUS METTEZ "superadmin" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                _dev = "gerant", -- SI VOUS METTEZ "_dev" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !
                owner = "fondateur", -- SI VOUS METTEZ "owner" CELA VOUDRA DIRE QUE TOUTE PERSONNE AVEC LE GRADE USER POURRA VOIR LE BOUTON !

                Type = "buttom-submenu",
                Label = "Changer l'heure",
                Action = {
                    {
                        'Matin', 
                        function() 
                            ExecuteCommand("time 8 00")
                        end
                    },
                    {
                        'Après-midi', 
                        function() 
                            ExecuteCommand("time 12 00")
                        end
                    },
                    {
                        'Soirée', 
                        function() 
                            ExecuteCommand("time 18 00")
                        end
                    },
                    {
                        'Nuit', 
                        function() 
                            ExecuteCommand("time 22 00")
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
                Label = "Changer la météo",
                Action = {
                    {
                        'Clear', 
                        function() 
                            ExecuteCommand("weather clear")
                        end
                    },
                    {
                        'Clearing', 
                        function() 
                            ExecuteCommand("weather clearing")
                        end
                    },
                    {
                        'Clouds', 
                        function() 
                            ExecuteCommand("weather clouds")
                        end
                    },
                    {
                        'Extra Sunny', 
                        function() 
                            ExecuteCommand("weather extrasunny")
                        end
                    },
                    {
                        'Foggy', 
                        function() 
                            ExecuteCommand("weather foggy")
                        end
                    },
                    {
                        'Overcast', 
                        function() 
                            ExecuteCommand("weather overcast")
                        end
                    },
                    {
                        'Rain', 
                        function() 
                            ExecuteCommand("weather rain")
                        end
                    },
                    {
                        'Smog', 
                        function() 
                            ExecuteCommand("weather smog")
                        end
                    },
                    {
                        'Thunder', 
                        function() 
                            ExecuteCommand("weather thunder")
                        end
                    },
                    {
                        'Xmas', 
                        function() 
                            ExecuteCommand("weather xmas")
                        end
                    },
                },
            },
        },
    }
end
