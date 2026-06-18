


if Config and Config.ESXMode == "old" then
  ESX = ESX or nil
  TriggerEvent("esx:getSharedObject", function(obj)
      ESX = obj
  end)
else
  ESX = exports.es_extended:getSharedObject()
end


local function GetPlayerGang(xPlayer)
  if not xPlayer then return nil end
  local gang = xPlayer.job2 or xPlayer.getJob2 and xPlayer:getJob2() or nil
  if not gang or not gang.name or gang.name == "" or gang.name == "unemployed" or gang.name == "unemployed2" then
    return nil
  end
  return gang
end

local function EnsureGangCrew(xPlayer)
  if not xPlayer then return nil end

  local gang = GetPlayerGang(xPlayer)
  if not gang then return nil end

  local crewKey = gang.name
  local crewLabel = gang.label or gang.name
  local defaultColor = "#50B4FF"

  local crewId = MySQL.Sync.fetchScalar("SELECT id_crew FROM crew_liste WHERE name = @name", {
    ["@name"] = crewKey
  })

  if not crewId then
    MySQL.Sync.execute("INSERT INTO crew_liste (name, devise, color_hex) VALUES (@name, @devise, @color)", {
      ["@name"] = crewKey,
      ["@devise"] = crewLabel,
      ["@color"] = defaultColor
    })
    crewId = MySQL.Sync.fetchScalar("SELECT id_crew FROM crew_liste WHERE name = @name", {["@name"] = crewKey})
  end

  local gradeCount = MySQL.Sync.fetchScalar("SELECT COUNT(*) FROM crew_grades WHERE id_crew = @id", {["@id"] = crewId}) or 0
  if gradeCount == 0 then
    MySQL.Sync.execute("INSERT INTO crew_grades (name, rang, id_crew, gestion, sell_vehicle) VALUES (@name, 1, @id, 1, 1)", {
      ["@name"] = gang.grade_label or "Leader",
      ["@id"] = crewId
    })
    MySQL.Sync.execute("INSERT INTO crew_grades (name, rang, id_crew, gestion, sell_vehicle) VALUES (@name, 2, @id, 0, 0)", {
      ["@name"] = "Membre",
      ["@id"] = crewId
    })
  end

  local leaderGrade = MySQL.Sync.fetchAll("SELECT id_grade, name, rang FROM crew_grades WHERE id_crew = @id ORDER BY rang ASC", {["@id"] = crewId}) or {}
  local leaderId, memberId = nil, nil
  for _, row in ipairs(leaderGrade) do
    if row.rang == 1 then leaderId = row.id_grade end
    if row.rang ~= 1 and not memberId then memberId = row.id_grade end
  end
  leaderId = leaderId or memberId
  memberId = memberId or leaderId

  local gangGradeName = (gang.grade_name or gang.gradeLabel or ""):lower()
  local gangGradeLevel = gang.grade or 0
  local desiredGrade = memberId
  if gangGradeName == "boss" or gangGradeLevel >= 4 then
    desiredGrade = leaderId
  end


  local existing = MySQL.Sync.fetchScalar("SELECT 1 FROM crew_membres WHERE identifier = @identifier LIMIT 1", {
    ["@identifier"] = xPlayer.identifier
  })

  local gradeData = MySQL.Sync.fetchAll("SELECT name, rang FROM crew_grades WHERE id_grade = @id", {["@id"] = desiredGrade})[1]
  local labelGrade = gradeData and gradeData.name or gang.grade_label or "Membre"
  local rangGrade = gradeData and gradeData.rang or 2

  if existing then
    MySQL.Sync.execute([[
      UPDATE crew_membres
         SET id_crew = @crew,
             id_grade = @grade,
             label = @label,
             label_grade = @label_grade,
             rang_grade = @rang_grade
       WHERE identifier = @identifier
    ]], {
      ["@crew"] = crewId,
      ["@grade"] = desiredGrade,
      ["@label"] = xPlayer.getName(),
      ["@label_grade"] = labelGrade,
      ["@rang_grade"] = rangGrade,
      ["@identifier"] = xPlayer.identifier
    })
  else
    MySQL.Sync.execute([[
      INSERT INTO crew_membres (identifier, label, id_grade, label_grade, rang_grade, id_crew)
      VALUES (@identifier, @label, @grade, @label_grade, @rang_grade, @crew)
    ]], {
      ["@identifier"] = xPlayer.identifier,
      ["@label"] = xPlayer.getName(),
      ["@grade"] = desiredGrade,
      ["@label_grade"] = labelGrade,
      ["@rang_grade"] = rangGrade,
      ["@crew"] = crewId
    })
  end

  return crewId, gang, desiredGrade
end


AddEventHandler("esx:playerLoaded", function(playerId, xPlayer)
  local player = xPlayer or ESX.GetPlayerFromId(playerId)
  if player then
    EnsureGangCrew(player)
  end
end)

AddEventHandler("esx:setJob2", function(playerId, newJob, oldJob)
  local player = ESX.GetPlayerFromId(playerId)
  if player then
    EnsureGangCrew(player)
  end
end)


