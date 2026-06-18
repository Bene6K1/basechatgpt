local kmh = 3.6
local mph = 2.23693629
local carspeed = 0
local driftmode = false
local speed = kmh -- or mph
local drift_speed_limit = 150.0 
local toggle = 118 -- Numpad 9

RegisterNetEvent('sunny:drift:setMode', function(enabled)
    driftmode = enabled
    if enabled then
        ESX.ShowNotification("~g~Mode Drift Activé")
    else
        ESX.ShowNotification("~r~Mode Drift Désactivé")
        if IsPedInAnyVehicle(GetPed(), false) then
            SetVehicleReduceGrip(GetCar(), false)
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		if IsPedInAnyVehicle(GetPed(), false) and driftmode then
			Wait(1)
		else
			Wait(1500)
		end

		if driftmode then
			if IsPedInAnyVehicle(GetPed(), false) then
				CarSpeed = GetEntitySpeed(GetCar()) * speed
				if GetPedInVehicleSeat(GetCar(), -1) == GetPed() then
					if CarSpeed <= drift_speed_limit then  
						if IsControlPressed(1, 21) then
							SetVehicleReduceGrip(GetCar(), true)
						else
							SetVehicleReduceGrip(GetCar(), false)
						end
					else
						SetVehicleReduceGrip(GetCar(), false)
					end
				end
			end
		end
	end
end)

function GetPed() return PlayerPedId() end
function GetCar() return GetVehiclePedIsIn(PlayerPedId(), false) end