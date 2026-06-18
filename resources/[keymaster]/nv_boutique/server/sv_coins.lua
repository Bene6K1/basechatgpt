-- Cleaned and refactored Lua code for FiveM boutique coins system

-- Get player credits (sunnycoins) by source/playerId
function GetPlayerCredits(playerId, cb)
  local player = ESX.GetPlayerFromId(playerId)
  if not player then
    cb(0)
    return
  end

  MySQL.Async.fetchAll(
    "SELECT sunnycoins FROM users WHERE UniqueID = @UniqueID",
    {["@UniqueID"] = player.UniqueID},
    function(result)
      if result and result[1] then
        cb(tonumber(result[1].sunnycoins) or 0)
      else
        cb(0)
      end
    end
  )
end

-- On player loaded, initialize coins if new player
AddEventHandler("esx:playerLoaded", function(source, playerData)
  MySQL.Async.fetchAll(
    "SELECT sunnycoins, totalCoins FROM users WHERE UniqueID = @UniqueID",
    {["@UniqueID"] = playerData.UniqueID},
    function(result)
      if result and result[1] then
        local sunnycoins = tonumber(result[1].sunnycoins) or 0
        local totalCoins = tonumber(result[1].totalCoins) or 0
        if sunnycoins == 0 and totalCoins == 0 then
          MySQL.Async.execute(
            "UPDATE users SET sunnycoins = @sunnycoins WHERE UniqueID = @UniqueID",
            {
              ["@UniqueID"] = playerData.UniqueID,
              ["@sunnycoins"] = Config.DefaultCoins
            }
          )
          print(("[Boutique] Nouveau joueur détecté (UniqueID: %s) - %s coins de départ donnés"):format(playerData.UniqueID, Config.DefaultCoins))
        end
      end
    end
  )
end)

-- Net event: GetPlayerCredits (client requests their coins)
RegisterNetEvent("GetPlayerCredits")
AddEventHandler("GetPlayerCredits", function()
  local src = source
  GetPlayerCredits(src, function(credits)
    TriggerClientEvent("ReceivePlayerCredit", src, credits)
  end)
end)

-- Net event: GetCodeBoutique (client requests their UniqueID)
RegisterNetEvent("GetCodeBoutique")
AddEventHandler("GetCodeBoutique", function()
  local src = source
  local player = ESX.GetPlayerFromId(src)
  if player then
    TriggerClientEvent("ReceiveBoutiqueId", src, player.UniqueID)
  end
end)

-- Server event: DeleteCredits (remove coins from player and add to totalCoins)
RegisterServerEvent("DeleteCredits")
AddEventHandler("DeleteCredits", function(targetSource, amount)
  local src = targetSource or source
  local player = ESX.GetPlayerFromId(src)
  if not player then return end

  MySQL.Async.fetchAll(
    "SELECT sunnycoins, totalCoins FROM users WHERE UniqueID = @UniqueID",
    {["@UniqueID"] = player.UniqueID},
    function(result)
      if result and result[1] then
        local sunnycoins = tonumber(result[1].sunnycoins) or 0
        local totalCoins = tonumber(result[1].totalCoins) or 0
        local newSunnycoins = sunnycoins - amount
        local newTotalCoins = totalCoins + amount

        if newSunnycoins < 0 then
          TriggerClientEvent("esx:showNotification", src, "~r~Erreur: Coins insuffisants")
          return
        end

        MySQL.Async.execute(
          "UPDATE users SET sunnycoins = @sunnycoins, totalCoins = @totalCoins WHERE UniqueID = @UniqueID",
          {
            ["@UniqueID"] = player.UniqueID,
            ["@sunnycoins"] = newSunnycoins,
            ["@totalCoins"] = newTotalCoins
          },
          function()
            MySQL.Async.execute(
              "INSERT INTO boutique_history (uniqueid, data) VALUES (@uniqueid, @data)",
              {
                ["@uniqueid"] = player.UniqueID,
                ["@data"] = ("Dépense de %s coins"):format(amount)
              }
            )
            TriggerClientEvent("ReceivePlayerCredit", src, newSunnycoins)
          end
        )
      end
    end
  )
end)

