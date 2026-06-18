

local benchIdCounter = 0
local activeBenches = {}
local benchIdentifiers = {}
local benchMetadata = {}
PlayerProgression = PlayerProgression or {}
local frameworkType = string.lower(Config.Framework or "esx")
local inventoryType = string.lower(Config.Inventory or "ox_inventory")
local ESX = nil
local QBCore = nil
local DeveloperMode = Config.DeveloperMode
local craftingCooldowns = {}
local resourcePointLocks = {}

local function getPlayerObject(source)
  if frameworkType == "esx" then
    if not ESX then
      local ok, obj = pcall(function()
        return exports["es_extended"]:getSharedObject()
      end)
      if ok then ESX = obj end
    end
    return ESX and ESX.GetPlayerFromId(source) or nil
  elseif frameworkType == "qb" then
    if not QBCore then
      local ok, obj = pcall(function()
        return exports["qb-core"]:GetCoreObject()
      end)
      if ok then QBCore = obj end
    end
    return QBCore and QBCore.Functions.GetPlayer(source) or nil
  end
end

local function getCitizenId(player)
  if not player then
    return nil
  end

  if frameworkType == "esx" then
    if type(player.getUniqueID) == "function" then
      return tostring(player:getUniqueID())
    end

    return tostring(player.UniqueID or player.identifier)
  end

  local playerData = player.PlayerData or {}
  return playerData.citizenid
end

local function awaitPlayerObject(source, maxAttempts)
  local attempts = 0
  local limit = maxAttempts or 20
  local player = getPlayerObject(source)

  while not player and attempts < limit do
    Wait(250)
    attempts += 1
    player = getPlayerObject(source)
  end

  return player
end

local function getPlayerIdentity(player)
  if not player then
    return "John", "Doe"
  end

  if frameworkType == "esx" then
    local first = player.firstname or (player.variables and player.variables.firstName) or (player.get and player:get("firstName"))
    local last = player.lastname or (player.variables and player.variables.lastName) or (player.get and player:get("lastName"))
    return first or "Prénom", last or "Nom"
  end

  local charinfo = player.PlayerData and player.PlayerData.charinfo or {}
  return charinfo.firstname or "John", charinfo.lastname or "Doe"
end

local function addInventoryItem(source, item, amount, metadata)
  if inventoryType == "ox_inventory" or inventoryType == "ox-like" then
    return exports.ox_inventory:AddItem(source, item, amount, metadata)
  end

  local player = getPlayerObject(source)
  if not player then
    return false
  end

  if frameworkType == "esx" then
    player.addInventoryItem(item, amount, metadata)
    return true
  end

  return player.Functions.AddItem(item, amount, metadata)
end

local function removeInventoryItem(source, item, amount, metadata, slot)
  if inventoryType == "ox_inventory" or inventoryType == "ox-like" then
    return exports.ox_inventory:RemoveItem(source, item, amount, metadata, slot)
  end

  local player = getPlayerObject(source)
  if not player then
    return false
  end

  if frameworkType == "esx" then
    player.removeInventoryItem(item, amount, metadata, slot)
    return true
  end

  return player.Functions.RemoveItem(item, amount, slot, metadata)
end

local function hasInventoryItem(source, item, amount)
  amount = amount or 1

  if inventoryType == "ox_inventory" or inventoryType == "ox-like" then
    local count = exports.ox_inventory:GetItem(source, item, nil, true)
    return (count or 0) >= amount
  end

  local player = getPlayerObject(source)
  if not player then
    return false
  end

  if frameworkType == "esx" then
    local inventoryItem = player.getInventoryItem(item)
    return inventoryItem and inventoryItem.count >= amount
  end

  local qbItem = player.Functions.GetItemByName(item)
  return qbItem and qbItem.amount >= amount
end

local function getOxItemData(itemName)
  if not (inventoryType == "ox_inventory" or inventoryType == "ox-like") then
    return nil
  end

  local items = exports.ox_inventory:Items()
  return items and items[itemName] or nil
end

local function buildRequirementEntry(requirement)
  local reqItem = requirement.item

  if inventoryType == "ox_inventory" or inventoryType == "ox-like" then
    local oxItem = getOxItemData(reqItem)
    if oxItem then
      requirement.image = GetItemImageUrl(oxItem)
      requirement.label = oxItem.label
    else
      requirement.image = GetInventoryImagePath() .. (reqItem .. ".png")
      requirement.label = string.upper(reqItem)
      if DeveloperMode then
        print(("[nv_crafting] Warning: item '%s' not found in ox_inventory, using fallback data."):format(reqItem))
      end
    end
  else
    requirement.image = requirement.image or (GetInventoryImagePath() .. (reqItem .. ".png"))
    requirement.label = requirement.label or string.upper(reqItem)
  end
end