function GetPlayerGroup(player)
  if not player then return nil end

  local group = nil

  if Config.ESXMode == "old" then
      group = player.getGroup and player.getGroup() or player.group
  else
      group = (player.getGroup and player.getGroup()) or player.group
  end

  if group then
      return tostring(group):lower()
  end

  return nil
end

function IsPlayerAdmin(group)
  if not group then return false end

  local adminGroups = Config.AdminGroups or {}
  local groupLower = tostring(group):lower()

  for _, adminGroup in ipairs(adminGroups) do
      if tostring(adminGroup):lower() == groupLower then
          return true
      end
  end

  return false
end

function CalculateCrewLevel(xp)
  local level = 1

  for levelNum, requiredXp in pairs(Config.CrewLevels) do
      if requiredXp <= xp then
          level = levelNum
      else
          break
      end
  end

  return level
end

function GetDiscordIdFromPlayer(playerSource)
  local identifiers = GetPlayerIdentifiers(playerSource)

  for _, id in ipairs(identifiers) do
      if type(id) == "string" and string.sub(id, 1, 8) == "discord:" then
          return string.sub(id, 9)
      end
  end

  return nil
end

function CheckDiscordRole(discordId, botToken, guildId, allowedRoleId, callback)
  local apiUrl = string.format("https://discord.com/api/v10/guilds/%s/members/%s", guildId, discordId)

  PerformHttpRequest(apiUrl, function(statusCode, responseBody, headers)
      if statusCode ~= 200 or not responseBody then
          callback(false)
          return
      end

      local success, data = pcall(json.decode, responseBody)

      if not (success and data and data.roles) then
          callback(false)
          return
      end

      local hasRole = false
      for _, roleId in ipairs(data.roles) do
          if tostring(roleId) == allowedRoleId then
              hasRole = true
              break
          end
      end

      callback(hasRole)
  end, "GET", "", {
      ["Content-Type"] = "application/json",
      ["Authorization"] = "Bot " .. botToken
  })
end

function GetAllTerritories()
  return Config.Territories or {}
end


ESX.RegisterServerCallback("GetPermGestion", function(source, cb)
  local player = ESX.GetPlayerFromId(source)

  if not player then
      cb(false)
      return
  end

  local gang = GetPlayerGang(player)
  if not gang then
      cb(false)
      return
  end

  local isBoss = (gang.grade_name and gang.grade_name:lower() == "boss") or (gang.grade and gang.grade >= 4)
  cb(isBoss == true)
end)

ESX.RegisterServerCallback("GetCrewPly", function(source, cb)
  local player = ESX.GetPlayerFromId(source)

  if not player then
      cb(true)
      return
  end

  local gang = GetPlayerGang(player)
  if not gang then
      cb(true)
      return
  end

  EnsureGangCrew(player)
  cb(false)
end)

ESX.RegisterServerCallback("crew:canCreateCrew", function(source, cb)
  local player = ESX.GetPlayerFromId(source)

  if not player then
      cb(false, "error")
      return
  end


  cb(false, "job_based")
end)

ESX.RegisterServerCallback("Territories:StatusWithColor", function(source, cb)
  local query = [[
      SELECT t1.territory_name, t1.id_crew, t1.score_total AS max_score, cl.color_hex, cl.name AS crew_name, cl.devise AS crew_devise
      FROM territoires t1
      INNER JOIN (
          SELECT territory_name, MAX(score_total) AS max_score
          FROM territoires
          GROUP BY territory_name
      ) t2 ON t1.territory_name = t2.territory_name AND t1.score_total = t2.max_score
      LEFT JOIN crew_liste cl ON cl.id_crew = t1.id_crew
  ]]

  MySQL.Async.fetchAll(query, {}, function(results)
      local territories = {}

      if results then
          for _, row in ipairs(results) do
              local name = row.territory_name
              local score = tonumber(row.max_score) or 0
              local crewId = row.id_crew
              local color = row.color_hex
              local crewName = row.crew_name
              local crewDevise = row.crew_devise

              territories[name] = {
                  controlled = (crewId ~= nil and score > 0),
                  color = color,
                  crewName = crewName,
                  crewDevise = crewDevise
              }
          end
      end

      local allTerritories = GetAllTerritories()
      for i = 1, #allTerritories do
          local territory = allTerritories[i]
          if territory and territory.name and territories[territory.name] == nil then
              territories[territory.name] = {
                  controlled = false,
                  color = nil,
                  crewName = nil,
                  crewDevise = nil
              }
          end
      end

      MySQL.Async.fetchAll(
          "SELECT territory_name, COUNT(DISTINCT id_crew) AS crew_count FROM territoires GROUP BY territory_name",
          {},
          function(competitionData)
              if competitionData then
                  for _, row in ipairs(competitionData) do
                      local territoryName = row.territory_name
                      local crewCount = tonumber(row.crew_count) or 0

                      if territories[territoryName] then
                          territories[territoryName].competition = crewCount
                      end
                  end
              end

              cb(territories)
          end
      )
  end)
end)

