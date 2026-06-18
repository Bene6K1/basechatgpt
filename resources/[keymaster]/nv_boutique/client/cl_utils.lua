local tabletEntity = nil
local tabletModel = -1585232418
local tabletAnimDict = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
local tabletAnimName = "base"

-- Deletes the tablet entity if it exists
function deleteTablet()
  if tabletEntity and DoesEntityExist(tabletEntity) then
    DeleteEntity(tabletEntity)
    tabletEntity = nil
  end
end

-- Thread to monitor if the player is still playing the tablet animation
Citizen.CreateThread(function()
  while true do
    Wait(1000)
    if tabletEntity then
      local ped = PlayerPedId()
      if not IsEntityPlayingAnim(ped, tabletAnimDict, tabletAnimName, 3) then
        deleteTablet()
      end
    end
  end
end)

-- Plays the tablet animation and attaches the tablet object to the player's hand
function playTabletAnimation()
  local ped = PlayerPedId()
  local inVehicle = IsPedInAnyVehicle(ped, false)

  if tabletEntity then
    if not inVehicle then
      ClearPedTasksImmediately(ped)
    end
    deleteTablet()
    return
  end

  if inVehicle then
    return
  end

  RequestModel(tabletModel)
  while not HasModelLoaded(tabletModel) do
    Wait(10)
  end

  RequestAnimDict(tabletAnimDict)
  while not HasAnimDictLoaded(tabletAnimDict) do
    Wait(10)
  end

  TaskPlayAnim(ped, tabletAnimDict, tabletAnimName, 3.0, -1, -1, 49, 0, false, false, false)

  local x, y, z = table.unpack(GetEntityCoords(ped))
  tabletEntity = CreateObject(tabletModel, x, y, z + 0.2, true, true, false)

  AttachEntityToEntity(
    tabletEntity,
    ped,
    GetPedBoneIndex(ped, 28422),
    0.0, 0.0, 0.03,
    0.0, 0.0, 0.0,
    true, true, false, true, 1, true
  )
end
