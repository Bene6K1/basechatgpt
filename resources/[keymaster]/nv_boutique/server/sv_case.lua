-- Cleaned and refactored Lua code for boutique case system

-- Find a case by its ID in the config
local function findCaseById(caseId)
  for _, case in pairs(Config.Case) do
    if case.id == caseId then
      return case
    end
  end
  return nil
end

-- Select a reward from a case based on chance
local function selectCaseReward(case)
  local rand = math.random(1, 100)
  local cumulative = 0
  for _, reward in ipairs(case.rewards) do
    cumulative = cumulative + reward.chance
    if rand <= cumulative then
      return reward
    end
  end
  -- fallback: return last reward if none matched
  return case.rewards[#case.rewards]
end

RegisterNetEvent("nevaShop:scanCase")
AddEventHandler("nevaShop:scanCase", function(data)
  local src = source
  local case = findCaseById(data.caseId)
  local player = ESX.GetPlayerFromId(src)
  if not player then return end

  if not case then
    TriggerClientEvent("esx:showNotification", src, "~r~Cette caisse n'existe pas.")
    return
  end

  MySQL.Async.fetchAll(
    "SELECT * FROM case_rewards WHERE identifier = @identifier AND case_id = @case_id",
    {
      ["@identifier"] = player.UniqueID,
      ["@case_id"] = case.id
    },
    function(results)
      if results and results[1] then
        TriggerClientEvent("esx:showNotification", src, "~r~Vous avez déjà scanné cette caisse ! Récupérez votre récompense d'abord.")
        return
      end

      local reward = selectCaseReward(case)
      if not reward then return end

      MySQL.Async.execute(
        "INSERT INTO case_rewards (identifier, case_id, reward_name, reward_value) VALUES (@identifier, @case_id, @reward_name, @reward_value)",
        {
          ["@identifier"] = player.UniqueID,
          ["@case_id"] = case.id,
          ["@reward_name"] = reward.name,
          ["@reward_value"] = json.encode({
            type = reward.type,
            model = reward.model or nil,
            amount = reward.amount or nil
          })
        },
        function(rowsChanged)
          if rowsChanged and rowsChanged > 0 then
            TriggerClientEvent("nevaShop:receiveCaseReward", src, case.id, reward)
            TriggerClientEvent("esx:showNotification", src, "~g~Caisse scannée ! Récompense: " .. reward.name)
          else
            TriggerClientEvent("esx:showNotification", src, "~r~Erreur lors du scan de la caisse")
          end
        end
      )
    end
  )
end)

RegisterNetEvent("nevaShop:getScannedCases")
AddEventHandler("nevaShop:getScannedCases", function()
  local src = source
  local player = ESX.GetPlayerFromId(src)
  if not player then return end

  MySQL.Async.fetchAll(
    "SELECT * FROM case_rewards WHERE identifier = @identifier",
    {
      ["@identifier"] = player.UniqueID
    },
    function(results)
      local scannedCases = {}
      for _, row in ipairs(results) do
        table.insert(scannedCases, {
          caseId = row.case_id,
          rewardName = row.reward_name,
          rewardValue = json.decode(row.reward_value)
        })
      end
      TriggerClientEvent("nevaShop:receiveScannedCases", src, scannedCases)
    end
  )
end)
