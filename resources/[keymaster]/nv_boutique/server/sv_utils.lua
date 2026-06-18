-- Utility functions for boutique server

-- Execute a synchronous SQL query
function ExecuteSql(query, params)
  params = params or {}
  return MySQL.Sync.fetchAll(query, params)
end

-- Get the unique identifier for a player by source ID
function GetIdentifier(sourceId)
  local player = ESX.GetPlayerFromId(sourceId)
  if player then
    return player.UniqueID
  end
  return nil
end

-- Character sets for random generation
local digits = {}
local letters = {}

-- Fill digits (0-9)
for i = 48, 57 do
  table.insert(digits, string.char(i))
end

-- Fill uppercase letters (A-Z)
for i = 65, 90 do
  table.insert(letters, string.char(i))
end

-- Fill lowercase letters (a-z)
for i = 97, 122 do
  table.insert(letters, string.char(i))
end

-- Generate a random string of digits
function GetRandomNumber(length)
  Wait(1)
  math.randomseed(GetGameTimer())
  if length > 0 then
    local prev = GetRandomNumber(length - 1)
    local randChar = digits[math.random(1, #digits)]
    return prev .. randChar
  else
    return ""
  end
end

-- Generate a random string of letters (upper/lower)
function GetRandomLetter(length)
  Wait(1)
  math.randomseed(GetGameTimer())
  if length > 0 then
    local prev = GetRandomLetter(length - 1)
    local randChar = letters[math.random(1, #letters)]
    return prev .. randChar
  else
    return ""
  end
end

-- Generate a unique vehicle plate (4 letters + 4 digits, uppercase, not in DB)
function GeneratePlate()
  local plate
  while true do
    Wait(2)
    math.randomseed(GetGameTimer())
    plate = string.upper(GetRandomLetter(4) .. GetRandomNumber(4))
    local result = MySQL.Sync.fetchAll("SELECT 1 FROM owned_vehicles WHERE plate = @plate", {["@plate"] = plate})
    if not result[1] then
      break
    end
  end
  return plate
end

-- Give a vehicle to a player and insert into owned_vehicles
function GiveVehicle(sourceId, plate, vehicleProps, label, vehicleType)
  local player = ESX.GetPlayerFromId(sourceId)
  if not player or not player.UniqueID then return end

  local garageId = 1
  if vehicleType == "boat" then
    garageId = 3
  elseif vehicleType == "aircraft" then
    garageId = 2
  end

  if vehicleType ~= "car" and vehicleType ~= "boat" and vehicleType ~= "aircraft" then
    vehicleType = "car"
    garageId = 1
  end

  local vehicleJson = json.encode(vehicleProps)
  local doublesJson = json.encode({cles = {}})

  MySQL.Async.execute(
    "INSERT INTO owned_vehicles (owner, plate, vehicle, label, garageid, boutique, type, state, job, propertiesID, fuel, doubles, neons) VALUES (@owner, @plate, @vehicle, @label, @garageid, @boutique, @type, @state, @job, @propertiesID, @fuel, @doubles, @neons)",
    {
      ["@owner"] = player.UniqueID,
      ["@plate"] = plate,
      ["@vehicle"] = vehicleJson,
      ["@label"] = label,
      ["@garageid"] = garageId,
      ["@boutique"] = 1,
      ["@type"] = vehicleType,
      ["@state"] = 1,
      ["@job"] = "unemployed",
      ["@propertiesID"] = 0,
      ["@fuel"] = "100",
      ["@doubles"] = doublesJson,
      ["@neons"] = 0
    },
    function(rowsChanged)
      if rowsChanged and rowsChanged > 0 then
        TriggerEvent("sunny:garage:loadPlayerVehicles", player.UniqueID)
        TriggerClientEvent("esx:showNotification", sourceId, "~g~Véhicule ajouté à votre garage ! Rendez-vous au garage pour le récupérer.")
      else
        TriggerClientEvent("esx:showNotification", sourceId, "~r~Erreur lors de l'ajout du véhicule")
      end
    end
  )
end

-- Event to set player instance (routing bucket)
RegisterNetEvent("nevaShop:setInstance")
AddEventHandler("nevaShop:setInstance", function(enableInstance)
  if enableInstance then
    SetPlayerRoutingBucket(source, source)
  else
    SetPlayerRoutingBucket(source, 0)
  end
end)
