AuTravailleChantier = false

local WorkerChillPos = {
	{
		pos = vector3(5000, 5000, 5000),
		Heading = 52.55
	},
	{
		pos = vector3(5000, 5000, 5000),
		Heading = 228.22
	},
	{
		pos = vector3(5000, 5000, 5000),
		Heading = 353.89
	},
	{
		pos = vector3(5000, 5000, 5000),
		Heading = 168.35
	}
}

local workzone = {
	{
		pos = vector3(-167.73760986328, -1086.3040771484, 30.139402389526-1),
		Heading = 159.6531829834,
		scenario = "WORLD_HUMAN_WELDING"
	},
	{
		pos = vector3(-151.5513458252, -1093.3973388672, 30.139408111572-1),
		Heading = 160.44879150391,
		scenario = "WORLD_HUMAN_WELDING"
	},
	{
		pos = vector3(-141.64074707031, -1091.9742431641, 30.139408111572-1),
		Heading = 248.91160583496,
		scenario = "WORLD_HUMAN_WELDING"
	},
	{
		pos = vector3(-148.31298828125, -1110.0008544922, 30.1394119262-1),
		Heading = 355.54779052734,
		scenario = "WORLD_HUMAN_WELDING"
	},
	{
		pos = vector3(-168.67919921875, -1057.5544433594, 30.13939666748-1),
		Heading = 250.13125610352,
		scenario = "WORLD_HUMAN_HAMMERING"
	},	{
		pos = vector3(-186.76402282715, -1099.1599121094, 30.229829788208-1),
		Heading = 346.61557006836,
		scenario = "WORLD_HUMAN_HAMMERING"
	},
	{
		pos = vector3(-165.35771179199, -1065.0500488281, 30.139423370361-1),
		Heading = 343.34246826172,
		scenario = "WORLD_HUMAN_HAMMERING"
	}
}

local WorkerWorkingPos = {
	{
		pos = vector3(-173.0322265625, -1084.6214599609, 30.139402389526-1),
		Heading = 163.71911621094,
		scenario = "WORLD_HUMAN_WELDING"
	},
	{
		pos = vector3(-160.84692382812, -1084.7532958984, 30.139400482178-1),
		Heading = 195.59411621094,
		scenario = "WORLD_HUMAN_WELDING"
	},
	{
		pos = vector3(-145.56604003906, -1087.4483642578, 30.139408111572-1),
		Heading = 336.43014526367,
		scenario = "WORLD_HUMAN_HAMMERING"
	},
	{
		pos = vector3(-142.95314025879, -1099.3913574219, 30.139408111572-1),
		Heading = 158.58015441895,
		scenario = "WORLD_HUMAN_HAMMERING"
	},
	{
		pos = vector3(-158.4129486084, -1063.5252685547, 30.139427185059-1),
		Heading = 70.617202758789,
		scenario = "WORLD_HUMAN_CONST_DRILL"
	},
	{
		pos = vector3(-189.32077026367, -1109.6628417969, 30.139400482178-1),
		Heading = 69.560684204102,
		scenario = "WORLD_HUMAN_CONST_DRILL"
	}
}

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(10)
	end

	ESX.Game.SpawnLocalPed(2, `s_m_y_construct_01`, zone.Chantier, 160.0, function(ped)
		FreezeEntityPosition(ped, true)
		TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
	end)

	for k, v in ipairs(WorkerChillPos) do
		ESX.Game.SpawnLocalPed(2, `s_m_y_construct_01`, v.pos, v.Heading, function(ped)
			FreezeEntityPosition(ped, true)
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_AA_COFFEE", 0, true)
			SetEntityInvincible(ped, true)
			SetBlockingOfNonTemporaryEvents(ped, true)
		end)
	end

	for k, v in pairs(WorkerWorkingPos) do
		ESX.Game.SpawnLocalPed(2, `s_m_y_construct_01`, v.pos, v.Heading, function(ped)
			FreezeEntityPosition(ped, true)
			TaskStartScenarioInPlace(ped, v.scenario, 0, true)
			SetEntityInvincible(ped, true)
			SetBlockingOfNonTemporaryEvents(ped, true)
		end)
	end
end)

function StartTravailleChantier()
	AuTravailleChantier = true

	Citizen.CreateThread(function()
		while AuTravailleChantier do
			Wait(1)
			local random = math.random(1, #workzone)
			local count = 1

			for k, v in ipairs(workzone) do
				count = count + 1

				if count == random and AuTravailleChantier then
					local EnAction = false
					local pPed = PlayerPedId()
					local pCoords = GetEntityCoords(pPed)
					local dstToMarker = #(v.pos - pCoords)
					local blip = AddBlipForCoord(v.pos)

					TriggerServerEvent("jobs_civil:chantierSetPoint", v.pos)

					SetBlipSprite(blip, 402)
					SetBlipColour(blip, 5)
					SetBlipScale(blip, 0.5)

					while not EnAction and AuTravailleChantier do
						Citizen.Wait(1)
						pCoords = GetEntityCoords(pPed)
						dstToMarker = #(v.pos - pCoords)
						DrawMarker(32, v.pos.x, v.pos.y, v.pos.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)

						if dstToMarker <= 3.0 and AuTravailleChantier then
							ESX.ShowHelpNotification("~INPUT_CONTEXT~ pour travailler")

							if IsControlJustPressed(0, 51) and dstToMarker <= 3.0 then
								RemoveBlip(blip)
								EnAction = true
								SetEntityCoords(pPed, v.pos, false, false, false, false)
								SetEntityHeading(pPed, v.Heading)
								TaskStartScenarioInPlace(pPed, v.scenario, 0, true)
								drawBar(10000, 'Travail en cours', function()
									ClearPedTasksImmediately(PlayerPedId())
									RemoveAllPedWeapons(PlayerPedId(), true)
									TriggerServerEvent("jobs_civil:chantierReward")
								end)
								break
							end
						end
					end

					if DoesBlipExist(blip) then
						RemoveBlip(blip)
					end
				end
			end
		end
	end)
end