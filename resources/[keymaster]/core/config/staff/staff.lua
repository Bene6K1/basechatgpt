SunnyTPAdmin = {   

    TeleportLocations = {
    { label = "Recolte Weed", coords = vector3(1060.5313720703, -3193.3864746094, -39.140571594238)},
    { label = "Point B", coords = vector3(1060.53, -3193.38, -39.14) },
    -- Ajoutez d'autres points de téléportation ici
},

 }

 Config = {
    Staff = {},
}

Config.Staff.NoClip = {
    vitessenormalnoclip = "0.8", -- Vitesse du Noclip quand tu marche
    vitessespeednoclip = "12", -- Vitesse du Noclip quand tu cours
    vitesseslownoclip = "0.2", -- Vitesse du Noclip quand tu maintiens ALT
    touchewnoclip = "F3",
}

-- Position du HUD Staff (pourcentage de l'écran)
-- x: 50 = centré, 0 = gauche, 100 = droite
-- y: 12 = haut (valeur par défaut), augmenter pour descendre
Config.Staff.HudPosition = {
    x = 50,  -- Position horizontale (%)
    y = 12,  -- Position verticale (vh)
}

Config.Staff.Permissions = {
    Menu = {
        ['openMenu'] = {
            ['*'] = true
        },
        ['personnalOptions'] = {
            ['*'] = true
        },
        ['serverOptions'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
        },
        ['vehiclesOptions'] = {
            ['*'] = true
        },
        ['playersList'] = {
            ['*'] = true
        },
        ['staffsList'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = false,
            ['gerant'] = false,
            ['superadmin'] = false,
            ['administrateur'] = false,
        },
        ['uniqueidOptions'] = {
            ['*'] = true
        },
        ['reports'] = {
            ['*'] = true,
        },
        ['events'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true
        },
    },

    OutFit = {
        ['Data'] = {
            ['gerant'] = false,
            ['responsable'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
            ['moderateur'] = true,
            ['helpeur'] = true, 
        }
    },

    Modules = {
        ['noClip'] = {
            ['*'] = true
        },
        ['gamerTags'] = {
            ['*'] = true
        },
        ['blips'] = {
            ['*'] = true
        },
        ['reportsInfos'] = {
            ['*'] = true
        },
        ['reportsSong'] = {
            ['*'] = true
        },
        ['objects'] = {
            ['*'] = true
        },
        ['gunInfos'] = {
            ['fondateur'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
        },
        ['weather'] = {
            ['fondateur'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
        },
        ['tptkt'] = {
            ['fondateur'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
        },
    },

    VehicleKeys = {
        ['carkey'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
        }
    },

    VehiclesOptions = {
        ['delveh'] = {
            ['*'] = true,
        },
        ['repairveh'] = {
             ['*'] = true
        },
        ['delvehzone'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
        },
        ['repairvehzone'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
        },
        ['cleanVehicle'] = {
            ['*'] = true
        },
        ['spawnveh'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
        },
        ['fullcustom'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
        },
        ['returnveh'] = {
            ['*'] = true
        },
        ['freezeunfreeze'] = {
            ['*'] = true
        }
    },

    ManagePlayers = {
        ['goto'] = {
            ['*'] = true
        },
        ['bring'] = {
            ['*'] = true
        },
        ['screen'] = {
            ['*'] = false
        },
        ['spectate'] = {
            ['*'] = true
        },
        ['Message'] = {
            ['*'] = true,
        },
        ['revive'] = {
            ['*'] = true
        },
        ['heal'] = {
            ['*'] = true
        },
        ['gopc'] = {
            ['*'] = true
        },
        ['gomb'] = {
            ['*'] = true
        },
        ['givepanto'] = {
            ['*'] = true
        },
        ['clearinventory'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
        },
        ['clearweapons'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
        },
        ['playerinformations'] = {
            ['*'] = true
        },
        ['changejob'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true
        },
        ['changegroup'] = {
            ['fondateur'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
        },
        ['wipe'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true
        },
        WARN = {
            ['*'] = true
        }
    },

    ServerOptions = {
        ['announce'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
        },
        ['restartServer'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['gerant'] = true,
        },
        ['boutiqueManagement'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['gerant'] = true,
        },
        ['creategarage'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
        }, 
        ['fondateur'] = {
            ['fondateur'] = true
        },
        ['creategang'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
        }, 
        ['CreateBlanchiment'] = {
            ['fondateur'] = true,
            ['developper'] = true,
        }, 
        ['createentreprise'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
        }, 
        ['createsociety'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
        },
        ['editsociety'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['gerant'] = true,
            ['responsable'] = true,
        },
        ['weaponsSell'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['gerant'] = true,
            ['responsable'] = true,
        },
        ['createDrugs'] = {
            ['fondateur'] = true,
            ['gerant'] = true,
            ['responsable'] = true,
        }
    },

    UniqueIDoptions = {
        ['clearmoney'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
        },
        ['clearinventory'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
        },
        ['clearweaon'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
        },
        ['boutiquehistory'] = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
        },
        GIVE_MONEY = {
            ['fondateur'] = true,
            ['developper'] = true,
            -- ['responsable'] = true,
            ['gerant'] = true,
            -- ['superadmin'] = true,
            -- ['administrateur'] = true,
        },
        GIVE_WEAPON = {
            ['fondateur'] = true,
            ['developper'] = true,
            -- ['responsable'] = true,
            ['gerant'] = true,
            -- ['superadmin'] = true,
            -- ['administrateur'] = true,
        },
        GIVE_ITEM = {
            ['fondateur'] = true,
            ['developper'] = true,
            -- ['responsable'] = true,
            ['gerant'] = true,
            -- ['superadmin'] = true,
            -- ['administrateur'] = true,
        },
        GIVE_VEHICLE = {
            ['fondateur'] = true,
            ['developper'] = true,
            -- ['responsable'] = true,
            ['gerant'] = true,
            -- ['superadmin'] = true,
            -- ['administrateur'] = true,
        }
    },

    ['ServerGroup'] = {
        ['fondateur'] = {
            ['user'] = {label = 'Joueur', value = 'user', id = 8},
            ['helpeur'] = {label = 'Helpeur', value = 'helpeur',id = 7},
            ['moderateur'] = {label = 'Modérateur', value = 'moderateur', id = 6},
            ['administrateur'] = {label = 'Administrateur', value = 'administrateur', id = 5},
            ['superadmin'] = {label = 'Super-Administrateur', value = 'superadmin', id = 4},
            ['responsable'] = {label = 'Responsable', value = 'responsable', id = 3},
            ['gerant'] = {label = 'Gérant', value = 'gerant', id = 2},
            ['fondateur'] = {label = 'Fondateur', value = 'fondateur', id = 1},
        },
        ['gerant'] = {
            ['user'] = {label = 'Joueur', value = 'user', id = 6},
            ['helpeur'] = {label = 'Helpeur', value = 'helpeur',id = 5},
            ['moderateur'] = {label = 'Modérateur', value = 'moderateur', id = 4},
            ['administrateur'] = {label = 'Administrateur', value = 'administrateur', id = 3},
            ['superadmin'] = {label = 'Super-Administrateur', value = 'superadmin', id = 2},
            ['responsable'] = {label = 'Responsable', value = "responsable", id = 1},
        },
        ['responsable'] = {
            ['user'] = {label = 'Joueur', value = 'user', id = 5},
            ['helpeur'] = {label = 'Helpeur', value = 'helpeur',id = 4},
            ['moderateur'] = {label = 'Modérateur', value = 'moderateur', id = 3},
            ['administrateur'] = {label = 'Administrateur', value = 'administrateur', id = 2},
            ['superadmin'] = {label = 'Super-Administrateur', value = 'superadmin', id = 1},
        },
    },

    COMMANDS = {
        BAN = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['moderateur'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
        },
        UNBAN = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['moderateur'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
        },
        KICK = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['responsable'] = true,
            ['gerant'] = true,
            ['moderateur'] = true,
            ['superadmin'] = true,
            ['administrateur'] = true,
        },
        JAIL = {
            ['*'] = true,
        }
    },

    VIP = {
        ADD = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['gerant'] = true,
        },
        REMOVE = {
            ['fondateur'] = true,
            ['developper'] = true,
            ['gerant'] = true,
        }
    }
}

Config.Staff.Group = {
    ['fondateur'] = '~r~Fondateur~s~',         -- Rouge
    ['gerant'] = '~o~Gérant~s~',              -- Orange
    ['responsable'] = '~o~Responsable~s~',    -- Orange
    ['superadmin'] = '~p~Super-Admin~s~',     -- Violet
    ['administrateur'] = '~b~Administrateur~s~', -- Bleu
    ['moderateur'] = '~g~Modérateur~s~',      -- Vert
    ['helpeur'] = '~g~Helpeur~s~',            -- Vert
    ['user'] = '~c~Joueur~s~'                 -- Gris
}

Config.Staff.GamertagsGroup = {
    ['fondateur'] = 208,
    ['gerant'] = 180,
    ['responsable'] = 147,
    ['superadmin'] = 142,
    ['administrateur'] = 143,
    ['moderateur'] = 141,
    ['helpeur'] = 137,
    ['user'] = 0
}

Config.eventsMenu = {
    ["Attaque Territoire"] = {
        menu =  {
            ['zone'] =  {
                label = "Territoire",
                description = false,
                type = 'list',
                list = {},
                index = 1,
            },

            ['attacker'] =  {
                label = "Groupe Attaquant",
                description = "Choissiez un groupe attaquant",

                action = function()
                    local result = ""
                    local name = ZGEG.GetTextInput("Groupe")

                    if name and name ~= nil and name ~= '' then
                        result = name
                    end

                    return result
                end
            },

            ['time'] =  {
                label = "Durée de l'attaque",
                description = "Temps en minutes.",
                action = function()
                    local result = ZGEG.GetNumberInput("Durée")
                    if result == nil then
                        ZGEG.ShowNotification("~r~La durée doit être un nombre")

                        return nil
                    end

                    return result
                end
            }
        },

        preview = function()

        end,

        event = function (result)
            local zoneId = exports.Slide:getZoneByName(result.zone)
            TriggerServerEvent("territories:createRaid", zoneId, result.attacker, result.time)
        end,
    },
    ["Braquage Véhicule (Attaque)"] = {
        menu =  {
            ['name'] =  {
                label = "Nom",
                description = "Le nom par défault est 'Fourgon Blindé'.",
                action = function()
                    local result =  "Fourgon Blindé"
                    local name = KeyboardInput("Nom", "Nom", "", 30)
                    if name and name ~= nil and name ~= '' then
                        result = name
                    end

                    return result
                end
            },
            ['vehicle'] =  {
                label = "Véhicule",
                description = "Le modèle du fourgon blindé (stockade) est défini par défault.\n\nVéhicule terrestre conseillé : stockade.\nVéhicule aquatique conseillé : tug.",
                action = function(entity)
                    if entity and DoesEntityExist(entity) then
                        DeleteEntity(entity)
                    end

                    local vehicle = "stockade"
                    local result = KeyboardInput("Modele", "Modele", "", 12)
                    
                    if result ~= nil and result ~= "" then
                        vehicle = result 
                    end

                    return vehicle, handlePreviewEventEntity(vehicle, 'vehicle')
                end
            },

            ['duration'] =  {
                label = "Durée de l'evenement",
                description = "Le temps doit être défini en secondes.",
                action = function()
                    local time = 180
                    local result = KeyboardInput("Temps", "Temps", "", 3)
                    
                    if result ~= nil and result ~= "" then
                        result = tonumber(result)

                        if result > 0 and result ~= nil then
                            time = result
                        end
                    end

                    return time
                end
            },

            ['rewards'] = {
                label = "Nombre de palettes",
                description = "Le nombre maximal est 20.",
                action = function()
                    local amount = 12
                    local result = KeyboardInput("Palettes", "Palettes", "", 2)
                    
                    if result ~= nil and result ~= "" then
                        result = tonumber(result)

                        if result > 0 and result <= 20 and result ~= nil then
                            amount = result
                        end
                    end

                    return amount
                end
            },
        },

        event = function(result)
            TriggerServerEvent('sunny:admin:vents:van:server:create', result.position, result.heading, result.rewards, result.duration, result.vehicle or 'stockade', result.name or "Fourgon Blindé")
        end,

        previewType = 'vehicle',
        preview = function(entity)
            if entity == nil then return end
            local entity = entity
            local position = GetCoordsFromGamePlayCameraPointAtSynced(PlayerPedId())
            local heading = GetEntityHeading(entity)

            EnableControlAction(0, 14, true)
            if IsControlPressed(0, 14) then
                heading += 4.5
            end

            EnableControlAction(0, 15, true)
            if IsControlPressed(0, 15) then
                heading -= 4
            end

            ground, newZ = GetGroundZFor_3dCoord(position.x, position.y, position.z + 0.5)

            if ground then
                local newPosition = vector3(position.x, position.y, newZ)
                SetEntityCoords(entity, newPosition)
                SetEntityHeading(entity, heading)
            end
        end
    },
}

Config.Staff.HavePermission = function(permissionsCategorie, permissionName, player)

    if not permissionsCategorie then return end
    if not permissionName then return end

    -- client

    if not player then
        if Config.Staff.Permissions[permissionsCategorie][permissionName]['*'] then
            if Player.group ~= 'user' then
                return true
            end
        elseif Config.Staff.Permissions[permissionsCategorie][permissionName][Player.group] then
            return true
        else
            return false
        end
    end

    -- server

    if not (player) then return false end
    local group = player.getGroup()
    if Config.Staff.Permissions[permissionsCategorie][permissionName]['*'] then
        return true
    elseif Config.Staff.Permissions[permissionsCategorie][permissionName][group] then
        return true
    else
        return false
    end
end

--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                         CONFIGURATION REPORTS                              ║
    ║                   Système d'avis staff sur fermeture                       ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
]]

Config.Staff.Reports = {
    -- ═══════════════════════════════════════════════════════════════════════════
    -- MODAL DE CLOTURE
    -- ═══════════════════════════════════════════════════════════════════════════
    Modal = {
        Title = "Clôture du Report",                    -- Titre de la modal (le #ID sera ajouté automatiquement)
        RequireReview = true,                           -- Obliger l'avis avant de clore
        MinCharacters = 10,                             -- Nombre minimum de caractères pour l'avis
        MaxCharacters = 500,                            -- Nombre maximum de caractères pour l'avis
    },

    -- ═══════════════════════════════════════════════════════════════════════════
    -- OPTIONS DE RESOLUTION
    -- Valeurs possibles pour le type de résolution
    -- ═══════════════════════════════════════════════════════════════════════════
    Resolutions = {
        { value = "resolved",       label = "Résolu",                   emoji = "✅", color = "#00FF00", default = true },
        { value = "no_action",      label = "Aucune action nécessaire", emoji = "ℹ️",  color = "#3498DB" },
        { value = "warned",         label = "Joueur averti",            emoji = "⚠️", color = "#F39C12" },
        { value = "sanctioned",     label = "Sanction appliquée",       emoji = "🔨", color = "#E74C3C" },
        { value = "duplicate",      label = "Report dupliqué",          emoji = "📋", color = "#9B59B6" },
        { value = "invalid",        label = "Report invalide",          emoji = "❌", color = "#95A5A6" },
        { value = "transferred",    label = "Transféré",                emoji = "➡️", color = "#1ABC9C" },
        { value = "pending_info",   label = "En attente d'infos",       emoji = "⏳", color = "#F1C40F" },
    },

    -- ═══════════════════════════════════════════════════════════════════════════
    -- NOTIFICATIONS
    -- Messages envoyés aux joueurs et staff
    -- ═══════════════════════════════════════════════════════════════════════════
    Notifications = {
        -- Message envoyé au joueur quand son report est clôturé
        PlayerClosed = "💯 Votre report a été clôturé ! N'hésitez pas à recontacter l'équipe d'assistance si vous avez de nouveau un problème ou une question.",

        -- Message affiché au staff quand il clôture avec succès
        StaffSuccess = "✅ Report clôturé avec succès",

        -- Message affiché au staff quand il annule
        StaffCancelled = "❌ Clôture annulée",

        -- Message quand un nouveau report arrive (pour les staff)
        NewReport = "Un nouveau report a été reçu du joueur ~b~#%s~s~",

        -- Message quand un staff prend un report
        ReportTaken = "⭐ Le staff %s a pris en charge le report #%s",
    },

    -- ═══════════════════════════════════════════════════════════════════════════
    -- WEBHOOK DISCORD
    -- Configuration de l'envoi vers Discord
    -- ═══════════════════════════════════════════════════════════════════════════
    Discord = {
        Enabled = true,                                 -- Activer l'envoi vers Discord
        Channel = "staff_close_report",                 -- Nom du channel dans externalEvents

        -- Couleurs des embeds selon le type de résolution
        Colors = {
            resolved        = "#2ECC71",    -- Vert
            no_action       = "#3498DB",    -- Bleu
            warned          = "#F39C12",    -- Orange
            sanctioned      = "#E74C3C",    -- Rouge
            duplicate       = "#9B59B6",    -- Violet
            invalid         = "#95A5A6",    -- Gris
            transferred     = "#1ABC9C",    -- Turquoise
            pending_info    = "#F1C40F",    -- Jaune
            default         = "#7F00FF",    -- Violet par défaut
        },

        -- Champs à inclure dans l'embed Discord
        Fields = {
            ShowAdmin           = true,     -- Afficher le nom de l'admin
            ShowAdminIdentifier = true,     -- Afficher l'identifiant unique de l'admin
            ShowReportID        = true,     -- Afficher l'ID du report
            ShowPlayerSource    = true,     -- Afficher la source du joueur
            ShowDiscord         = true,     -- Afficher le Discord de l'admin
            ShowResolution      = true,     -- Afficher le type de résolution
            ShowReview          = true,     -- Afficher l'avis du staff
            ShowTimestamp       = true,     -- Afficher l'heure de clôture
        },
    },

    -- ═══════════════════════════════════════════════════════════════════════════
    -- STATISTIQUES
    -- Configuration pour le tracking des stats staff
    -- ═══════════════════════════════════════════════════════════════════════════
    Stats = {
        TrackWeekly     = true,             -- Tracker les reports hebdomadaires
        TrackTotal      = true,             -- Tracker le total des reports
        CountableTypes  = {                 -- Types de résolution qui comptent dans les stats
            "resolved",
            "warned",
            "sanctioned",
        },
    },
}

-- ═══════════════════════════════════════════════════════════════════════════════
-- FONCTIONS UTILITAIRES REPORTS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Récupère le label formaté d'une résolution (avec emoji)
Config.Staff.GetResolutionLabel = function(resolutionValue)
    for _, res in ipairs(Config.Staff.Reports.Resolutions) do
        if res.value == resolutionValue then
            return res.emoji .. " " .. res.label
        end
    end
    return "✅ Résolu"  -- Valeur par défaut
end

-- Récupère la couleur d'une résolution pour Discord
Config.Staff.GetResolutionColor = function(resolutionValue)
    return Config.Staff.Reports.Discord.Colors[resolutionValue] or Config.Staff.Reports.Discord.Colors.default
end

-- Génère les options pour lib.inputDialog (format ox_lib)
Config.Staff.GetResolutionOptions = function()
    local options = {}
    for _, res in ipairs(Config.Staff.Reports.Resolutions) do
        table.insert(options, {
            value = res.value,
            label = res.emoji .. " " .. res.label
        })
    end
    return options
end

-- Récupère la résolution par défaut
Config.Staff.GetDefaultResolution = function()
    for _, res in ipairs(Config.Staff.Reports.Resolutions) do
        if res.default then
            return res.value
        end
    end
    return "resolved"
end