local function buildCraftableEntry(itemName, itemConfig, successOdds)
  if inventoryType == "ox_inventory" or inventoryType == "ox-like" then
    local itemKey = itemConfig.type == "weapon" and string.upper(itemName) or itemName
    local oxItem = getOxItemData(itemKey)

    if oxItem then
      return {
        itemName = itemName,
        type = itemConfig.type,
        itemLabel = string.upper(oxItem.label or itemName),
        itemLevel = itemConfig.itemLevel,
        itemDescription = oxItem.description or "",
        itemWeight = oxItem.weight or 0,
        itemImage = GetItemImageUrl(oxItem),
        successOdds = successOdds,
        requirements = itemConfig.requirements
      }
    else
      if DeveloperMode then
        print(("[nv_crafting] Warning: craft item '%s' missing in ox_inventory, using fallback data."):format(itemName))
      end

      return {
        itemName = itemName,
        type = itemConfig.type,
        itemLabel = string.upper(itemName),
        itemLevel = itemConfig.itemLevel,
        itemDescription = "",
        itemWeight = 0,
        itemImage = GetInventoryImagePath() .. (itemName .. ".png"),
        successOdds = successOdds,
        requirements = itemConfig.requirements
      }
    end
  else
    return {
      itemName = itemName,
      type = itemConfig.type,
      itemLabel = string.upper(itemName),
      itemLevel = itemConfig.itemLevel,
      itemDescription = "",
      itemWeight = 0,
      itemImage = GetInventoryImagePath() .. (itemName .. ".png"),
      successOdds = successOdds,
      requirements = itemConfig.requirements
    }
  end
end

local function registerUsableItem(itemName, handler)
  if frameworkType == "esx" then
    ESX.RegisterUsableItem(itemName, function(source, item, inventory, slot, data)
      handler(source, item or {}, inventory, slot, data)
    end)
  elseif frameworkType == "qb" then
    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
      handler(source, item or {})
    end)
  end
end

local function getPlayerGangJob(player)
  if not player then
    return nil
  end

  if frameworkType == "esx" then
    if player.job2 and player.job2.name then
      return player.job2.name
    end
    if player.job and player.job.name then
      return player.job.name
    end
    return nil
  end

  local playerData = player.PlayerData or {}
  local job2 = playerData.job2
  if job2 and job2.name then
    return job2.name
  end
  local job = playerData.job
  if job and job.name then
    return job.name
  end
  return nil
end

local function getGangCategory(jobName)
  if not jobName then
    return nil
  end

  local lowerName = string.lower(jobName)
  local result = MySQL.scalar.await("SELECT LOWER(cat) FROM gangs_new WHERE LOWER(name) = ? LIMIT 1", {lowerName})
  if type(result) == "string" and result ~= "" then
    return string.lower(result)
  end
  return nil
end

local function playerHasStationAccess(source, stationConfig)
  if not stationConfig then
    return false
  end

  local accessConfig = stationConfig.access
  if not accessConfig then
    return true
  end

  if accessConfig.gangCategories and #accessConfig.gangCategories > 0 then
    local player = getPlayerObject(source)
    if not player then
      return false
    end

    local gangJob = getPlayerGangJob(player)
    if not gangJob then
      return false
    end

    local gangCategory = getGangCategory(gangJob)
    if not gangCategory then
      return false
    end

    for _, allowedCategory in ipairs(accessConfig.gangCategories) do
      if string.lower(allowedCategory) == gangCategory then
        return true
      end
    end

    return false
  end

  return true
end

if frameworkType == "esx" then
  local ok, obj = pcall(function()
    return exports["es_extended"]:getSharedObject()
  end)
  if ok then
    ESX = obj
  end
elseif frameworkType == "qb" then
  local ok, obj = pcall(function()
    return exports["qb-core"]:GetCoreObject()
  end)
  if ok then
    QBCore = obj
  end
end

function InsertBenchIntoDatabase(benchData)
  local coords, propName, benchName, heading, identifier, metadata, active, routingBucket = 
    json.encode(benchData.coords),
    benchData.propName,
    benchData.benchName,
    benchData.heading,
    benchData.identifier,
    benchData.metadata and json.encode(benchData.metadata) or nil,
    true,
    benchData.routingBucket
  
  MySQL.query(
    "INSERT INTO crafting_benches (coords, propName, benchName, heading, identifier, metadata, active, routingBucket) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
    {coords, propName, benchName, heading, identifier, metadata, active, routingBucket}
  )
end

function StoreBenchInCache(benchData)
  if benchData then
    MySQL.query(
      "INSERT INTO benches_cache (identifier, benchName, metadata) VALUES (@identifier, @benchName, @metadata)",
      {
        ["@identifier"] = benchData.identifier,
        ["@benchName"] = benchData.benchName,
        ["@metadata"] = json.encode(benchData.metadata)
      }
    )
    print("Stored bench in cache for identifier:", benchData.identifier)
  end
end

function LoadActiveBenches()
  local results = MySQL.query.await("SELECT * FROM crafting_benches WHERE active = true", {})
  if results and next(results) then
    return true, results
  end
  return false
end

function RemoveBenchFromCache(identifier, benchName)
  local affectedRows = MySQL.update.await(
    "DELETE FROM benches_cache WHERE identifier = @identifier AND benchName = @benchName",
    {["@identifier"] = identifier, ["@benchName"] = benchName}
  )
  
  if affectedRows > 0 then
    print("Bench removed from database:", benchName)
    return true
  end
  
  print("No matching bench found to delete.")
  return false
end

function GetPlayerBenchCache(identifier)
  local results = MySQL.query.await(
    "SELECT * FROM benches_cache WHERE identifier = @identifier",
    {["@identifier"] = identifier}
  )
  
  if results and next(results) then
    return true, results
  end
  return false
end

function GetPlayerCraftingData(identifier)
  local results = MySQL.query.await(
    "SELECT level, xp, blueprints FROM crafting_players WHERE identifier = @identifier",
    {["@identifier"] = identifier}
  )
  
  if results and next(results) then
    return true, results
  end
  return false
