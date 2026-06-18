Config = {}

-- Paramètres de gameplay
Config.DefaultRespawnTime = 360 -- Temps en secondes (6 minutes)
Config.AllowKillCommand = true -- Autoriser la commande /kill
Config.KillCommandPermissions = {"fondateur", "developper", "_dev", "gerant"} -- Permissions nécessaires pour la commande /kill

-- Contrôles
Config.Controls = {
    CallMedic = 'E',     -- Touche pour appeler les secours
    Respawn = 'X'        -- Touche pour réapparaître
}

-- Notifications
Config.NotificationDuration = 5000 -- Durée d'affichage des notifications en ms
Config.DefaultMessages = {
    MedicCalled = "Les secours ont été contactés. Veuillez patienter.",
    MedicEnRoute = "Les secours sont actuellement en route !",
    TimerNotFinished = "Vous devez attendre la fin du timer avant de respawn."
}

-- Bouton Staff Revive
Config.StaffRevive = {
    Enabled = true, -- Activer le bouton staff
    AllowedGroups = {
        "fondateur",      -- Fondateur (rank le plus haut)
        "developper",     -- Développeur
        "_dev",           -- Dev (alias)
        "gerant",         -- Gérant
        "responsable",    -- Responsable
        "superadmin",     -- Super Administrateur
        "administrateur", -- Administrateur
        "moderateur",     -- Modérateur
        "helpeur"         -- Helpeur
    },
    Key = 'S' -- Touche pour le revive staff
}

-- Interactions avec d'autres ressources
Config.HideHUD = true -- Masquer le HUD pendant la mort
Config.HideRadar = true -- Masquer le radar pendant la mort
