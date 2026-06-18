-- Cleaned Lua code for boutique/server/sv_shop.lua

-- Utility functions to get price or data from config tables

function GetVehiclePrice(model, category)
  local vehicles = Config.Vehicles[category]
  if not vehicles then return nil end
  for _, vehicle in pairs(vehicles) do
    if vehicle.model == model then
      return vehicle.price
    end
  end
  return nil
end

function GetMoneyPrice(amount)
  for _, moneyOption in pairs(Config.Money) do
    if moneyOption.amount == amount then
      return moneyOption.price
    end
  end
  return nil
end

function GetWeaponPrice(model, category)
  local weapons = Config.Weapons[category]
  if not weapons then return nil end
  for _, weapon in pairs(weapons) do
    if weapon.model == model then
      return weapon.price
    end
  end
  return nil
end

function GetCaseData(caseId)
  for _, case in pairs(Config.Case) do
    if case.id == caseId then
      return case
    end
  end
  return nil
end

RegisterNetEvent("nevaShop:buyItem")
function HandleBuyItem(data)
  local playerId = source
  local xPlayer = ESX.GetPlayerFromId(playerId)
  if not xPlayer or not data.type then return end

  if data.type == "vehicle" then
    if not (data.model and data.category and data.name) then
      TriggerClientEvent("esx:showNotification", playerId, "~r~Erreur: Données incomplètes.")
      return
    end

    local price = GetVehiclePrice(data.model, data.category)
    if not price then
      TriggerClientEvent("esx:showNotification", playerId, "~r~Erreur: Prix du véhicule introuvable.")
      return
    end

    GetPlayerCredits(playerId, function(credits)
      if credits >= price then
        local plate = GeneratePlate()
        local vehicleProps = {
          model = GetHashKey(data.model),
          plate = plate,
          fuelLevel = 100.0,
          bodyHealth = 1000.0,
          engineHealth = 1000.0,
          tankHealth = 1000.0,
          dirtLevel = 0.0,
          color1 = 0,
          color2 = 0,
          pearlescentColor = 0,
          wheelColor = 0,
          wheels = 0,
          windowTint = 0,
          neonEnabled = {false, false, false, false},
          extras = {},
          tyreSmokeColor = {255, 255, 255},
          modEngine = -1,
          modBrakes = -1,
          modTransmission = -1,
          modSuspension = -1,
          modArmor = -1,
          modTurbo = false
        }
        local vehicleType = data.vehicleType or Config.Type[data.category] or "car"
        GiveVehicle(playerId, plate, vehicleProps, data.name, vehicleType)
        TriggerEvent("DeleteCredits", playerId, price)
        TriggerClientEvent("esx:showNotification", playerId, ("~g~Achat réussi ! Vous avez acheté un %s pour %d points."):format(data.name, price))
      else
        TriggerClientEvent("esx:showNotification", playerId, "~r~Vous n'avez pas assez de points pour acheter ce véhicule.")
      end
    end)

  elseif data.type == "money" then
    if not data.amount then return end
    local price = GetMoneyPrice(data.amount)
    if not price then
      TriggerClientEvent("esx:showNotification", playerId, "~r~Erreur: Prix introuvable.")
      return
    end

    GetPlayerCredits(playerId, function(credits)
      if credits >= price then
        GiveMoney(playerId, data.amount)
        TriggerEvent("DeleteCredits", playerId, price)
        TriggerClientEvent("esx:showNotification", playerId, ("~g~Achat réussi ! Vous avez acheté %d$ pour %d points."):format(data.amount, price))
      else
        TriggerClientEvent("esx:showNotification", playerId, "~r~Vous n'avez pas assez de points pour acheter cet argent.")
      end
    end)

  elseif data.type == "weapon" then
    if not Config.EnableWeapons then
      TriggerClientEvent("esx:showNotification", playerId, "~r~Les armes ne sont pas disponibles dans la boutique.")
      return
    end
    if not (data.model and data.category) then return end

    local price = GetWeaponPrice(data.model, data.category)
    if not price then
      TriggerClientEvent("esx:showNotification", playerId, "~r~Erreur: Prix de l'arme introuvable.")
      return
    end

    GetPlayerCredits(playerId, function(credits)
      if credits >= price then
        GiveWeapon(playerId, data.model)
        TriggerEvent("DeleteCredits", playerId, price)
        TriggerClientEvent("esx:showNotification", playerId, ("~g~Achat réussi ! Vous avez acheté une %s pour %d points."):format(data.name, price))
      else
        TriggerClientEvent("esx:showNotification", playerId, "~r~Vous n'avez pas assez de points pour acheter cette arme.")
      end
    end)

  elseif data.type == "case" then
    if not (data.name and data.caseId) then return end
    local caseData = GetCaseData(data.caseId)
    if not caseData then
      TriggerClientEvent("esx:showNotification", playerId, "~r~Cette caisse n'existe pas.")
      return
    end

    local result = MySQL.Sync.fetchAll(
      "SELECT * FROM case_rewards WHERE identifier = @identifier AND case_id = @case_id LIMIT 1",
      {["@identifier"] = xPlayer.UniqueID, ["@case_id"] = data.caseId}
    )
    if not (result and result[1]) then
      TriggerClientEvent("esx:showNotification", playerId, "~r~Vous devez d'abord scanner cette caisse.")
      return
    end

    local price = caseData.price or 0
    GetPlayerCredits(playerId, function(credits)
      if credits < price then
        TriggerClientEvent("esx:showNotification", playerId, "~r~Vous n'avez pas assez de points pour récupérer cette récompense.")
        return
      end

      TriggerEvent("DeleteCredits", playerId, price)
      local reward = json.decode(result[1].reward_value)
      if reward.type == "money" then
        GiveMoney(playerId, reward.amount)
        TriggerClientEvent("esx:showNotification", playerId, ("~g~Vous avez reçu %d$!"):format(reward.amount))
      elseif reward.type == "weapon" then
        if Config.EnableWeapons then
          GiveWeapon(playerId, reward.model)
          TriggerClientEvent("esx:showNotification", playerId, "~g~Vous avez reçu une arme !")
        else
          GiveMoney(playerId, 10000)
          TriggerClientEvent("esx:showNotification", playerId, "~o~Les armes sont désactivées. Vous avez reçu 10,000$ à la place !")
        end
      elseif reward.type == "vehicle" then
        local plate = GeneratePlate()
        local vehicleProps = {
          model = GetHashKey(reward.model),
          plate = plate,
          fuelLevel = 100.0,
          bodyHealth = 1000.0,
          engineHealth = 1000.0,
          tankHealth = 1000.0,
          dirtLevel = 0.0,
          color1 = 0,
          color2 = 0,
          pearlescentColor = 0,
          wheelColor = 0,
          wheels = 0,
          windowTint = 0,
          neonEnabled = {false, false, false, false},
          extras = {},
          tyreSmokeColor = {255, 255, 255},
          modEngine = -1,
          modBrakes = -1,
          modTransmission = -1,
          modSuspension = -1,
          modArmor = -1,
          modTurbo = false
        }
        local vehicleType = reward.vehicleType or "car"
        GiveVehicle(playerId, plate, vehicleProps, result[1].reward_name, vehicleType)
        TriggerClientEvent("esx:showNotification", playerId, "~g~Vous avez reçu un véhicule !")
      end

      MySQL.Async.execute(
        "DELETE FROM case_rewards WHERE identifier = @identifier AND case_id = @case_id LIMIT 1",
        {["@identifier"] = xPlayer.UniqueID, ["@case_id"] = data.caseId}
      )

      MySQL.Async.fetchAll(
        "SELECT * FROM case_rewards WHERE identifier = @identifier",
        {["@identifier"] = xPlayer.UniqueID},
        function(cases)
          local scannedCases = {}
          for _, case in ipairs(cases) do
            table.insert(scannedCases, {
              caseId = case.case_id,
              rewardName = case.reward_name,
              rewardValue = json.decode(case.reward_value)
            })
          end
          TriggerClientEvent("nevaShop:receiveScannedCases", playerId, scannedCases)
        end
      )
    end)
  end
end