-- Export: giveBoutiqueCoins (add coins to a player by UniqueID, for admin/console)
exports("giveBoutiqueCoins", function(uniqueId, amount)
  if not uniqueId or not amount then return false, 0 end
  amount = tonumber(amount)
  if not amount or amount <= 0 then return false, 0 end

  local result = MySQL.Sync.fetchAll(
    "SELECT sunnycoins FROM users WHERE UniqueID = @UniqueID",
    {["@UniqueID"] = uniqueId}
  )
  if not result or not result[1] then return false, 0 end

  local currentCoins = tonumber(result[1].sunnycoins) or 0
  local newCoins = currentCoins + amount

  MySQL.Async.execute(
    "UPDATE users SET sunnycoins = @sunnycoins WHERE UniqueID = @UniqueID",
    {
      ["@UniqueID"] = uniqueId,
      ["@sunnycoins"] = newCoins
    },
    function(rowsChanged)
      if rowsChanged > 0 then
        MySQL.Async.execute(
          "INSERT INTO boutique_history (uniqueid, data) VALUES (@uniqueid, @data)",
          {
            ["@uniqueid"] = uniqueId,
            ["@data"] = ("Admin: Ajout de %s coins"):format(amount)
          }
        )
      end
    end
  )
  return true, newCoins
end)

-- Command: /givecoins <UniqueID> <amount> (admin only)
RegisterCommand(Config.Commands.givecoins, function(src, args)
  local player = ESX.GetPlayerFromId(src)
  if src ~= 0 then
    if not player or player.getGroup() ~= "fondateur" then
      TriggerClientEvent("esx:showNotification", src, "~r~Vous n'avez pas la permission.")
      return
    end
  end

  local uniqueId = tonumber(args[1])
  local amount = tonumber(args[2])
  if not uniqueId or not amount then
    local usage = "/" .. Config.Commands.givecoins .. " <UniqueID> <montant>"
    if src == 0 then
      print("[Boutique] Usage: " .. usage)
    else
      TriggerClientEvent("esx:showNotification", src, "~r~Usage: " .. usage)
    end
    return
  end

  MySQL.Async.fetchAll(
    "SELECT sunnycoins FROM users WHERE UniqueID = @UniqueID",
    {["@UniqueID"] = uniqueId},
    function(result)
      if not result or not result[1] then
        if src == 0 then
          print(("[Boutique] Joueur avec UniqueID %s introuvable"):format(uniqueId))
        else
          TriggerClientEvent("esx:showNotification", src, "~r~Joueur introuvable")
        end
        return
      end

      local currentCoins = tonumber(result[1].sunnycoins) or 0
      local newCoins = currentCoins + amount

      MySQL.Async.execute(
        "UPDATE users SET sunnycoins = @sunnycoins WHERE UniqueID = @UniqueID",
        {
          ["@UniqueID"] = uniqueId,
          ["@sunnycoins"] = newCoins
        },
        function(rowsChanged)
          if rowsChanged > 0 then
            MySQL.Async.execute(
              "INSERT INTO boutique_history (uniqueid, data) VALUES (@uniqueid, @data)",
              {
                ["@uniqueid"] = uniqueId,
                ["@data"] = ("Admin: Ajout de %s coins (console)"):format(amount)
              }
            )
            if src == 0 then
              print(("[Boutique] %s coins ajoutés au joueur %s (Nouveau solde: %s)"):format(amount, uniqueId, newCoins))
            else
              TriggerClientEvent("esx:showNotification", src, ("~g~%s coins ajoutés au joueur %s"):format(amount, uniqueId))
            end

            -- Notify the player if online
            for _, playerId in ipairs(GetPlayers()) do
              local onlinePlayer = ESX.GetPlayerFromId(tonumber(playerId))
              if onlinePlayer and onlinePlayer.UniqueID == uniqueId then
                TriggerClientEvent("ReceivePlayerCredit", playerId, newCoins)
                TriggerClientEvent("esx:showNotification", playerId, ("~g~Vous avez reçu %s coins !"):format(amount))
                break
              end
            end
          end
        end
      )
    end
  )
end, false)
