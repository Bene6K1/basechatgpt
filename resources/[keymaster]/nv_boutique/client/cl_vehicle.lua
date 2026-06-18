-- Vehicle Test Drive Handler (Cleaned)

-- Displays a countdown timer on screen for the given duration (in seconds)
local function ShowCountdownTimer(duration)
  CreateThread(function()
    local remaining = duration
    local lastTick = GetGameTimer()
    while remaining > 0 do
      Wait(0)
      SetTextScale(0.5, 0.5)
      SetTextFont(4)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 255)
      SetTextEntry("STRING")
      AddTextComponentString("Temps restant : ~b~" .. remaining .. "s")
      DrawText(0.05, 0.65)
      local now = GetGameTimer()
      if now - lastTick >= 1000 then
        remaining = remaining - 1
        lastTick = now
      end
    end
  end)
end

-- Handles the test drive NUI callback
RegisterNUICallback("testDrive", function(data, cb)
  local playerPed = PlayerPedId()
  local originalCoords = GetEntityCoords(playerPed)
  local testCoords = Config.TestCoords
  local testTime = Config.TestTime

  -- Close NUI and set instance
  SendNUIMessage({ type = "close" })
  TriggerServerEvent("nevaShop:setInstance", true)

  -- Teleport player to test location
  SetEntityCoords(playerPed, testCoords.x, testCoords.y, testCoords.z)
  SetEntityHeading(playerPed, testCoords.h)
  Wait(100)

  -- Check if model is valid and available
  if not (IsModelValid(data.model) and IsModelInCdimage(data.model)) then
    ESX.ShowNotification("~r~Ce véhicule n'est pas disponible !")
    return
  end

  -- Request and load vehicle model
  RequestModel(GetHashKey(data.model))
  while not HasModelLoaded(GetHashKey(data.model)) do
    Wait(10)
  end

  -- Spawn the vehicle and handle the test drive
  ESX.Game.SpawnLocalVehicle(data.model, vector3(testCoords.x, testCoords.y, testCoords.z), testCoords.w, function(vehicle)
    ESX.ShowNotification("Démarrage du test : Vous avez ~b~" .. testTime .. " secondes~s~ pour tester le véhicule.")
    SetVehicleDoorsLocked(vehicle, 2)
    SetEntityInvincible(vehicle, true)
    SetVehicleFixed(vehicle)
    SetVehicleDirtLevel(vehicle, 0.0)
    SetVehicleEngineOn(vehicle, true, true, true)
    SetVehicleLights(vehicle, 2)
    SetPedIntoVehicle(playerPed, vehicle, -1)
    ShowCountdownTimer(testTime)
    Wait(testTime * 1000)
    DeleteVehicle(vehicle)
    SetEntityCoords(playerPed, originalCoords.x, originalCoords.y, originalCoords.z)
    ESX.ShowNotification("~r~Fin du test !")
    TriggerServerEvent("nevaShop:setInstance", false)
  end)

  cb("ok")
end)