ESX.RegisterServerCallback("crew:checkLvl", function(source, cb, requiredLevel)
  local player = ESX.GetPlayerFromId(source)

  if not player then
      cb(false)
      return
  end

  local levelRequired = tonumber(requiredLevel) or 1

  local crewId = EnsureGangCrew(player)
  if not crewId then
      TriggerClientEvent("esx:showNotification", source, _U("crew_level_not_enough"))
      cb(false)
      return
  end

  local xp = MySQL.Sync.fetchScalar("SELECT xp FROM crew_liste WHERE id_crew = @id", {["@id"] = crewId}) or 0
  local currentLevel = CalculateCrewLevel(tonumber(xp) or 0)

  if currentLevel >= levelRequired then
      cb(true)
  else
      TriggerClientEvent("esx:showNotification", source, _U("crew_level_not_enough"))
      cb(false)
  end
end)

ESX.RegisterServerCallback("ListeMembres", function(source, cb)
  local player = ESX.GetPlayerFromId(source)

  if not player then
      cb({})
      return
  end

  MySQL.Async.fetchAll(
      "SELECT * FROM crew_membres WHERE identifier = @identifier",
      {["@identifier"] = player.identifier},
      function(memberResult)
          if memberResult and memberResult[1] then
              local crewId = memberResult[1].id_crew

              MySQL.Async.fetchAll(
                  "SELECT * FROM crew_membres WHERE id_crew = @id_crew",
                  {["@id_crew"] = crewId},
                  function(members)
                      cb(members)
                  end
              )
          else
              cb({})
          end
      end
  )
end)

ESX.RegisterServerCallback("GetAllRang", function(source, cb)
  local player = ESX.GetPlayerFromId(source)

  if not player then
      cb({})
      return
  end

  MySQL.Async.fetchAll(
      "SELECT * FROM crew_membres WHERE identifier = @identifier",
      {["@identifier"] = player.identifier},
      function(memberResult)
          if memberResult and memberResult[1] then
              local crewId = memberResult[1].id_crew

              MySQL.Async.fetchAll(
                  "SELECT * FROM crew_grades WHERE id_crew = @id_crew",
                  {["@id_crew"] = crewId},
                  function(grades)
                      cb(grades)
                  end
              )
          else
              cb({})
          end
      end
  )
end)

ESX.RegisterServerCallback("InfosCrew", function(source, cb)
  local player = ESX.GetPlayerFromId(source)

  if not player then
      cb({})
      return
  end

  MySQL.Async.fetchAll(
      "SELECT * FROM crew_membres WHERE identifier = @identifier",
      {["@identifier"] = player.identifier},
      function(memberResult)
          if memberResult and memberResult[1] then
              local crewId = memberResult[1].id_crew

              MySQL.Async.fetchAll(
                  "SELECT * FROM crew_liste WHERE id_crew = @id_crew",
                  {["@id_crew"] = crewId},
                  function(crewInfo)
                      cb(crewInfo)
                  end
              )
          else
              cb({})
          end
      end
  )
end)

ESX.RegisterServerCallback("GetCrewExperience", function(source, cb)
  local player = ESX.GetPlayerFromId(source)

  if not player then
      cb(nil)
      return
  end

  local crewId = EnsureGangCrew(player)
  if not crewId then
      cb(nil)
      return
  end

  local data = MySQL.Sync.fetchAll("SELECT name, xp FROM crew_liste WHERE id_crew = @id LIMIT 1", {["@id"] = crewId})[1]
  if not data then
      cb(nil)
      return
  end

  local xp = tonumber(data.xp) or 0
  local level = CalculateCrewLevel(xp)

  cb({
      name = data.name,
      xp = xp,
      level = level
  })
end)

ESX.RegisterServerCallback("GetCrewTerritories", function(source, cb)
  local player = ESX.GetPlayerFromId(source)

  if not player then
      cb({})
      return
  end

  local crewId = EnsureGangCrew(player)
  if not crewId then
      cb({})
      return
  end

  MySQL.Async.fetchAll(
      "SELECT territory_name, id_crew, score_total FROM territoires",
      {},
      function(territoryData)
          local controlledTerritories = {}
          local territoryLeaders = {}

          for _, row in pairs(territoryData) do
              local name = row.territory_name

              if not territoryLeaders[name] then
                  territoryLeaders[name] = {
                      id_crew = row.id_crew,
                      score_total = row.score_total
                  }
              else
                  if row.score_total > territoryLeaders[name].score_total then
                      territoryLeaders[name] = {
                          id_crew = row.id_crew,
                          score_total = row.score_total
                      }
                  end
              end
          end

          for territoryName, data in pairs(territoryLeaders) do
              if data.id_crew == crewId then
                  table.insert(controlledTerritories, {
                      name = territoryName,
                      points = data.score_total
                  })
              end
          end


          HasCrewClaimedTodayDB(crewId, function(hasClaimed)
             local nextClaim = "Maintenant"
             if hasClaimed then
                 local tomorrow = os.time() + 86400
                 local dateTable = os.date("*t", tomorrow)
                 nextClaim = string.format("%02d/%02d/%04d 00:00", dateTable.day, dateTable.month, dateTable.year)
             end

             cb(controlledTerritories, nextClaim)
          end)
      end
  )
end)

