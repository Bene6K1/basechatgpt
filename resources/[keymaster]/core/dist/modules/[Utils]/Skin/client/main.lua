local LastSkin, PlayerLoaded, cam, isCameraActive
local FirstSpawn, zoomOffset, camOffset, heading = true, 0.0, 0.0, 90.0


AddEventHandler('playerSpawned', function()
	Citizen.CreateThread(function()
		while not PlayerLoaded do
			Citizen.Wait(100)
		end

		if FirstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
					TriggerEvent('skinchanger:loadSkin', {sex = 0})
				else
					TriggerEvent('skinchanger:loadSkin', skin)
				end
			end)

			FirstSpawn = false
		end
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerLoaded = true
	
	-- Attendre que le joueur soit complètement spawné
	Citizen.CreateThread(function()
		-- Attendre que FirstSpawn soit terminé
		while FirstSpawn do
			Citizen.Wait(100)
		end
		
		-- Attendre un peu plus pour être sûr que tout est chargé
		Citizen.Wait(2000)
		
		-- Notifier le serveur que le spawn est complet
		TriggerServerEvent('playerSpawned')
	end)
end)

AddEventHandler('esx_skin:getLastSkin', function(cb)
	cb(LastSkin)
end)

AddEventHandler('esx_skin:setLastSkin', function(skin)
	LastSkin = skin
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	  end
	TriggerServerEvent('sunny:skin:restart')
end)

RegisterNetEvent('sunny:skin:restart', function()
	if FirstSpawn then
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			if skin == nil then
				TriggerEvent('skinchanger:loadSkin', {sex = 0})
			else
				TriggerEvent('skinchanger:loadSkin', skin)
			end
		end)

		FirstSpawn = false
	end
end)

-- Commande /reloadskin pour recharger le skin du joueur
RegisterCommand('reloadskin', function()
	local ped = PlayerPedId()

	-- Réinitialiser les composants du ped
	SetPedDefaultComponentVariation(ped)

	-- Récupérer et réappliquer le skin sauvegardé depuis la DB
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		if skin ~= nil then
			TriggerEvent('skinchanger:loadSkin', skin)
			ESX.ShowNotification('~g~Skin rechargé avec succès !')
		else
			ESX.ShowNotification('~r~Aucun skin sauvegardé trouvé.')
		end
	end)
end, false)