end

function CreatePlayerCraftingEntry(identifier, level, xp)
  MySQL.insert.await(
    "INSERT INTO crafting_players (identifier, level, xp) VALUES (@identifier, @level, @xp)",
    {["@identifier"] = identifier, ["@level"] = level, ["@xp"] = xp}
  )
end

function UpdatePlayerCraftingData(identifier, level, xp)
  MySQL.update.await(
    "UPDATE crafting_players SET level = @level, xp = @xp WHERE identifier = @identifier",
    {["@identifier"] = identifier, ["@level"] = level, ["@xp"] = xp}
  )
end

function CalculateSuccessOdds(playerLevel, itemLevel, baseOdds, maxOdds)
  local levelGap = 5
  local minOdds = 1
  
  if itemLevel == nil then
    itemLevel = 1
  end
  
  if itemLevel > playerLevel then
    return math.max(minOdds, baseOdds - ((itemLevel - playerLevel) * 5))
  end
  
  local levelDifference = playerLevel - itemLevel
  local oddsIncrease = (levelDifference / levelGap) * (maxOdds - baseOdds)
  local finalOdds = baseOdds + oddsIncrease
  
  return math.min(finalOdds, maxOdds)
end

function CalculateXPRequired(level, xpMultiplier)
  return (level ^ 2) * xpMultiplier
end

function GetInventoryImagePath()
  if Config.CustomImageURL then
    return Config.CustomImageURL
  end
  
  local inventory = Config.Inventory
  
  if inventory == "ox_inventory" then
    return "https://cfx-nui-ox_inventory/web/images/"
  elseif inventory == "ox-like" and Config.CustomInventory then
    return "https://cfx-nui-" .. Config.CustomInventory .. "/web/images/"
  elseif inventory == "lj-inventory" then
    return "https://cfx-nui-lj-inventory/html/images/"
  elseif inventory == "ps-inventory" then
    return "https://cfx-nui-ps-inventory/html/images/"
  elseif inventory == "qb-inventory" then
    return "https://cfx-nui-qb-inventory/html/images/"
  elseif inventory == "qb-like" and Config.CustomInventory then
    return "https://cfx-nui-" .. Config.CustomInventory .. "/html/images/"
  elseif inventory == "qs-inventory" then
    return "https://cfx-nui-qs-inventory/html/images/"
  end

  return ""
end

function GetItemImageUrl(itemData)
  local imagePath = GetInventoryImagePath()
  if itemData and itemData.client and itemData.client.image then
    local image = tostring(itemData.client.image)
    if image ~= "" then
      if image:match("^https?://") or image:match("^nui://") then
        return image
      end

      if imagePath ~= "" then
        if image:sub(1, 1) == "/" then
          image = image:sub(2)
        end
        return imagePath .. image
      end

      return image
    end
  end

  local fallbackName = itemData and itemData.name or "unknown"
  return imagePath .. fallbackName .. ".png"
end

function IsItemInList(itemName, itemList)
  for _, item in ipairs(itemList) do
    if item == itemName then
      return true
    end
  end
  return false
end

function IsNonBlueprintItem(itemName, benchName)
  local benchConfig = Config.Benches.benchTypes[benchName]
  if not benchConfig then
    return false
  end
  
  for item, _ in pairs(benchConfig.nonBlueprintItems) do
    if item == itemName then
      return true
    end
  end
  
  return false
end

function CreateBlueprint(targetId, blueprintItem, amount)
  if not (targetId and blueprintItem and amount) then
    print("[nv-crafting] ERROR - Missing parameters for CreateBlueprint.")
    return false
  end
  
  local blueprintConfig = Config.Blueprints.items[blueprintItem]
  if not blueprintConfig then
    print("[nv-crafting] ERROR - Blueprint does not exist: " .. blueprintItem)
    return false
  end
  
  local targetPlayer = getPlayerObject(targetId)
  if not targetPlayer then
    print("[nv-crafting] ERROR - Target player not found.")
    return false
  end
  
  local metadata = {
    blueprintContent = blueprintItem,
    label = "Blueprint for '" .. blueprintItem .. "'"
  }
  
  addInventoryItem(targetId, "blueprint", amount, metadata or nil)
  
  return true
end

exports("CreateBlueprint", CreateBlueprint)

RegisterCommand("createblueprint", function(source, args, rawCommand)
  if not DeveloperMode then
    print("[nv-crafting] WARNING - Developer Mode is not enabled. This command is disabled.")
    return
  end
  
  local adminSource = source
  local targetId = tonumber(args[1])
  local blueprintItem = tostring(args[2])
  local amount = tonumber(args[3]) or 1
  
  if not (targetId and blueprintItem and amount) then
    print("[nv-crafting] ERROR - Missing arguments for /createblueprint.")
    return
  end
  
  local success = CreateBlueprint(targetId, blueprintItem, amount)
  
  if success then
    TriggerClientEvent("chat:addMessage", adminSource, {
      args = {
        "[nv-crafting]",
        string.format("Gave %d 'blueprint' items to Player %d with content: %s", amount, targetId, blueprintItem)
      }
    })
  else
    TriggerClientEvent("chat:addMessage", adminSource, {
      args = {
        "[nv-crafting]",
        "Failed to create blueprint. Check server logs for details."
      }
    })
  end
end, true)

