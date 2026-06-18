ESX = nil 

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)



function IdentityRageu(infos, infos_values, dob, sid)
    -- Redirection COMPLETE vers la NUI moderne (on ne dessine plus en 2D)
    exports['ox_inventory']:closeInventory()

    local function sanitize(val)
        if type(val) ~= "string" then return "" end
        val = val:gsub("~[^~]*~", "") -- retire codes GTA (~bold~, ~b~, etc.)
        val = val:gsub("<br>", " "):gsub("<.->", "") -- retire balises HTML simples
        val = val:gsub("^%s+", ""):gsub("%s+$", "")
        return val
    end

    local firstname = sanitize(infos_values[1] or "")
    local lastname  = sanitize(infos_values[2] or "")
    local sexLabel  = sanitize((infos_values[3] or ""):lower())
    local sex       = (sexLabel:find("homme") and "m") or (sexLabel:find("femme") and "f") or "m"
    local dateofbirth = sanitize(dob or "")

    local array = {
        user = {
            {
                firstname   = firstname,
                lastname    = lastname,
                dateofbirth = dateofbirth,
                sex         = sex,
                height      = ""
            }
        },
        licenses = {}
    }

    -- Ouvre la NUI locale directement
    TriggerEvent('jsfour-idcard:open', array, nil, nil)
end
-- open flag already défini plus haut

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type, ok )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type,
		fishing_type = ok
	})

	Citizen.CreateThread(function()
		while open do
			Wait(0)
			if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
				ExecuteCommand('EmoteCancel')
				SendNUIMessage({
					action = "close"
				})
				open = false
			end
		end
	end)
end)
RegisterNetEvent('Game:Client:UI:showIdentity')
AddEventHandler('Game:Client:UI:showIdentity', function(infos, infos_values, dob, sid)
    -- Redirige l'affichage vers la NUI moderne (HTML/CSS) au lieu du draw 2D moche
    local function sanitize(val)
        if type(val) ~= "string" then return "" end
        val = val:gsub("~[^~]*~", "") -- retire codes GTA (~bold~, ~b~, etc.)
        val = val:gsub("<br>", " "):gsub("<.->", "") -- retire balises HTML simples
        val = val:gsub("^%s+", ""):gsub("%s+$", "")
        return val
    end

    -- infos_values attendu: { prenom, nom, sexe, entreprise }
    local firstname = sanitize(infos_values[1] or "")
    local lastname = sanitize(infos_values[2] or "")
    local sexLabel = sanitize((infos_values[3] or ""):lower())
    local sex = (sexLabel:find("homme") and "m") or (sexLabel:find("femme") and "f") or "m"
    local dateofbirth = sanitize(dob or "")

    local array = {
        user = {
            {
                firstname = firstname,
                lastname = lastname,
                dateofbirth = dateofbirth,
                sex = sex,
                height = ""
            }
        },
        licenses = {}
    }

    -- Utilise le même handler NUI que jsfour-idcard normal
    TriggerEvent('jsfour-idcard:open', array, nil, nil)
end)
local function RequestAndWaitDict(dictName) -- Request une animation (dict)
	if dictName and DoesAnimDictExist(dictName) and not HasAnimDictLoaded(dictName) then
		RequestAnimDict(dictName)
		while not HasAnimDictLoaded(dictName) do Citizen.Wait(100) end
	end
end
local function RequestAndWaitModel(modelName) -- Request un modèle de véhicule
	if modelName and IsModelInCdimage(modelName) and not HasModelLoaded(modelName) then
		RequestModel(modelName)
		while not HasModelLoaded(modelName) do Citizen.Wait(100) end
	end
end

