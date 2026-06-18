CreateThread(function()

    while not NetworkIsSessionStarted() do
        Citizen.Wait(0)
    end

	for _, relationshipGroup in ipairs(SunnyConfigServ.PNJ.RelationshipGroups) do
		SetRelationshipBetweenGroups(1, relationshipGroup, `PLAYER`)
	end

	for i = 1, 15 do
		EnableDispatchService(i, false)
	end

	for _, weapon in ipairs(SunnyConfigServ.PNJ.PickupWeapons) do
		ToggleUsePickupsForPlayer(Player.playerId, weapon, false)
	end
    DisableControlAction(0, 140, true)
    if IsPedArmed(PlayerPedId(), 4) then
        SetPlayerLockon(PlayerId(), false)
            else
        SetPlayerLockon(PlayerId(), true)
    end

	SetCreateRandomCopsNotOnScenarios(false)
	SetCreateRandomCops(false)

	for _, model in pairs(SunnyConfigServ.PNJ.SuppressedVehiclesModels) do
		SetVehicleModelIsSuppressed(model, true)
	end

	for _, model in pairs(SunnyConfigServ.PNJ.SuppressedPedsModels) do
		SetPedModelIsSuppressed(model, true)
	end

    SetWeaponsNoAutoswap(true)

    SetMaxWantedLevel(0)
    SetPoliceIgnorePlayer(Player.playerId, true)
    SetDispatchCopsForPlayer(Player.playerId, false)
    SetPlayerHealthRechargeMultiplier(PlayerPedId(), 0.0)
    SetPedSuffersCriticalHits(Player.playerPed, false)
    DisablePlayerVehicleRewards(Player.playerId)
    DisableControlAction(0, 80, true)
    SetGarbageTrucks(0)
	SetRandomBoats(0)
	SetRandomTrains(0)

    SetPedCanBeDraggedOut(PlayerPedId(), false)
    local weapon = GetSelectedPedWeapon(Player.playerPed)

    if weapon == `WEAPON_PEPPERSPRAY` or weapon == `WEAPON_ANTIDOTE` then
    DisablePlayerFiring()
    SetPlayerLockon(PlayerId(), true)
    elseif weapon == `WEAPON_UNARMED` or GetWeaponDamageType(weapon) == 2 then
    SetPlayerLockon(PlayerId(), true)
    else
    SetPlayerLockon(PlayerId(), false)
    end
end)

-- Gestion de la santé et des dégâts de chute
local falling = false
local startHeight = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local playerId = PlayerId()
        local ped = PlayerPedId()

        -- Désactiver la régénération automatique de la santé
        SetPlayerHealthRechargeMultiplier(playerId, 0.0)

        -- Augmenter les dégâts de chute
        if IsPedFalling(ped) or IsPedInParachuteFreeFall(ped) then
            if not falling then
                falling = true
                startHeight = GetEntityCoords(ped).z
            end
        else
            if falling then
                falling = false
                local endHeight = GetEntityCoords(ped).z
                local heightDiff = startHeight - endHeight
                
                -- Si la chute est significative (> 5 mètres)
                if heightDiff > 5.0 then
                    -- Appliquer des dégâts proportionnels à la hauteur
                    -- Ajustez le multiplicateur (ici 15) pour plus ou moins de dégâts
                    local damage = math.floor((heightDiff - 5.0) * 15)
                    
                    -- Appliquer les dégâts
                    if damage > 0 then
                        ApplyDamageToPed(ped, damage, false)
                    end
                    
                    -- Faire tomber le joueur (ragdoll) s'il survit et que la chute était > 3m
                    if not IsPedDeadOrDying(ped) and heightDiff > 3.0 then
                        SetPedToRagdoll(ped, 3000, 3000, 0, 0, 0, 0)
                    end
                end
            end
        end
    end
end)