function GetPlayerLevelAndXP(source)
  local player = getPlayerObject(source)
  if not player then
    return
  end

  local citizenId = getCitizenId(player)
  if not citizenId or not PlayerProgression[citizenId] then
    return
  end

  local playerLevel = PlayerProgression[citizenId].level
  local playerXP = PlayerProgression[citizenId].xp
  
  return playerLevel, playerXP
end

exports("getPlayerLevel", GetPlayerLevelAndXP)

function GetItemData(isStation, stationOrBenchId, itemName, isNonBlueprint)
  if isStation then
    local stationConfig = Config.Stations[stationOrBenchId]
    if stationConfig and stationConfig.items then
      return stationConfig.items[itemName]
    end
  else
    local benchConfig = Config.Benches.benchTypes[stationOrBenchId]
    if not benchConfig then
      return nil
    end
    
    if isNonBlueprint then
      if benchConfig.nonBlueprintItems then
        local item = benchConfig.nonBlueprintItems[itemName]
        if item then
          return item
        end
      end
    else
      local blueprintItem = Config.Blueprints.items[itemName]
      if blueprintItem and blueprintItem.benchId == stationOrBenchId then
        return blueprintItem
      end
    end
  end
  
  return nil
end

exports("getItemData", GetItemData)

MySQL.query([[
    CREATE TABLE IF NOT EXISTS crafting_players (
        identifier VARCHAR(50) PRIMARY KEY,
        level INT NOT NULL DEFAULT 1,
        xp INT NOT NULL DEFAULT 0,
        blueprints JSON DEFAULT NULL
    )
]], function(result)
  print("Crafting Player Data table created or already exists.")
end)

MySQL.query([[
  
    CREATE TABLE IF NOT EXISTS crafting_benches (  
        id INT AUTO_INCREMENT PRIMARY KEY,  
        coords JSON NOT NULL,  
        propName VARCHAR(255) NOT NULL,  
        benchName VARCHAR(255) NOT NULL,  
        heading FLOAT NOT NULL,  
        identifier VARCHAR(50) NOT NULL,  
        metadata JSON DEFAULT NULL,  
        active BOOLEAN NOT NULL DEFAULT TRUE,
        routingBucket MEDIUMINT DEFAULT 0
    )  
]], function(result)
  print("Crafting benches table created or already exists.")
end)

MySQL.query([[
    CREATE TABLE IF NOT EXISTS benches_cache (
        id INT AUTO_INCREMENT PRIMARY KEY,
        identifier VARCHAR(50) NOT NULL,
        benchName VARCHAR(255) NOT NULL,
        metadata JSON DEFAULT NULL
    )
]], function(result)
  print("Benches cache table created or already exists.")
end)

function UpdatePlayerXP(citizenId, xpGain, craftSuccess, craftAmount)
  local levelConfig = Config.LevelValues
  local xpToAdd = xpGain * levelConfig.xpGainMultiplier * craftAmount
  
  if craftSuccess == false then
    xpToAdd = xpToAdd * levelConfig.loseMultiplier
  end
  
  local playerProgress = PlayerProgression[citizenId] or {level = 1, xp = 0}
  local currentLevel = playerProgress.level
  local currentXP = playerProgress.xp + xpToAdd
  local xpRequired = CalculateXPRequired(currentLevel, levelConfig.levelUpXPMultiplier)
  
  if currentXP >= xpRequired then
    currentLevel = currentLevel + 1
    currentXP = currentXP - xpRequired
  end
  
  PlayerProgression[citizenId] = {level = currentLevel, xp = currentXP}
  UpdatePlayerCraftingData(citizenId, currentLevel, currentXP)
  
  return currentLevel, currentXP
end

RegisterNetEvent("nv-crafting:server:gainXP")
AddEventHandler("nv-crafting:server:gainXP", function(source, xpGain, craftSuccess, craftAmount)
  local player = getPlayerObject(source)
  if not player then
    return
  end
  
  local citizenId = getCitizenId(player)
  if not citizenId then
    return
  end

  local newLevel, newXP = UpdatePlayerXP(citizenId, xpGain, craftSuccess, craftAmount)
  TriggerClientEvent("nv-crafting:client:updateXP", source, newLevel, newXP)
end)

function StoreNewBench(pointData, shouldSave)
  if not pointData then
    if DeveloperMode then
      print("Invalid pointdata:", json.encode(pointData, {indent = true}))
    end
    return nil
  end
  
  local identifier = pointData.identifier
  if benchIdentifiers[identifier] then
    if DeveloperMode then
      print("Already found a spawned bench with this identifier:", pointData.identifier)
    end
    return nil
  end
  
  benchIdCounter = benchIdCounter + 1
  local benchId = benchIdCounter
  
  local benchData = {
    coords = pointData.coords,
    distance = Config.Benches.HideBenchDistance or 50,
    benchId = benchId,
    propName = pointData.propName,
    benchName = pointData.benchName,
    prop = nil,
    heading = pointData.heading,
    identifier = pointData.identifier,
    metadata = pointData.metadata or nil,
    routingBucket = pointData.routingBucket or Config.MainRoutingBucket
  }
  
  benchIdentifiers[identifier] = benchId
  activeBenches[benchId] = benchData
  
  TriggerClientEvent("AddPoint", -1, benchData, benchId)
  
  if shouldSave then
    if Config.Benches.enablePersistentBenches then
      InsertBenchIntoDatabase(benchData)
    else
      StoreBenchInCache(benchData)
    end
  end
  
  return benchId