RegisterNetEvent('sunny:id:idcard', function()
	--ExecuteCommand('e idcard')
end)
RegisterNetEvent('montrer:identity')
AddEventHandler('montrer:identity', function(id)
    ExecuteCommand('e idcard')
    exports['ox_inventory']:closeInventory()

    local player, distance = ESX.Game.GetClosestPlayer()
    local myId = GetPlayerServerId(PlayerId())

    if distance ~= -1 and distance <= 3.0 then
        -- Ouvrir chez le joueur ciblé et chez soi (NUI moderne)
        TriggerServerEvent('jsfour-idcard:open', myId, GetPlayerServerId(player), nil)
        TriggerServerEvent('jsfour-idcard:open', myId, myId, nil)
    else
        -- Pas de cible proche, s'afficher à soi
        TriggerServerEvent('jsfour-idcard:open', myId, myId, nil)
    end
end)



------ DRIVE
---

function DriveRageUI(infos, infos_values, dob, sid)
    -- Redirection COMPLETE vers la NUI moderne pour le permis
    exports['ox_inventory']:closeInventory()

    local function sanitize(val)
        if type(val) ~= "string" then return "" end
        val = val:gsub("~[^~]*~", "")
        val = val:gsub("<br>", " "):gsub("<.->", "")
        val = val:gsub("^%s+", ""):gsub("%s+$", "")
        return val
    end

    local fullname = sanitize(infos_values[1] or "")
    local first, last = fullname:match("^(%S+)%s+(.*)$")
    if not first then first = fullname or "" end
    if not last then last = "" end

    local sexLabel  = sanitize((infos_values[2] or ""):lower())
    local sex       = (sexLabel:find("homme") and "m") or (sexLabel:find("femme") and "f") or "m"
    local dateofbirth = sanitize(dob or "")

    local array = {
        user = {
            {
                firstname   = first,
                lastname    = last,
                dateofbirth = dateofbirth,
                sex         = sex,
                height      = ""
            }
        },
        licenses = {}
    }

    -- Ouvre la NUI locale en mode permis
    TriggerEvent('jsfour-idcard:open', array, 'driver', nil)
end
local open = false


RegisterNetEvent('Game:Client:UI:showDrive')
AddEventHandler('Game:Client:UI:showDrive', function(infos, infos_values, dob, sid)
    -- Redirige le permis vers la NUI moderne (type = 'driver')
    local function sanitize(val)
        if type(val) ~= "string" then return "" end
        val = val:gsub("~[^~]*~", "")
        val = val:gsub("<br>", " "):gsub("<.->", "")
        val = val:gsub("^%s+", ""):gsub("%s+$", "")
        return val
    end

    -- answers attendu: { "Prenom Nom", "Homme/Femme", licences... }
    local fullname = sanitize(infos_values[1] or "")
    local first, last = fullname:match("^(%S+)%s+(.*)$")
    if not first then first = fullname or "" end
    if not last then last = "" end

    local sexLabel = sanitize((infos_values[2] or ""):lower())
    local sex = (sexLabel:find("homme") and "m") or (sexLabel:find("femme") and "f") or "m"
    local dateofbirth = sanitize(dob or "")

    local array = {
        user = {
            {
                firstname = first,
                lastname = last,
                dateofbirth = dateofbirth,
                sex = sex,
                height = ""
            }
        },
        -- on laisse licenses vide: l'UI 'driver' gère l'absence proprement
        licenses = {}
    }

    TriggerEvent('jsfour-idcard:open', array, 'driver', nil)
end)



RegisterNetEvent('montrer:drive')
AddEventHandler('montrer:drive', function(id)
    ExecuteCommand('e idcard')
    exports['ox_inventory']:closeInventory()
    local player, distance = ESX.Game.GetClosestPlayer()
    local myId = GetPlayerServerId(PlayerId())

    if distance ~= -1 and distance <= 3.0 then
        -- Ouvrir le permis chez la cible et chez soi (type driver)
        TriggerServerEvent('jsfour-idcard:open', myId, GetPlayerServerId(player), 'driver')
        TriggerServerEvent('jsfour-idcard:open', myId, myId, 'driver')
    else
        -- Pas de cible, s'afficher à soi
        TriggerServerEvent('jsfour-idcard:open', myId, myId, 'driver')
    end
end)
