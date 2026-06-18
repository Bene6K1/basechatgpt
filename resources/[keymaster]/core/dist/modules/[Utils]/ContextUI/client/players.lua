local enterprisePermissions = {}
local organisationPermissions = {}

local enterpriseData = {
    recruit = {
        job = nil,
        created = {}
    },
    promote = {
        job = nil,
        created = {}
    }
}

local organisationData = {
    recruit = {
        job = nil,
        created = {}
    },
    promote = {
        job = nil,
        created = {}
    }
}

-- Variable pour stocker l'animation reçue d'un autre joueur
local receivedAnimation = nil

-- Event pour recevoir l'animation d'un autre joueur
RegisterNetEvent('Wezor:receiveAnimation', function(animName, variation)
    receivedAnimation = { name = animName, variation = variation }
end)

-- Event pour répondre à une demande d'animation (quand un autre joueur veut copier notre animation)
RegisterNetEvent('Wezor:requestAnim', function(requesterServerId)
    local animName = nil
    local variation = nil

    -- Essayer de récupérer l'animation via l'export rpemotes si disponible
    local success, result = pcall(function()
        return exports['rpemotes']:getPlayerAnimation()
    end)

    if success and result then
        animName = result
    else
        -- Fallback: essayer avec sunny_emotemenu
        local success2, result2 = pcall(function()
            return exports['sunny_emotemenu']:getPlayerAnimation()
        end)
        if success2 and result2 then
            animName = result2
        end
    end

    -- Envoyer l'animation au serveur pour relayer au demandeur
    TriggerServerEvent('Wezor:sendAnimation', requesterServerId, animName, variation)
end)