ESX.RegisterServerCallback("CheckAndRenameGrade", function(source, cb, newName, gradeId)
  local player = ESX.GetPlayerFromId(source)

  if not player then
      cb(false)
      return
  end

  MySQL.Async.fetchAll(
      "SELECT id_crew FROM crew_grades WHERE id_grade = @id_grade",
      {["@id_grade"] = gradeId},
      function(gradeResult)
          if not gradeResult[1] then
              cb(false)
              return
          end

          local crewId = gradeResult[1].id_crew

          MySQL.Async.fetchAll(
              "SELECT * FROM crew_grades WHERE name = @name AND id_crew = @id_crew AND id_grade != @id_grade",
              {
                  ["@name"] = newName,
                  ["@id_crew"] = crewId,
                  ["@id_grade"] = gradeId
              },
              function(existingGrades)
                  if #existingGrades > 0 then
                      cb(false)
                  else
                      MySQL.Async.execute(
                          "UPDATE crew_grades SET name = @new_name WHERE id_grade = @id_grade",
                          {
                              ["@new_name"] = newName,
                              ["@id_grade"] = gradeId
                          },
                          function(affectedRows)
                              cb(affectedRows > 0)
                          end
                      )
                  end
              end
          )
      end
  )
end)

ESX.RegisterServerCallback("nvTerritory:getPlayerCrew", function(source, cb)
  local player = ESX.GetPlayerFromId(source)

  if not player then
      cb(nil)
      return
  end

  local _, gang = EnsureGangCrew(player)
  cb(gang and (gang.label or gang.name) or nil)
end)

ESX.RegisterServerCallback("nvTerritory:isPlayerInCrew", function(source, cb)
  local player = ESX.GetPlayerFromId(source)

  if not player then
      cb(false)
      return
  end

  local gang = GetPlayerGang(player)
  cb(gang ~= nil)
end)

ESX.RegisterServerCallback("nvTerritory:getPlayerCrewId", function(source, cb)
  local player = ESX.GetPlayerFromId(source)

  if not player then
      cb(nil)
      return
  end

  local crewId = EnsureGangCrew(player)
  cb(crewId)
end)


RegisterNetEvent("crew:addXP")
AddEventHandler("crew:addXP", function(xpAmount, playerSource)
  if type(source) == "number" and source > 0 then
      print("[crew:addXP] Rejected: client call attempt (source=" .. tostring(source) .. ")")
      return
  end

  local targetSource = tonumber(playerSource)
  if not targetSource or targetSource <= 0 then
      print("[crew:addXP] Rejected: invalid playerSource")
      return
  end

  local player = ESX.GetPlayerFromId(targetSource)
  if not player then return end

  local crewId = EnsureGangCrew(player)
  if not crewId then return end

  local currentXp = MySQL.Sync.fetchScalar("SELECT xp FROM crew_liste WHERE id_crew = @id", {["@id"] = crewId}) or 0
  local xpToAdd = tonumber(xpAmount) or 0
  if xpToAdd <= 0 then return end

  local newXp = tonumber(currentXp) + xpToAdd

  MySQL.Async.execute(
      "UPDATE crew_liste SET xp = @newXp WHERE id_crew = @id",
      {
          ["@newXp"] = newXp,
          ["@id"] = crewId
      }
  )
end)

RegisterNetEvent("crew:updateColor")
AddEventHandler("crew:updateColor", function(colorHex)
  local source = source
  local xPlayer = ESX.GetPlayerFromId(source)

  if not xPlayer then return end

  local crewId = EnsureGangCrew(xPlayer)
  if not crewId then
      xPlayer.showNotification("Vous n'avez pas de crew.")
      return
  end


  MySQL.Async.fetchScalar("SELECT rang_grade FROM crew_membres WHERE identifier = ?", {xPlayer.identifier}, function(rang)
      if rang and tonumber(rang) == 1 then

           MySQL.Async.execute("UPDATE crew_liste SET color_hex = ? WHERE id_crew = ?", {colorHex, crewId}, function()
               xPlayer.showNotification("Couleur de crew mise à jour: "..colorHex)

               TriggerClientEvent("nvTerritory:reloadTerritories", -1)
           end)
      else
          xPlayer.showNotification("~r~Seul le chef peut changer la couleur.")
      end
  end)
end)

function CreateDefaultGrades(crewId, defaultGrades, callback)
  local function CreateGrade(index)
      if index > #defaultGrades then
          callback()
          return
      end

      local grade = defaultGrades[index]

      MySQL.Async.execute(
          "INSERT INTO crew_grades (name, rang, id_crew) VALUES (@name, @rang, @id_crew)",
          {
              ["@name"] = grade.name,
              ["@rang"] = tonumber(grade.rang),
              ["@id_crew"] = tonumber(crewId)
          },
          function()
              CreateGrade(index + 1)
          end
      )
  end

  CreateGrade(1)
end