end

lib.callback.register("nv-crafting:server:storePoint", StoreNewBench)

function LoadBenchesFromDatabase(benchList, shouldSave)
  for _, benchData in ipairs(benchList) do
    if benchData and benchData.prop == nil then
      local identifier = benchData.identifier
      if benchIdentifiers[identifier] then
        return
      end
      
      benchIdCounter = benchIdCounter + 1
      local benchId = benchIdCounter
      
      local loadedBench = {
        coords = json.decode(benchData.coords),
        distance = Config.Benches.HideBenchDistance or 50,
        propName = benchData.propName,
        benchName = benchData.benchName,
        prop = nil,
        heading = benchData.heading,
        identifier = benchData.identifier,
        metadata = json.decode(benchData.metadata),
        routingBucket = benchData.routingBucket or Config.MainRoutingBucket
      }
      
      benchIdentifiers[identifier] = benchId
      activeBenches[benchId] = loadedBench
      
      if shouldSave and Config.Benches.enablePersistentBenches then
        InsertBenchIntoDatabase(loadedBench)
      end
    end
  end
end

RegisterNetEvent("nv-crafting:server:deletePoint")
AddEventHandler("nv-crafting:server:deletePoint", function(benchId)
  local benchData = activeBenches[benchId]
  if not benchData then
    if DeveloperMode then
      print(benchId .. "was not found on the server side bench points.")
    end
    return
  end
  
  local benchName = benchData.benchName
  local identifier = benchData.identifier
  
  if benchIdentifiers[identifier] then
    benchIdentifiers[identifier] = nil
  end
  
  activeBenches[benchId] = nil
  TriggerClientEvent("DeletePoint", -1, benchId)
  
  if Config.Benches.enablePersistentBenches then
    MySQL.update(
      "UPDATE crafting_benches SET active = false WHERE benchName = ? AND identifier = ? AND active = true",
      {benchName, identifier},
      function(affectedRows)
        if affectedRows > 0 then
          if DeveloperMode then
            print("Bench " .. benchName .. "_" .. tostring(identifier) .. " has been deactivated in the database.")
          end
        else
          if DeveloperMode then
            print("No matching bench found for deactivation.")
          end
        end
      end
    )
  else
    MySQL.update(
      "DELETE FROM benches_cache WHERE identifier = ? AND benchName = ?",
      {identifier, benchName},
      function(affectedRows)
        if affectedRows > 0 then
          if DeveloperMode then
            print("Bench " .. benchName .. "_" .. tostring(identifier) .. " removed from benches_cache.")
          end
        else
          if DeveloperMode then
            print("Bench " .. benchName .. "_" .. tostring(identifier) .. " not found in benches_cache.")
          end
        end
      end
    )
  end
end)

lib.callback.register("nv-crafting:server:updateBlueprints", function(source, metadata, identifier, benchName)
  local affectedRows = 0
  local blueprintStore = Config.Blueprints.store
  
  if blueprintStore == "bench" then
    if Config.Benches.enablePersistentBenches then
      affectedRows = MySQL.update.await(
        "UPDATE crafting_benches SET metadata = ? WHERE identifier = ? AND benchName = ? AND active = true",
        {json.encode(metadata), identifier, benchName},
        function(rows)
          if rows > 0 then
            if DeveloperMode then
              print("Updated metadata for bench " .. benchName .. " in crafting_benches.")
            end
          else
            if DeveloperMode then
              print("No matching bench found in crafting_benches to update metadata.")
            end
          end
        end
      )
    else
      affectedRows = MySQL.update.await(
        "UPDATE benches_cache SET metadata = ? WHERE identifier = ? AND benchName = ?",
        {json.encode(metadata), identifier, benchName},
        function(rows)
          if rows > 0 then
            if DeveloperMode then
              print("Updated metadata for bench " .. benchName .. " in benches_cache.")
            end
          else
            if DeveloperMode then
              print("No matching bench found in benches_cache to update metadata.")
            end
          end
        end
      )
    end
  else
    if metadata.blueprints and identifier then
      affectedRows = MySQL.update.await(
        "UPDATE crafting_players SET blueprints = ? WHERE identifier = ?",
        {json.encode(metadata.blueprints), identifier},
        function(rows)
          if rows > 0 then
            if DeveloperMode then
              print("Updated metadata for player " .. identifier .. " in crafting_benches.")
            end
          else
            if DeveloperMode then
              print("No matching player found in crafting player data to update blueprints.")
            end
          end
        end
      )
    end
  end
  
  return affectedRows and affectedRows > 0 or false
end)

function LoadPersistentBenches()
  local success, benchList = LoadActiveBenches()
  if success and benchList and next(benchList) then
    activeBenches = benchList
    LoadBenchesFromDatabase(activeBenches, false)
    return true
  end
  return false
end