Citizen.CreateThread(function ()
    while GetResourceState("ox_target") ~= "started" do Citizen.Wait(0) end

    local cfg = SunnyConfigServ.PlayerTargetOptions

    exports.ox_target:addGlobalPlayer({

        -- Option: Copier l'animation (configurable)
        {
            label = cfg.CopyAnimation.Label,
            icon = cfg.CopyAnimation.Icon,
            distance = cfg.CopyAnimation.Distance,
            canInteract = function(data)
                return cfg.CopyAnimation.Enabled
            end,
            onSelect = function(data)
                local targetPed = data.entity

                if not DoesEntityExist(targetPed) then
                    ESX.ShowNotification("Erreur : aucune entité cible détectée.")
                    return
                end

                -- Demande l'animation au joueur cible via l'event rpemotes
                local targetServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(targetPed))
                receivedAnimation = nil
                TriggerServerEvent('Wezor:requestAnim', targetServerId)

                -- Attendre la réponse (max 2 secondes)
                Citizen.CreateThread(function()
                    local timeout = 20
                    while receivedAnimation == nil and timeout > 0 do
                        Citizen.Wait(100)
                        timeout = timeout - 1
                    end

                    if receivedAnimation and receivedAnimation.name then
                        -- Joue l'animation copiée
                        ExecuteCommand('e ' .. receivedAnimation.name)
                        ESX.ShowNotification(cfg.CopyAnimation.NotificationSuccess:format(receivedAnimation.name))
                    else
                        ESX.ShowNotification(cfg.CopyAnimation.NotificationNoAnim)
                    end
                end)
            end
        },

        -- Option: ID du joueur (configurable)
        {
            label = cfg.ShowPlayerId.Label,
            icon = cfg.ShowPlayerId.Icon,
            canInteract = function ()
                return cfg.ShowPlayerId.Enabled
            end,
            onSelect = function (data)
                ESX.TriggerServerCallback("sunny:getTargetId", function (ID)
                    ESX.ShowNotification(("ID du joueur: %s"):format(ID))
                end, GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        },

        -- Option: Pile ou face (configurable)
        {
            label = cfg.CoinFlip.Label,
            icon = cfg.CoinFlip.Icon,
            canInteract = function ()
                return cfg.CoinFlip.Enabled
            end,
            onSelect = function (data)
                ExecuteCommand(SunnyConfigServ.PileOuFace.Command)
            end
        },

        -- Option: Porter (configurable)
        {
            label = cfg.Carry.Label,
            icon = cfg.Carry.Icon,
            canInteract = function ()
                return cfg.Carry.Enabled
            end,
            onSelect = function (data)
                ExecuteCommand("porter")
            end
        },
        {
            label = "Actions Admin",
            icon = "fa-solid fa-lock",
            distance = 5.0,
            canInteract = function ()
                return adminManagement.Service
            end,
            openMenu = "admin-option"
        }, 
        {
            menuName = "admin-option",
            label = "Freeze/Unfreeze le joueur",
            icon = "fa-solid fa-icicles",
            canInteract = function ()
                return adminManagement.Service
            end,
            onSelect = function (data)
                -- Récupère l'ID via ESX.TriggerServerCallback
                ESX.TriggerServerCallback("sunny:getTargetId", function (ID)
                    if ID then
                        -- Vérifie si le joueur est actuellement freeze ou pas
                        if adminManagement.FreezeUnfreeze then
                            adminManagement.FreezeUnfreeze = false
                            TriggerServerEvent('sunny:admin:freezeunfreezeplayer', ID, 'unfreeze')
                            ESX.ShowNotification('✅ Joueur unfreeze avec succès')
                        else
                            adminManagement.FreezeUnfreeze = true
                            TriggerServerEvent('sunny:admin:freezeunfreezeplayer', ID, 'freeze')
                            ESX.ShowNotification('✅ Joueur freeze avec succès')
                        end
                    else
                        ESX.ShowNotification("Erreur : Impossible de récupérer l'ID du joueur.")
                    end
                end, GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        },

        


        
        {
            menuName = "admin-option",
            label = "Téléporter sur moi",
            icon = "fa-solid fa-icicles",
            canInteract = function ()
                return adminManagement.Service
            end,
            onSelect = function (data)
                ESX.TriggerServerCallback("sunny:getTargetId", function (ID)
                    if ID then
                        ExecuteCommand('tp '..ID)
                        TriggerServerEvent('sunny:admin:getPosForRreturnPlayer', ID)
                    else
                        ESX.ShowNotification("Erreur : Impossible de récupérer l'ID du joueur.")
                    end
                end, GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        },
        {
            menuName = "admin-option",
            label = "Retourner pos",
            icon = "fa-solid fa-icicles",
            canInteract = function ()
                return adminManagement.Service
            end,
            onSelect = function (data)
                ESX.TriggerServerCallback("sunny:getTargetId", function (ID)
                    if ID then
                        TriggerServerEvent('sunny:admin:xPlayer.return', ID, adminManagement.LastPlayerPos[ID].pos)
                    else
                        ESX.ShowNotification("Erreur : Impossible de récupérer l'ID du joueur.")
                    end
                end, GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        },
        {
            menuName = "admin-option",
            label = "Téléporter PC",
            icon = "fa-solid fa-icicles",
            canInteract = function ()
                return adminManagement.Service
            end,
            onSelect = function (data)
                ESX.TriggerServerCallback("sunny:getTargetId", function (ID)
                    if ID then
                        -- Exécute la commande tppc avec l'ID du joueur
                        ExecuteCommand("tppc " .. ID)
                    else
                        ESX.ShowNotification("Erreur : Impossible de récupérer l'ID du joueur.")
                    end
                end, GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        },        
        {
            menuName = "admin-option",
            label = "Envoyer un message",
            icon = "fa-solid fa-icicles",
            canInteract = function ()
                return adminManagement.Service
            end,
            onSelect = function (data)
                ESX.TriggerServerCallback("sunny:getTargetId", function (ID)
                    if ID then
                        KeyboardUtils.use('Message', function(data)
                            if data == nil or data == '' then
                                return ESX.ShowNotification('Argument manquant')
                            end
                            TriggerServerEvent('sunny:staff:players:takeMessage', ID, data)
                        end)
                    else
                        ESX.ShowNotification("Erreur : Impossible de récupérer l'ID du joueur.")
                    end
                end, GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        },
        {
            menuName = "admin-option",
            label = "Revive le joueur",
            icon = "fa-solid fa-icicles",
            canInteract = function ()
                return adminManagement.Service
            end,
            onSelect = function (data)
                ESX.TriggerServerCallback("sunny:getTargetId", function (ID)
                    if ID then
                        ExecuteCommand("revive " ..ID)
                    else
                        ESX.ShowNotification("Erreur : Impossible de récupérer l'ID du joueur.")
                    end
                end, GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        },
        {
            menuName = "admin-option",
            label = "Heal le joueur",
            icon = "fa-solid fa-icicles",
            canInteract = function ()
                return adminManagement.Service
            end,
            onSelect = function (data)
                ESX.TriggerServerCallback("sunny:getTargetId", function (ID)
                    if ID then
                        ExecuteCommand("heal " ..ID)
                    else
                        ESX.ShowNotification("Erreur : Impossible de récupérer l'ID du joueur.")
                    end
                end, GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        },
        {
            menuName = "admin-option",
            label = "Screen le joueur",
            icon = "fa-solid fa-icicles",
            canInteract = function ()
                return adminManagement.Service
            end,
            onSelect = function (data)
                ESX.TriggerServerCallback("sunny:getTargetId", function (ID)
                    if ID then
                        TriggerServerEvent('sunny:admin:screen', ID)
                        ESX.ShowNotification('📷 Vous retrouverez le screen dans les logs')
                    else
                        ESX.ShowNotification("Erreur : Impossible de récupérer l'ID du joueur.")
                    end
                end, GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        },
        {
            menuName = "admin-option",
            label = "Donner Panto",
            icon = "fa-solid fa-icicles",
            canInteract = function ()
                return adminManagement.Service
            end,
            onSelect = function (data)
                ESX.TriggerServerCallback("sunny:getTargetId", function (ID)
                    if ID then
                        TriggerServerEvent('sunny:admin:spawnVehicle', ID, 'panto')
                    else
                        ESX.ShowNotification("Erreur : Impossible de récupérer l'ID du joueur.")
                    end
                end, GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        },
        {
            label = "Gestion Entreprise",
            icon = "fas fa-building",
            distance = 5.0,
            canInteract = function ()
                if ESX.PlayerData.job == nil then
                    return false
                end

                if ESX.PlayerData.job.name == "unemployed" then
                    return false
                end

                if ESX.PlayerData.job.grade_name == "boss" then
                    return true
                end

             --   if ESX.Table.Contains(enterprisePermissions, "addEmployer") or ESX.Table.Contains(enterprisePermissions, "removeEmployer") then
             --       return true
            --    end

                return false
            end,
            openMenu = "gestion-enterprise"
        }, {
            menuName = "gestion-enterprise",
            label = "Recruter",
            icon = "fas fa-user-tie",
            distance = 5.0,
            canInteract = function ()
                if ESX.PlayerData.job.grade_name == "boss" then
                    return true
                end

               -- if ESX.Table.Contains(enterprisePermissions, "addEmployer") then
            --        return true
           --     end

                return false
            end,
            onSelect = function (data)
                TriggerServerEvent("boss:Boss_recruterplayer", GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        }, {
            menuName = "gestion-enterprise",
            label = "Virer",
            icon = "fas fa-ban",
            distance = 5.0,
            canInteract = function ()
                if ESX.PlayerData.job.grade_name == "boss" then
                    return true
                end

             --   if ESX.Table.Contains(enterprisePermissions, "removeEmployer") then
            --        return true
             --   end

                return false
            end,
            onSelect = function (data)
                TriggerServerEvent("sunny:entreprise:Boss_virerplayer", GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        }, {
            menuName = "gestion-enterprise",
            label = "Promouvoir",
            icon = "fas fa-arrow-up",
            distance = 5.0,
            canInteract = function ()
                if ESX.PlayerData.job.grade_name == "boss" then
                    return true
                end

              --  if ESX.Table.Contains(enterprisePermissions, "addEmployer") then
              --      return true
              --  end

                return false
            end,
        onSelect = function (data)
        TriggerServerEvent('boss:Boss_promouvoirplayer', GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
        end
        },
    {
            menuName = "gestion-enterprise",
            label = "Destituer",
            icon = "fas fa-user-cog",
            distance = 5.0,
            canInteract = function ()
                if ESX.PlayerData.job.grade_name == "boss" then
                    return true
                end

             --   if ESX.Table.Contains(enterprisePermissions, "addEmployer") then
             --       return true
             --   end

                return false
            end,
        onSelect = function (data)
        TriggerServerEvent('boss:Boss_destituerplayer', GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
        end
        },
    {
            label = "Gestion Organisation",
            icon = "fas fa-arrow-down",
            distance = 5.0,
            canInteract = function ()
                if ESX.PlayerData.job2 == nil then
                    return false
                end

                if ESX.PlayerData.job2.name == "unemployed" then
                    return false
                end

                if ESX.PlayerData.job2.grade_name == "boss" then
                    return true
                end

              --  if ESX.Table.Contains(organisationPermissions, "addEmployer") or ESX.Table.Contains(organisationPermissions, "removeEmployer") then
              --      return true
              --  end

                return false
            end,
            openMenu = "gestion-organisation"
        }, {
            menuName = "gestion-organisation",
            label = "Recruter",
            icon = "fa-solid fa-people-group",
            distance = 5.0,
            canInteract = function ()
                if ESX.PlayerData.job2.grade_name == "boss" then
                    return true
                end

               -- if ESX.Table.Contains(organisationPermissions, "addEmployer") then
               --     return true
               -- end

                return false
            end,
            onSelect = function (data)
                TriggerServerEvent('boss:Boss_recruterplayer2', GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        }, {
            menuName = "gestion-organisation",
            label = "Virer",
            icon = "fa-solid fa-people-group",
            distance = 5.0,
            canInteract = function ()
                if ESX.PlayerData.job2.grade_name == "boss" then
                    return true
                end

               -- if ESX.Table.Contains(organisationPermissions, "removeEmployer") then
               --     return true
               -- end

                return false
            end,
            onSelect = function (data)
                TriggerServerEvent("boss:Boss_virerplayer2", GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
            end
        }, {
            menuName = "gestion-organisation",
            label = "Promouvoir",
            icon = "fa-solid fa-people-group",
            distance = 5.0,
            canInteract = function ()
                if ESX.PlayerData.job2.grade_name == "boss" then
                    return true
                end

               -- if ESX.Table.Contains(organisationPermissions, "addEmployer") then
                --    return true
               -- end

                return false
            end,
        onSelect = function (data)
        TriggerServerEvent('boss:Boss_promouvoirplayer2', GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
        end
        },
    {
            menuName = "gestion-organisation",
            label = "Destituer",
            icon = "fa-solid fa-people-group",
            distance = 5.0,
            canInteract = function ()
                if ESX.PlayerData.job2.grade_name == "boss" then
                    return true
                end

               -- if ESX.Table.Contains(organisationPermissions, "addEmployer") then
                --    return true
                --end

                return false
            end,
        onSelect = function (data)
        TriggerServerEvent('boss:Boss_destituerplayer2', GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity)))
        end
        }
    })
end)