SoundManager = {}

function SoundManager.PlaySound(soundName, customVolume)
    -- Vérifier si les sons sont activés
    if not Config.UI.Sounds.Enabled then
        return
    end
    
    -- Déterminer le volume à utiliser
    local volume = customVolume
    if not volume then
        volume = Config.UI.Sounds.Volumes[soundName] or 0.3
    end
    
    -- Envoyer le message NUI pour jouer le son
    SendNUIMessage({
        type = "playSoundEffect",
        sound = soundName,
        volume = volume
    })
    
    -- Gérer les vibrations haptiques si activées
    if Config.UI.Sounds.Haptic and Config.UI.Sounds.Haptic.Enabled then
        local hapticDuration = Config.UI.Sounds.Haptic.Duration[soundName] or 100
        local hapticIntensity = Config.UI.Sounds.Haptic.Intensity[soundName] or 0.2
        
        SetControlShake(0, hapticIntensity * 255, hapticDuration)
    end
end

-- Export de la fonction pour utilisation externe
exports("PlaySound", function(soundName, customVolume)
    SoundManager.PlaySound(soundName, customVolume)
end)

return SoundManager