function InitializePlayerData(source)
  local player = awaitPlayerObject(source)
  
  if not player then
    print("Failed to get player data in PlayerLoaded")
    return false
  end
  
  local citizenId = getCitizenId(player)
  if not citizenId then
    return false
  end
  
  local hasCachedBenches, cachedBenches = GetPlayerBenchCache(citizenId)
  if hasCachedBenches and cachedBenches and next(cachedBenches) then
    for _, benchCache in ipairs(cachedBenches) do
      local benchName = benchCache.benchName
      local metadata = benchCache.metadata and json.decode(benchCache.metadata) or nil
      
      if string.find(benchName, "_bench") then
        local removeSuccess = RemoveBenchFromCache(citizenId, benchName)
        if removeSuccess then
          addInventoryItem(source, benchName, 1, metadata)
        else
          print("Failed to give bench from bench cache.")
        end
      else
        if DeveloperMode then
          print("The benchName does not contain '_bench'")
        end
      end
    end
  end
  
  PlayerProgression[citizenId] = PlayerProgression[citizenId] or {}
  
  local hasData, craftingData = GetPlayerCraftingData(citizenId)
  
  if hasData and craftingData and next(craftingData) and craftingData[1] then
    PlayerProgression[citizenId].level = craftingData[1].level
    PlayerProgression[citizenId].xp = craftingData[1].xp
    
    local blueprints = craftingData[1].blueprints and json.decode(craftingData[1].blueprints) or {}
    return true, activeBenches, blueprints, citizenId
  else
    PlayerProgression[citizenId].level = 1
    PlayerProgression[citizenId].xp = 0
    
    local createSuccess = CreatePlayerCraftingEntry(citizenId, 1, 0)
    if createSuccess and DeveloperMode then
      print("New player entry for crafting_players successful")
    end
    
    return true, activeBenches, {}, citizenId
  end
end

AddEventHandler("esx:playerLoaded", function(playerId, xPlayer, isNew)
  TriggerClientEvent("nv-crafting:client:playerLoaded", playerId)
end)

lib.callback.register("nv-crafting:server:playerLoaded", function(source)
  return InitializePlayerData(source)
end)

function SavePlayerProgressionOnDisconnect(playerId)
  local player = awaitPlayerObject(playerId, 10)
  
  if player then
    local citizenId = getCitizenId(player)
    if not citizenId then
      return false
    end

    local progression = PlayerProgression[citizenId] or {level = 1, xp = 0}
    
    MySQL.query(
      "UPDATE crafting_players SET level = @level, xp = @xp WHERE identifier = @identifier",
      {
        ["@level"] = progression.level,
        ["@xp"] = progression.xp,
        ["@identifier"] = citizenId
      },
      function(result)
        if result then
          print("Player " .. citizenId .. " data saved successfully.")
        else
          print("Error saving player " .. citizenId .. " data on disconnect.")
        end
      end
    )
    return true
  end

  print("Error saving player " .. tostring(playerId) .. " data on disconnect. (SOURCE ID)")
  return false
end

lib.callback.register("nv-crafting:server:playerDropped", function(source)
  return SavePlayerProgressionOnDisconnect(source)
end)

AddEventHandler("esx:playerDropped", function(playerId)
  SavePlayerProgressionOnDisconnect(playerId)
end)

AddEventHandler("esx:playerLogout", function(playerId)
  SavePlayerProgressionOnDisconnect(playerId)
end)

function PrepareStationData(source, stationId)
  local player = getPlayerObject(source)
  if not player then
    print("[nv-crafting] ERROR - Player not found.")
    return false
  end
  
  local citizenId = getCitizenId(player)
  local progression = PlayerProgression[citizenId]
  
  if not progression then
    print("[nv-crafting] ERROR - Could not fetch user Level/XP.")
    return false
  end
  
  local firstName, lastName = getPlayerIdentity(player)
  local playerLevel = progression.level
  local playerXP = progression.xp
  
  local stationConfig = Config.Stations[stationId]
  if not stationConfig then
    print("[nv-crafting] ERROR - Invalid station: " .. tostring(stationId))
    return false
  end

  if not playerHasStationAccess(source, stationConfig) then
    return false, "no_access"
  end
  
  local stationInfo = {
    stationId = stationId,
    primaryTitle = stationConfig.title,
    secondaryTitle = stationConfig.secondaryTitle
  }
  
  local craftableItems = {}
  
  for itemName, itemConfig in pairs(stationConfig.items) do
    local successOdds = CalculateSuccessOdds(
      playerLevel,
      itemConfig.itemLevel,
      itemConfig.baseOdds,
      itemConfig.maxOdds
    )
    
    for _, requirement in pairs(itemConfig.requirements or {}) do
      buildRequirementEntry(requirement)
    end
    
    local craftableEntry = buildCraftableEntry(itemName, itemConfig, successOdds)
    table.insert(craftableItems, craftableEntry)
  end
  
  local responseData = {
    items = craftableItems,
    stationInfo = stationInfo,
    playerFirstName = firstName,
    playerLastName = lastName,
    playerLevel = playerLevel,
    playerXP = playerXP
  }
  
  return true, responseData
end

