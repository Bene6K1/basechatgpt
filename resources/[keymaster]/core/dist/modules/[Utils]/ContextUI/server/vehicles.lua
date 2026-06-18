RegisterServerEvent("cacherdansuncoffredsc")
AddEventHandler("cacherdansuncoffredsc", function(action, playerName, playerCoords)
    local webhookURL = "https://discord.com/api/webhooks/1334060261631590441/QkH32VVJ64RkhsHG0MoQR5Sf_kOb6-s9tXV4oRF3hkl69C8_8i6INvZcj_PRqJbL1q5X"
    local message, color

    -- Définir le message et la couleur selon l'action
    if action == "enter" then
        message = ("Le Joueur %s vient de se cacher dans un coffre."):format(playerName)
        color = 65280 -- Vert
    elseif action == "exit" then
        message = ("Le Joueur %s vient de sortir d’un coffre."):format(playerName)
        color = 16711680 -- Rouge
    else
        print("Action inconnue pour l'événement 'cacherdansuncoffredsc'.")
        return
    end

    -- Construire les données pour le log
    local logData = {
        username = "Coffre Logs",
        embeds = {{
            title = message,
            description = ("**Coordonnées :** x: %.2f, y: %.2f, z: %.2f"):format(playerCoords.x, playerCoords.y, playerCoords.z),
            color = color,
            footer = {
                text = "SunnyHill"
            }
        }}
    }

    -- Envoyer la requête HTTP au webhook
    PerformHttpRequest(webhookURL, function(err, text, headers)
        if err ~= 200 then
        end
    end, "POST", json.encode(logData), { ["Content-Type"] = "application/json" })
end)