RegisterNetEvent("CreateCrew")
AddEventHandler("CreateCrew", function(crewName, devise, leaderGradeName, defaultGrades, colorHex)
  local player = ESX.GetPlayerFromId(source)
  if not player then return end

  MySQL.Async.fetchAll(
      "SELECT name FROM crew_liste WHERE name = @name",
      {["@name"] = crewName},
      function(existingCrew)
          if existingCrew[1] then
              player.showNotification(_U("crew_name_already_exists"))
              return
          end

          MySQL.Async.execute(
              "INSERT INTO crew_liste (name, devise, color_hex) VALUES(@name, @devise, @color_hex)",
              {
                  ["@name"] = crewName,
                  ["@devise"] = devise,
                  ["@color_hex"] = tostring(colorHex or "#50B4FF")
              },
              function()
                  MySQL.Async.fetchAll(
                      "SELECT * FROM crew_liste WHERE name = @name",
                      {["@name"] = crewName},
                      function(newCrew)
                          if not newCrew[1] then
                              player.showNotification(_U("error_fetching_crew_id"))
                              return
                          end

                          local crewId = newCrew[1].id_crew

                          MySQL.Async.execute(
                              "INSERT INTO crew_grades (name, rang, id_crew, gestion, sell_vehicle) VALUES (@name, @rang, @id_crew, @gestion, @sell_vehicle)",
                              {
                                  ["@name"] = leaderGradeName,
                                  ["@rang"] = 1,
                                  ["@gestion"] = 1,
                                  ["@sell_vehicle"] = 1,
                                  ["@id_crew"] = tonumber(crewId)
                              },
                              function()
                                  CreateDefaultGrades(crewId, defaultGrades, function()
                                      MySQL.Async.fetchAll(
                                          "SELECT * FROM crew_grades WHERE id_crew = @id_crew AND rang = @rang",
                                          {
                                              ["@id_crew"] = tonumber(crewId),
                                              ["@rang"] = 1
                                          },
                                          function(leaderGrade)
                                              if not leaderGrade[1] then
                                                  player.showNotification(_U("error_creating_leader_rank"))
                                                  return
                                              end

                                              local gradeId = leaderGrade[1].id_grade

                                              MySQL.Async.execute(
                                                  "INSERT INTO crew_membres (identifier, label, id_grade, label_grade, rang_grade, id_crew) VALUES (@identifier, @label, @id_grade, @label_grade, @rang_grade, @id_crew)",
                                                  {
                                                      ["@identifier"] = player.identifier,
                                                      ["@label"] = player.getName(),
                                                      ["@id_grade"] = gradeId,
                                                      ["label_grade"] = leaderGradeName,
                                                      ["rang_grade"] = 1,
                                                      ["@id_crew"] = tonumber(crewId)
                                                  },
                                                  function(inserted)
                                                      if inserted > 0 then
                                                          player.showNotification(_U("you_created_crew", crewName, devise, #defaultGrades + 1))
                                                          TriggerEvent("nvTerritory:playerJoinedCrew", player.source, player.identifier, tonumber(crewId), crewName)
                                                      end
                                                  end
                                              )
                                          end
                                      )
                                  end)
                              end
                          )
                      end
                  )
              end
          )
      end
  )
end)

RegisterNetEvent("FireThePlayer")
AddEventHandler("FireThePlayer", function(targetIdentifier)
  MySQL.Async.fetchAll(
      "SELECT id_crew FROM crew_membres WHERE identifier = @identifier",
      {["@identifier"] = targetIdentifier},
      function(memberData)
          if not memberData[1] then return end

          local crewId = memberData[1].id_crew

          MySQL.Async.fetchAll(
              "SELECT name FROM crew_liste WHERE id_crew = @id_crew",
              {["@id_crew"] = crewId},
              function(crewData)
                  local crewName = (crewData[1] and crewData[1].name) or nil

                  MySQL.Async.execute(
                      "DELETE FROM crew_membres WHERE identifier = @identifier",
                      {["@identifier"] = targetIdentifier},
                      function(deleted)
                          if deleted > 0 then
                              local targetPlayer = nil
                              local allPlayers = ESX.GetPlayers()

                              for _, playerId in ipairs(allPlayers) do
                                  local p = ESX.GetPlayerFromId(playerId)
                                  if p and p.identifier == targetIdentifier then
                                      targetPlayer = playerId
                                      break
                                  end
                              end

                              TriggerEvent("nvTerritory:playerLeftCrew", targetPlayer, targetIdentifier, crewId, crewName)
                          end
                      end
                  )
              end
          )
      end
  )
end)

RegisterNetEvent("LeaveCrew")
AddEventHandler("LeaveCrew", function()
  local player = ESX.GetPlayerFromId(source)
  if not player then return end

  MySQL.Async.fetchAll(
      "SELECT * FROM crew_membres WHERE identifier = @identifier",
      {["@identifier"] = player.identifier},
      function(memberData)
          if not memberData[1] then
              player.showNotification(_U("not_in_crew"))
              return
          end

          local crewId = memberData[1].id_crew

          MySQL.Async.fetchAll(
              "SELECT name FROM crew_liste WHERE id_crew = @id_crew",
              {["@id_crew"] = crewId},
              function(crewData)
                  local crewName = (crewData[1] and crewData[1].name) or nil

                  MySQL.Async.execute(
                      "DELETE FROM crew_membres WHERE identifier = @identifier",
                      {["@identifier"] = player.identifier},
                      function(deleted)
                          if deleted > 0 then
                              player.showNotification(_U("you_left_crew"))
                              TriggerEvent("nvTerritory:playerLeftCrew", player.source, player.identifier, crewId, crewName)
                          end
                      end
                  )
              end
          )
      end
  )
end)


invitationData = {
  recruiter = {},
  targetLabel = {},
  gradeId = {},
  gradeName = {},
  gradeRank = {},
  crewId = {}
}

RegisterServerEvent("RecrutThePlayer")
AddEventHandler("RecrutThePlayer", function(targetId)
  local targetPlayer = ESX.GetPlayerFromId(targetId)
  local recruiter = ESX.GetPlayerFromId(source)

  if not targetPlayer or not recruiter then
      if recruiter then
          recruiter.showNotification(_U("player_not_found"))
      end
      return
  end

  MySQL.Async.fetchAll(
      "SELECT * FROM crew_membres WHERE identifier = @identifier",
      {["@identifier"] = targetPlayer.identifier},
      function(targetMember)
          if targetMember[1] then
              recruiter.showNotification(_U("player_already_in_crew"))
              return
          end

          MySQL.Async.fetchAll(
              "SELECT * FROM crew_membres WHERE identifier = @identifier",
              {["@identifier"] = recruiter.identifier},
              function(recruiterMember)
                  if not recruiterMember[1] then
                      recruiter.showNotification(_U("not_in_crew"))
                      return
                  end

                  local crewId = recruiterMember[1].id_crew

                  MySQL.Async.fetchAll(
                      "SELECT * FROM crew_grades WHERE id_crew = @id_crew ORDER BY rang DESC",
                      {["@id_crew"] = crewId},
                      function(grades)
                          if not grades[1] then return end

                          local lowestGrade = grades[1]
                          local gradeId = lowestGrade.id_grade
                          local gradeName = lowestGrade.name
                          local gradeRank = lowestGrade.rang

                          MySQL.Async.fetchAll(
                              "SELECT * FROM crew_liste WHERE id_crew = @id_crew",
                              {["@id_crew"] = crewId},
                              function(crewInfo)
                                  if not crewInfo[1] then return end

                                  local crewName = crewInfo[1].name
                                  local targetName = targetPlayer.getName()

                                  invitationData.recruiter[targetId] = source
                                  invitationData.targetLabel[targetId] = targetName
                                  invitationData.gradeId[targetId] = gradeId
                                  invitationData.gradeName[targetId] = gradeName
                                  invitationData.gradeRank[targetId] = gradeRank
                                  invitationData.crewId[targetId] = crewId

                                  recruiter.showNotification(_U("invited_player_to_crew", targetName))
                                  TriggerClientEvent("SolutionCrewInvitation", targetId, crewName, source)
                              end
                          )
                      end
                  )
              end
          )
      end
  )
end)

RegisterServerEvent("AcceptInvitation")
AddEventHandler("AcceptInvitation", function()
  local player = ESX.GetPlayerFromId(source)
  if not player then return end

  local recruiterId = invitationData.recruiter[source]
  local targetLabel = invitationData.targetLabel[source]
  local gradeId = invitationData.gradeId[source]
  local gradeName = invitationData.gradeName[source]
  local gradeRank = invitationData.gradeRank[source]
  local crewId = invitationData.crewId[source]

  if not recruiterId or not gradeId or not crewId then
      player.showNotification(_U("invitation_expired"))
      return
  end

  MySQL.Async.execute(
      "INSERT INTO crew_membres (identifier, label, id_grade, label_grade, rang_grade, id_crew) VALUES (@identifier, @label, @id_grade, @label_grade, @rang_grade, @id_crew)",
      {
          ["@identifier"] = player.identifier,
          ["@label"] = player.getName(),
          ["@id_grade"] = gradeId,
          ["@label_grade"] = gradeName,
          ["@rang_grade"] = gradeRank,
          ["@id_crew"] = crewId
      },
      function(inserted)
          if inserted > 0 then
              local recruiter = ESX.GetPlayerFromId(recruiterId)
              if recruiter then
                  recruiter.showNotification(_U("player_accepted_invitation", targetLabel))
              end

              player.showNotification(_U("you_joined_crew"))

              MySQL.Async.fetchAll(
                  "SELECT name FROM crew_liste WHERE id_crew = @id_crew",
                  {["@id_crew"] = crewId},
                  function(crewData)
                      local crewName = (crewData[1] and crewData[1].name) or nil
                      TriggerEvent("nvTerritory:playerJoinedCrew", source, player.identifier, crewId, crewName)
                  end
              )

              invitationData.recruiter[source] = nil
              invitationData.targetLabel[source] = nil
              invitationData.gradeId[source] = nil
              invitationData.gradeName[source] = nil
              invitationData.gradeRank[source] = nil
              invitationData.crewId[source] = nil
          end
      end
  )
end)

RegisterServerEvent("RefuseInvitation")
AddEventHandler("RefuseInvitation", function()
  local player = ESX.GetPlayerFromId(source)
  if not player then return end

  local recruiterId = invitationData.recruiter[source]
  local targetLabel = invitationData.targetLabel[source]

  if recruiterId then
      local recruiter = ESX.GetPlayerFromId(recruiterId)
      if recruiter then
          recruiter.showNotification(_U("player_refused_invitation", targetLabel))
      end
  end

  invitationData.recruiter[source] = nil
  invitationData.targetLabel[source] = nil
  invitationData.gradeId[source] = nil
  invitationData.gradeName[source] = nil
  invitationData.gradeRank[source] = nil
  invitationData.crewId[source] = nil

  player.showNotification(_U("you_refused_invitation"))
end)

RegisterServerEvent("ChangePlayerRang")
AddEventHandler("ChangePlayerRang", function(targetIdentifier, newGradeId)
  local player = ESX.GetPlayerFromId(source)
  if not player then return end

  MySQL.Async.fetchAll(
      "SELECT * FROM crew_grades WHERE id_grade = @id_grade",
      {["@id_grade"] = newGradeId},
      function(gradeResult)
          if not gradeResult[1] then return end

          local gradeName = gradeResult[1].name
          local gradeRank = gradeResult[1].rang

          MySQL.Async.execute(
              "UPDATE crew_membres SET id_grade = @id_grade, label_grade = @label_grade, rang_grade = @rang_grade WHERE identifier = @identifier",
              {
                  ["@id_grade"] = newGradeId,
                  ["@label_grade"] = gradeName,
                  ["@rang_grade"] = gradeRank,
                  ["@identifier"] = targetIdentifier
              },
              function(affectedRows)
                  if affectedRows > 0 then
                      player.showNotification(_U("rank_changed_success"))
                  end
              end
          )
      end
  )
end)

RegisterServerEvent("CreateNewRang")
AddEventHandler("CreateNewRang", function(rangName, rangLevel)
  local player = ESX.GetPlayerFromId(source)
  if not player then return end

  MySQL.Async.fetchAll(
      "SELECT * FROM crew_membres WHERE identifier = @identifier",
      {["@identifier"] = player.identifier},
      function(memberResult)
          if not memberResult[1] then return end

          local crewId = memberResult[1].id_crew

          MySQL.Async.fetchAll(
              "SELECT * FROM crew_grades WHERE name = @name AND id_crew = @id_crew",
              {
                  ["@name"] = rangName,
                  ["@id_crew"] = crewId
              },
              function(existingGrades)
                  if #existingGrades > 0 then
                      player.showNotification(_U("rank_name_already_exists"))
                      return
                  end

                  MySQL.Async.execute(
                      "INSERT INTO crew_grades (name, rang, id_crew) VALUES (@name, @rang, @id_crew)",
                      {
                          ["@name"] = rangName,
                          ["@rang"] = tonumber(rangLevel),
                          ["@id_crew"] = crewId
                      },
                      function(inserted)
                          if inserted > 0 then
                              player.showNotification(_U("rank_created_success", rangName))
                          end
                      end
                  )
              end
          )
      end
  )
end)

RegisterServerEvent("DeleteRang")
AddEventHandler("DeleteRang", function(gradeId)
  local player = ESX.GetPlayerFromId(source)
  if not player then return end

  MySQL.Async.fetchAll(
      "SELECT * FROM crew_membres WHERE id_grade = @id_grade",
      {["@id_grade"] = gradeId},
      function(membersWithGrade)
          if #membersWithGrade > 0 then
              player.showNotification(_U("cannot_delete_rank_in_use"))
              return
          end

          MySQL.Async.execute(
              "DELETE FROM crew_grades WHERE id_grade = @id_grade",
              {["@id_grade"] = gradeId},
              function(deleted)
                  if deleted > 0 then
                      player.showNotification(_U("rank_deleted_success"))
                  end
              end
          )
      end
  )
end)

RegisterServerEvent("UpdateRangPermissions")
AddEventHandler("UpdateRangPermissions", function(gradeId, gestionPerm, sellVehiclePerm)
  local player = ESX.GetPlayerFromId(source)
  if not player then return end

  local gestionValue = gestionPerm and 1 or 0
  local sellVehicleValue = sellVehiclePerm and 1 or 0

  MySQL.Async.execute(
      "UPDATE crew_grades SET gestion = @gestion, sell_vehicle = @sell_vehicle WHERE id_grade = @id_grade",
      {
          ["@gestion"] = gestionValue,
          ["@sell_vehicle"] = sellVehicleValue,
          ["@id_grade"] = gradeId
      },
      function(affectedRows)
          if affectedRows > 0 then
              player.showNotification(_U("permissions_updated_success"))
          end
      end
  )
end)

RegisterServerEvent("ChangeCrewName")
AddEventHandler("ChangeCrewName", function(newName)
  local player = ESX.GetPlayerFromId(source)
  if not player then return end

  MySQL.Async.fetchAll(
      "SELECT * FROM crew_membres WHERE identifier = @identifier",
      {["@identifier"] = player.identifier},
      function(memberResult)
          if not memberResult[1] then return end

          local crewId = memberResult[1].id_crew

          MySQL.Async.fetchAll(
              "SELECT * FROM crew_liste WHERE name = @name AND id_crew != @id_crew",
              {
                  ["@name"] = newName,
                  ["@id_crew"] = crewId
              },
              function(existingCrew)
                  if #existingCrew > 0 then
                      player.showNotification(_U("crew_name_already_exists"))
                      return
                  end

                  MySQL.Async.execute(
                      "UPDATE crew_liste SET name = @name WHERE id_crew = @id_crew",
                      {
                          ["@name"] = newName,
                          ["@id_crew"] = crewId
                      },
                      function(affectedRows)
                          if affectedRows > 0 then
                              player.showNotification(_U("crew_name_changed_success", newName))
                          end
                      end
                  )
              end
          )
      end
  )
end)

RegisterServerEvent("ChangeCrewDevise")
AddEventHandler("ChangeCrewDevise", function(newDevise)
  local player = ESX.GetPlayerFromId(source)
  if not player then return end

  MySQL.Async.fetchAll(
      "SELECT * FROM crew_membres WHERE identifier = @identifier",
      {["@identifier"] = player.identifier},
      function(memberResult)
          if not memberResult[1] then return end

          local crewId = memberResult[1].id_crew

          MySQL.Async.execute(
              "UPDATE crew_liste SET devise = @devise WHERE id_crew = @id_crew",
              {
                  ["@devise"] = newDevise,
                  ["@id_crew"] = crewId
              },
              function(affectedRows)
                  if affectedRows > 0 then
                      player.showNotification(_U("crew_motto_changed_success"))
                  end
              end
          )
      end
  )
end)

RegisterServerEvent("ChangeCrewColor")
AddEventHandler("ChangeCrewColor", function(newColorHex)
  local player = ESX.GetPlayerFromId(source)
  if not player then return end

  MySQL.Async.fetchAll(
      "SELECT * FROM crew_membres WHERE identifier = @identifier",
      {["@identifier"] = player.identifier},
      function(memberResult)
          if not memberResult[1] then return end

          local crewId = memberResult[1].id_crew

          MySQL.Async.execute(
              "UPDATE crew_liste SET color_hex = @color_hex WHERE id_crew = @id_crew",
              {
                  ["@color_hex"] = newColorHex,
                  ["@id_crew"] = crewId
              },
              function(affectedRows)
                  if affectedRows > 0 then
                      player.showNotification(_U("crew_color_changed_success"))
                  end
              end
          )
      end
  )
end)

RegisterServerEvent("DisbandCrew")
AddEventHandler("DisbandCrew", function()
  local player = ESX.GetPlayerFromId(source)
  if not player then return end

  MySQL.Async.fetchAll(
      "SELECT * FROM crew_membres WHERE identifier = @identifier",
      {["@identifier"] = player.identifier},
      function(memberResult)
          if not memberResult[1] then return end

          local crewId = memberResult[1].id_crew

          MySQL.Async.fetchAll(
              "SELECT name FROM crew_liste WHERE id_crew = @id_crew",
              {["@id_crew"] = crewId},
              function(crewData)
                  local crewName = (crewData[1] and crewData[1].name) or nil

                  MySQL.Async.fetchAll(
                      "SELECT identifier FROM crew_membres WHERE id_crew = @id_crew",
                      {["@id_crew"] = crewId},
                      function(allMembers)
                          MySQL.Async.execute(
                              "DELETE FROM crew_membres WHERE id_crew = @id_crew",
                              {["@id_crew"] = crewId},
                              function()
                                  MySQL.Async.execute(
                                      "DELETE FROM crew_grades WHERE id_crew = @id_crew",
                                      {["@id_crew"] = crewId},
                                      function()
                                          MySQL.Async.execute(
                                              "DELETE FROM crew_liste WHERE id_crew = @id_crew",
                                              {["@id_crew"] = crewId},
                                              function(deleted)
                                                  if deleted > 0 then
                                                      player.showNotification(_U("crew_disbanded_success"))

                                                      for _, memberData in ipairs(allMembers) do
                                                          local memberIdentifier = memberData.identifier
                                                          local memberSource = nil
                                                          local allPlayers = ESX.GetPlayers()

                                                          for _, playerId in ipairs(allPlayers) do
                                                              local p = ESX.GetPlayerFromId(playerId)
                                                              if p and p.identifier == memberIdentifier then
                                                                  memberSource = playerId
                                                                  break
                                                              end
                                                          end

                                                          TriggerEvent("nvTerritory:playerLeftCrew", memberSource, memberIdentifier, crewId, crewName)
                                                      end
                                                  end
                                              end
                                          )
                                      end
                                  )
                              end
                          )
                      end
                  )
              end
          )
      end
  )
end)