function PrepareBenchData(source, benchId, playerBlueprints)
  local player = getPlayerObject(source)
  if not player then
    print("[nv-crafting] ERROR - Player not found.")
    return false
  end
  
  local blueprintConfig = Config.Blueprints
  local citizenId = getCitizenId(player)
  local progression = PlayerProgression[citizenId]
  
  if not progression then
    print("[nv-crafting] ERROR - Could not fetch user Level/XP.")
    return false
  end
  
  local firstName, lastName = getPlayerIdentity(player)
  local playerLevel = progression.level
  local playerXP = progression.xp
  
  local benchConfig = Config.Benches.benchTypes[benchId] or nil
  
  if not benchConfig then
    print("[nv-crafting] ERROR - Invalid bench: " .. tostring(benchConfig))
    return false
  end
  
  local stationInfo = {
    stationId = benchId,
    primaryTitle = benchConfig.title,
    secondaryTitle = benchConfig.secondaryTitle
  }
  
  local craftableItems = {}
  
  function ProcessItem(itemName, itemConfig)
    local isNonBlueprint = IsNonBlueprintItem(itemName, benchId)
    
    if not isNonBlueprint then
      if playerBlueprints and IsItemInList(itemName, playerBlueprints) then
        if itemConfig.bench == benchId then
        else
          return
        end
      else
        return
      end
    end
    
    local successOdds = CalculateSuccessOdds(
      playerLevel,
      itemConfig.itemLevel,
      itemConfig.baseOdds,
      itemConfig.maxOdds
    )
    
    for _, requirement in pairs(itemConfig.requirements or {}) do
      buildRequirementEntry(requirement)
    end
    
    local craftEntry = buildCraftableEntry(itemName, itemConfig, successOdds)
    table.insert(craftableItems, craftEntry)
  end
  
  for itemName, itemConfig in pairs(benchConfig.nonBlueprintItems or {}) do
    ProcessItem(itemName, itemConfig)
  end
  
  if playerBlueprints then
    for itemName, itemConfig in pairs(blueprintConfig.items or {}) do
      if IsItemInList(itemName, playerBlueprints) and itemConfig.bench == benchId then
        ProcessItem(itemName, itemConfig)
      end
    end
  end
  
  local responseData = {
    items = craftableItems,
    stationInfo = stationInfo,
    playerFirstName = firstName,
    playerLastName = lastName,
    playerLevel = playerLevel,
    playerXP = playerXP
  }
  
  return true, responseData
end

lib.callback.register("nv-crafting:server:getCraftingReqs", function(source, stationOrBenchId, craftingType, playerBlueprints)
  local playerId = source
  local success, data
  
  if craftingType == "bench" then
    success, data = PrepareBenchData(playerId, stationOrBenchId, playerBlueprints)
  else
    success, data = PrepareStationData(playerId, stationOrBenchId)
  end
  
  return success, data
end)

function CheckPlayerInventory(source, requirements, craftAmount)
  local playerId = source
  local itemStatuses = {}
  local allRequirementsMet = true
  
  for _, requirement in ipairs(requirements) do
    local itemName = requirement.item
    local requiredAmount = requirement.amount * craftAmount
    
    local hasEnough = hasInventoryItem(playerId, itemName, requiredAmount)
    
    table.insert(itemStatuses, {
      item = itemName,
      amount = requiredAmount,
      hasEnough = hasEnough
    })
    
    if not hasEnough then
      allRequirementsMet = false
    end
  end
  
  TriggerClientEvent("returnItemRequirements", playerId, itemStatuses, allRequirementsMet)
end

RegisterServerEvent("nv-crafting:server:checkItemRequirements")
AddEventHandler("nv-crafting:server:checkItemRequirements", function(requirements, craftAmount)
  CheckPlayerInventory(source, requirements, craftAmount)
end)

RegisterServerEvent("nv-crafting:server:checkCanCraft")
AddEventHandler("nv-crafting:server:checkCanCraft", function(itemList)
  local playerId = source
  local craftableItems = {}
  
  for _, itemData in ipairs(itemList) do
    local requirements = itemData.requirements
    local canCraft = true
    
    for _, requirement in ipairs(requirements) do
      local itemName = requirement.item
      local requiredAmount = requirement.amount
      
      local hasItem = hasInventoryItem(playerId, itemName, requiredAmount)
      
      if not hasItem then
        canCraft = false
        break
      end
    end
    
    if canCraft then
      table.insert(craftableItems, itemData)
    end
  end
  
  TriggerClientEvent("returnCanCraft", playerId, craftableItems)
end)

function ValidateCraft(source, stationOrBenchId, itemName, craftAmount, craftSuccess, craftingType)
  local playerId = source
  local currentTime = os.time()
  
  local lastCraftTime = craftingCooldowns[playerId]
  if lastCraftTime then
    local timeSinceLastCraft = currentTime - lastCraftTime
    if timeSinceLastCraft < 2 then
      DropPlayer(playerId, "Crafting spam detected")
      return nil
    end
  end
  
  craftingCooldowns[playerId] = currentTime
  
  if not (stationOrBenchId and itemName and craftAmount > 0) then
    return nil
  end
  
  local craftingConfig
  local isBench = false
  
  if craftingType == "bench" then
    craftingConfig = Config.Benches.benchTypes[stationOrBenchId]
    isBench = true
  else
    craftingConfig = Config.Stations[stationOrBenchId]
  end
  
  if not craftingConfig then
    return nil
  end

  if not isBench and not playerHasStationAccess(playerId, craftingConfig) then
    return nil
  end
  
  local itemConfig
  if isBench then
    itemConfig = craftingConfig.nonBlueprintItems[string.lower(itemName)] or Config.Blueprints.items[string.lower(itemName)]
  else
    itemConfig = craftingConfig.items[string.lower(itemName)]
  end
  
  local amountPerCraft = itemConfig.amountToCraft or 1
  local totalAmount = amountPerCraft * craftAmount
  
  if not itemConfig then
    return nil
  end
  
  local requirements = itemConfig.requirements or {}
  
  for _, requirement in ipairs(requirements) do
    local hasItem = hasInventoryItem(playerId, requirement.item, requirement.amount * craftAmount)
    
    if not hasItem then
      return nil
    end
  end
  
  for _, requirement in ipairs(requirements) do
    removeInventoryItem(playerId, requirement.item, requirement.amount * craftAmount)
  end
  
  if craftSuccess then
    addInventoryItem(playerId, itemName, totalAmount)
    
    local itemLevel = itemConfig.itemLevel
    TriggerEvent("nv-crafting:server:gainXP", playerId, itemLevel, craftSuccess, craftAmount)
  end
  
  CheckPlayerInventory(playerId, requirements, craftAmount)
  
  return craftSuccess
end

lib.callback.register("nv-crafting:server:validateCraft", ValidateCraft)

lib.callback.register("nv-crafting:server:removeItem", function(source, itemData)
  return removeInventoryItem(source, itemData.name, itemData.amount, itemData.metadata, itemData.slot)
end)

RegisterNetEvent("nv-crafting:server:addBench")
AddEventHandler("nv-crafting:server:addBench", function(benchData)
  addInventoryItem(source, benchData.name, benchData.amount, benchData.metadata or nil)
end)

lib.callback.register("nv-crafting:server:getPlyRB", function(source)
  return GetPlayerRoutingBucket(source)
end)

lib.callback.register("nv-crafting:server:collectResource", function(source, resourceId)
  local resourceConfig = Config.ResourcePoints
  if not (resourceConfig and resourceConfig.enabled) then
    return {success = false, reason = "disabled"}
  end

  local pointConfig = resourceConfig.points and resourceConfig.points[resourceId]
  if not (pointConfig and pointConfig.item) then
    return {success = false, reason = "invalid_point"}
  end

  local exclusiveEnabled = pointConfig.exclusive
  if exclusiveEnabled == nil then
    exclusiveEnabled = resourceConfig.exclusive
  end

  local exclusiveCooldown = pointConfig.exclusiveCooldown or resourceConfig.exclusiveCooldown or 0
  local currentTime = GetGameTimer()

  if exclusiveEnabled and exclusiveCooldown > 0 then
    local lock = resourcePointLocks[resourceId]
    if lock and lock > currentTime then
      local remaining = math.max(0, math.floor((lock - currentTime) / 1000))
      return {success = false, reason = "busy", remaining = remaining}
    end

    resourcePointLocks[resourceId] = currentTime + (exclusiveCooldown * 1000)
  end

  local rewardConfig = pointConfig.reward or resourceConfig.defaultReward or {min = 1, max = 1}
  local minReward = math.floor(rewardConfig.min or rewardConfig.max or 1)
  local maxReward = math.floor(rewardConfig.max or rewardConfig.min or 1)

  if maxReward < minReward then
    maxReward = minReward
  end

  local amount = math.random(minReward, maxReward)
  if amount <= 0 then
    amount = 1
  end

  local added = addInventoryItem(source, pointConfig.item, amount, pointConfig.metadata or nil)
  if not added then
    if exclusiveEnabled then
      resourcePointLocks[resourceId] = currentTime
    end
    return {success = false, reason = "inventory_full"}
  end

  return {
    success = true,
    amount = amount,
    item = pointConfig.item,
    label = pointConfig.label or string.upper(pointConfig.item)
  }
end)

if Config.Benches.enableBenches then
  for benchName, benchConfig in pairs(Config.Benches.benchTypes) do
    registerUsableItem(benchName, function(source, itemData)
      local metadata = itemData and (itemData.info or itemData.metadata) or nil
      
      TriggerClientEvent(
        "nv-crafting:client:previewProp",
        source,
        benchName,
        benchConfig.benchProp,
        metadata,
        itemData and itemData.slot or nil
      )
    end)
  end
  
  for blueprintItem, blueprintConfig in pairs(Config.CustomBlueprints) do
    local customBlueprintName = blueprintConfig.customBlueprintName
    
    registerUsableItem(customBlueprintName, function(source, itemData)
      local metadata = {
        blueprintContent = blueprintItem,
        label = "Blueprint for '" .. blueprintItem .. "'"
      }
      
      TriggerClientEvent(
        "nv-crafting:client:checkNearbyBenches",
        source,
        customBlueprintName,
        metadata,
        itemData and itemData.slot or nil
      )
    end)
  end
  
  registerUsableItem("blueprint", function(source, itemData)
    local metadata = itemData and (itemData.info or itemData.metadata) or {}
    local blueprintContent = metadata.blueprintContent
    
    if blueprintContent then
      TriggerClientEvent(
        "nv-crafting:client:checkNearbyBenches",
        source,
        "blueprint",
        metadata,
        itemData and itemData.slot or nil
      )
    else
      print("[nv-crafting] INSUFFICIENT BLUEPRINT METADATA")
    end
  end)
else
  print("[nv-crafting] BENCHES ARE NOT ENABLED IN CONFIG!")
end

AddEventHandler("onServerResourceStart", function(resourceName)
  if resourceName ~= GetCurrentResourceName() then
    return
  end
  
  if frameworkType == "qb" then
    if inventoryType ~= "ox_inventory" and inventoryType ~= "ox-like" then
      QBCore = exports["qb-core"]:GetCoreObject()
    end
  end
  
  if Config.Benches.enablePersistentBenches then
    local loadSuccess = LoadPersistentBenches()
    if not loadSuccess then
      print("Could not load persistent benches.")
    end
  end
end)