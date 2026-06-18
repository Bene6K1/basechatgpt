local DeveloperMode = Config.DeveloperMode
local lastBlueprintUseTime = 0
local blueprintCooldown = 5000
local playerDataLoaded = false
local benchOwnedByPlayer = {}
local benchBlueprints = {}
local playerBlueprints = {}
local benchPoints = {}
local stationPoints = {}
local resourcePoints = {}
local placementZones = {}
local playerCitizenId = nil
local isBlacklistMode = Config.Benches.benchPlacement.mode == "blacklist"
local insidePlacementZone = false
local previewProp = nil
local previewBenchId = nil
local isGatheringResource = false
local targetResource = Config.Target or "nv_interact"
local inventoryType = string.lower(Config.Inventory or "ox_inventory")
local frameworkType = string.lower(Config.Framework or "esx")
local ESX = nil
local QBCore = nil

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

local function targetAvailable()
  return targetResource and GetResourceState(targetResource) == "started"
end

local function addInteractionPoint(data)
  if not targetAvailable() then
    return nil
  end

  return exports[targetResource]:addInteractionPoint({
    coords = data.coords,
    dist = data.dist or 2.0,
    key = data.key or 'E',
    message = data.message or "Interagir",
    icon = data.icon or 'fa-hammer',
    onPress = data.onPress
  })
end

local function removeInteractionPoint(id)
  if not (id and targetAvailable()) then
    return
  end

  exports[targetResource]:removeInteractionPoint(id)
end

local function playerHasItem(itemName, amount)
  amount = amount or 1

  if (inventoryType == "ox_inventory" or inventoryType == "ox-like") and GetResourceState("ox_inventory") == "started" then
    local count = exports.ox_inventory:Search("count", itemName)
    return (count or 0) >= amount
  end

  return true
end

local function handleProgress(progressConfig, onFinish, onCancel)
  local disableControls = progressConfig.disableControls and {
    move = true,
    combat = true,
    car = true,
    mouse = true
  } or nil

  local anim = nil
  if progressConfig.animDict and progressConfig.anim then
    anim = {
      dict = progressConfig.animDict,
      clip = progressConfig.anim,
      flag = progressConfig.flag
    }
  end

  local success = lib.progressCircle({
    duration = progressConfig.duration or 1000,
    label = progressConfig.label or "",
    position = "bottom",
    canCancel = progressConfig.canCancel ~= false,
    disable = disableControls,
    anim = anim
  })

  if success then
    if onFinish then
      onFinish()
    end
  else
    if onCancel then
      onCancel()
    end
  end
end

local function notify(message)
  TriggerEvent('esx:showNotification', message)
end

local text = {
  station_access_denied = "Toi et ton groupe n’avez rien à faire ici. Quittez les lieux immédiatement.",
  no_more_benches = "Vous avez déjà placé un établi.",
  bench_blacklist = "Vous essayez de placer un établi dans une zone interdite.",
  bench_whitelist = "Vous essayez de placer un établi hors zone autorisée.",
  putting_down = "Installation de l'établi",
  moving = "Rangement de l'établi",
  bench_placed = "Établi placé avec succès.",
  bench_cancelled = "Placement annulé.",
  bench_too_far = "Vous êtes trop loin.",
  move_bench = "Ranger l'établi",
  craft_on_bench = "Utiliser l'établi",
  not_owner = "Vous n'êtes pas le propriétaire.",
  move_cancelled = "Déplacement annulé.",
  blueprint_too_fast = "Patientez encore quelques secondes avant d'ajouter un autre plan.",
  blueprint_duplicate = "Ce plan est déjà enregistré ici.",
  blueprint_incompatible = "Plan incompatible avec cet établi.",
  blueprint_added = "Plan ajouté avec succès.",
  bench_not_found = "Aucun établi de craft à proximité.",
  open_bench = "Ouvrir le menu de craft",
  gather_interact = "Récolter %s",
  gather_progress = "Récolte de %s...",
  gather_success = "Vous avez récupéré x%s %s.",
  gather_failed = "Vous n'avez rien trouvé.",
  gather_disabled = "La récolte est indisponible pour le moment.",
  gather_inventory_full = "Votre inventaire est plein.",
  gather_cancelled = "Récolte annulée.",
  gather_in_progress = "Vous êtes déjà occupé.",
  gather_too_far = "Approchez-vous de la zone.",
  gather_point_missing = "Point de récolte introuvable.",
  gather_busy = "Quelqu'un exploite déjà ce point, patientez %ss."
}

local translations = {
  search_items = "Rechercher un objet...",
  item_details = "Détails de l'objet",
  filter = "Filtrer",
  name_a_z = "Nom (A-Z)",
  name_z_a = "Nom (Z-A)",
  percentage_high_low = "Pourcentage (haut > bas)",
  percentage_low_high = "Pourcentage (bas > haut)",
  settings = "Paramètres",
  settings_description = "Personnalisez le menu de craft.",
  menu_opacity = "Opacité du menu",
  menu_opacity_description = "Ajuste la transparence du menu.",
  edit_menu_opacity = "Modifier l'opacité",
  menu_size = "Taille du menu",
  menu_size_description = "Ajuste la taille du menu.",
  edit_menu_size = "Modifier la taille",
  change_volume = "Volume des sons",
  change_volume_description = "Ajuste le volume des sons d'interface.",
  level_color = "Couleur du niveau",
  level_color_description = "Change la couleur de la barre de niveau.",
  save_changes = "Enregistrer",
  close = "Fermer",
  no_items_text = "Aucun objet trouvé",
  requirements = "Ressources requises",
  requirements_description = "Objets nécessaires pour fabriquer.",
  crafting_spin_wheel = "Roulette de craft",
  crafting_spin_wheel_description = "Faites tourner pour tenter votre chance.",
  craft = "Crafter",
  not_enough = "Ressources insuffisantes",
  successful_craft = "Craft réussi",
  unsuccessful_craft = "Craft échoué",
  crafting_successful_info = "Vous avez crafté \"%item\".",
  crafting_unsuccessful_info = "Vous n'avez pas crafté \"%item\".",
  performance = "Mode performances",
  performance_description = "Réduit les animations."
}

local function formatGatherString(template, value)
  if not template then
    return value
  end

  if value == nil then
    return template
  end

  if template:find("%%s", 1, true) then
    local ok, formatted = pcall(string.format, template, value)
    if ok then
      return formatted
    end
    local replaced, count = template:gsub("%%s", tostring(value))
    if count > 0 then
      return replaced
    end
  end

  return template
end

local function buildMarkerConfig(markerData)
  if not markerData then
    return nil
  end

  local scaleData = markerData.scale or {}
  local offsetData = markerData.offset or {}
  local colorData = markerData.color or {}

  return {
    type = markerData.type or 2,
    scale = vec3(
      scaleData.x or 0.35,
      scaleData.y or 0.35,
      scaleData.z or 0.35
    ),
    color = {
      r = colorData.r or 255,
      g = colorData.g or 170,
      b = colorData.b or 40,
      a = colorData.a or 180
    },
    bob = markerData.bob ~= false,
    face = markerData.face ~= false,
    rotate = markerData.rotate or false,
    offset = vec3(
      offsetData.x or 0.0,
      offsetData.y or 0.0,
      offsetData.z or 0.0
    )
  }
end

local function getResourceLabel(pointConfig, fallbackId)
  if pointConfig and pointConfig.label then
    return pointConfig.label
  end

  if pointConfig and pointConfig.item then
    return string.upper(pointConfig.item)
  end

  if fallbackId then
    return string.upper(fallbackId)
  end

  return "Ressource"
end

local function sendTranslations()
  SendNUIMessage({
    type = "TRANSLATIONS",
    translations = translations
  })
end

local function openBenchCrafting(benchId)
  local bench = benchPoints[benchId]
  if not bench then
    return
  end

  local blueprintData = nil
  if Config.Blueprints.store == "bench" then
    blueprintData = benchBlueprints[benchId]
  elseif Config.Blueprints.store == "player" and playerCitizenId then
    blueprintData = playerBlueprints[playerCitizenId]
  end
  
  local success, craftingData = lib.callback.await(
    "nv-crafting:server:getCraftingReqs",
    false,
    bench.benchName,
    "bench",
    blueprintData
  )
  
  if not success then
    print("Invalid Requirements for crafting bench " .. bench.benchName)
    return
  end
  
  SendCraftingDataToUI(craftingData)
  sendTranslations()
  openCraftingUI()
end

local function storeBench(benchId)
  local bench = benchPoints[benchId]
  if not bench then
    return
  end

  handleProgress({
    duration = Config.BenchAnimations.moving_bench.duration,
    label = text.moving,
    canCancel = true,
    disableControls = true,
    animDict = Config.BenchAnimations.moving_bench.animDict,
    anim = Config.BenchAnimations.moving_bench.anim,
    flag = Config.BenchAnimations.moving_bench.flag
  }, function()
    bench = benchPoints[benchId]
    if not (bench and bench.entity and DoesEntityExist(bench.entity)) then
      if DeveloperMode then
        print("Mismatch in entity/points list. Failed to move bench.")
      end
      return
    end

    local currentCitizenId = playerCitizenId
    if currentCitizenId ~= bench.identifier and Config.Benches.onlyOwnerCanMove then
      notify(text.not_owner)
      return
    end
    
    TriggerServerEvent("nv-crafting:server:deletePoint", benchId)
    
    if Config.Blueprints.store == "bench" then
      local storedBlueprints = benchBlueprints[benchId]
      
      if not (storedBlueprints and next(storedBlueprints) ~= nil) then
        TriggerServerEvent("nv-crafting:server:addBench", {
          name = bench.benchName,
          amount = 1,
          metadata = {blueprints = nil}
        })
      else
        TriggerServerEvent("nv-crafting:server:addBench", {
          name = bench.benchName,
          amount = 1,
          metadata = {blueprints = storedBlueprints}
        })
      end
    elseif Config.Blueprints.store == "player" then
      TriggerServerEvent("nv-crafting:server:addBench", {
        name = bench.benchName,
        amount = 1
      })
    end
  end, function()
    notify(text.move_cancelled)
  end)
end

local function openBenchContext(benchId)
  local bench = benchPoints[benchId]
  if not bench then
    return
  end

  local contextId = ("nv_crafting_bench_%s"):format(benchId)
  lib.registerContext({
    id = contextId,
    title = bench.benchLabel or text.craft_on_bench,
    options = {
      {
        title = text.craft_on_bench,
        icon = "fa-solid fa-hammer",
        onSelect = function()
          openBenchCrafting(benchId)
        end
      },
      {
        title = text.move_bench,
        icon = "fa-solid fa-box",
        onSelect = function()
          storeBench(benchId)
        end
      }
    }
  })

  lib.showContext(contextId)
end

function UpdateBenchBPs(benchId, blueprints)
  if not benchId then
    return
  end
  
  blueprints = blueprints or {}
  benchBlueprints[benchId] = blueprints
  
  if next(benchBlueprints[benchId]) then
    return true
  end
  return false
end

function UpdatePlayerBPs(citizenId, blueprints)
  if not citizenId then
    return
  end
  
  blueprints = blueprints or {}
  playerBlueprints[citizenId] = blueprints
  
  if next(playerBlueprints[citizenId]) then
    return true
  end
  return false
end

function SendCraftingDataToUI(craftingData)
  if craftingData then
    SendNUIMessage({
      type = "SET_LEVEL_VALUES",
      levelUpXPMultiplier = Config.LevelValues.levelUpXPMultiplier
    })
    
    local itemsJson = json.encode(craftingData.items)
    
    SendNUIMessage({
      type = "UPDATE_CRAFTING_STATION",
      items = itemsJson,
      stationInfo = craftingData.stationInfo,
      firstName = craftingData.playerFirstName,
      lastName = craftingData.playerLastName,
      playerLevel = craftingData.playerLevel,
      playerXP = craftingData.playerXP
    })
  else
    print("No data found for this station.")
  end
end

function PlayCelebrationAnimation()
  local playerPed = PlayerPedId()
  local animDict = Config.Celebration.animDict
  local animName = Config.Celebration.animName
  local animDuration = GetAnimDuration(animDict, animName) * 1000
  
  if animDict and animName then
    RequestAnimDict(animDict)
    
    local timeout = 3000
    local elapsed = 0
    local interval = 100
    
    while not HasAnimDictLoaded(animDict) and timeout > elapsed do
      Wait(interval)
      elapsed = elapsed + interval
    end
    
    if HasAnimDictLoaded(animDict) then
      Wait(1000)
      TaskPlayAnim(playerPed, animDict, animName, 8.0, 8.0, -1, 49, 1.0, false, false, false)
      Wait(animDuration)
      ClearPedTasks(playerPed)
    else
      if DeveloperMode then
        print("[nv-crafting] Timeout reached, failed to load animation dictionary: " .. animDict)
      end
    end
  end
end

function LoadModel(modelHash)
  local attempts = 0
  local timedOut = false
  
  RequestModel(modelHash)
  
  while not HasModelLoaded(modelHash) do
    Wait(500)
    attempts = attempts + 1
    if attempts >= 5 then
      timedOut = true
      break
    end
  end
  
  return timedOut
end

function CreateZones()
  local zoneConfigs = Config.Benches.benchPlacement.zones
  
  for _, zoneConfig in next, zoneConfigs, nil, nil do
    local vectorCount = #zoneConfig.vectors
    
    if vectorCount > 1 and zoneConfig.height then
      local zoneIndex = #placementZones + 1
      placementZones[zoneIndex] = lib.zones.poly({
        points = zoneConfig.vectors,
        thickness = zoneConfig.height or 4.0
      })
    elseif vectorCount == 1 and zoneConfig.radius then
      local zoneIndex = #placementZones + 1
      placementZones[zoneIndex] = lib.zones.sphere({
        coords = vec3(zoneConfig.vectors[1].x, zoneConfig.vectors[1].y, zoneConfig.vectors[1].z),
        radius = zoneConfig.radius or 4.0
      })
    elseif vectorCount == 1 and zoneConfig.size then
      local zoneIndex = #placementZones + 1
      placementZones[zoneIndex] = lib.zones.box({
        coords = vec3(zoneConfig.vectors[1].x, zoneConfig.vectors[1].y, zoneConfig.vectors[1].z),
        size = zoneConfig.size or vec3(2, 2, 2),
        rotation = zoneConfig.vectors[1].w or 0.0
      })
    end
    
    local currentZone = placementZones[#placementZones]
    
    currentZone.onEnter = function()
      insidePlacementZone = true
    end
    
    currentZone.onExit = function()
      insidePlacementZone = false
    end
  end
  
  return true
end

function InitializePlayerData()
  playerDataLoaded = true

  local hasData, benchData, playerBPs, citizenId = lib.callback.await("nv-crafting:server:playerLoaded", false)

  if not hasData then
    print("Failed to get player data on PlayerLoaded.")
    return
  end

  playerCitizenId = citizenId

  if benchData then
    for benchId, bench in ipairs(benchData) do
      if bench then
        AddPoint(bench, benchId)
      end
    end
  end

  if playerBPs and citizenId then
    UpdatePlayerBPs(citizenId, playerBPs)
  end
end

RegisterNetEvent("nv-crafting:client:playerLoaded")
AddEventHandler("nv-crafting:client:playerLoaded", function()
  InitializePlayerData()
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
  InitializePlayerData()
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload")
AddEventHandler("QBCore:Client:OnPlayerUnload", function()
  if not playerCitizenId then
    return
  end

  local saveSuccess = lib.callback.await("nv-crafting:server:playerDropped", false)
  if saveSuccess and DeveloperMode then
    print("Successfully unloaded.")
  end
end)

function OpenStationCraftingUI(stationId)
  local stationConfig = Config.Stations[stationId]
  if not stationConfig then
    return
  end
  
  local success, response = lib.callback.await("nv-crafting:server:getCraftingReqs", false, stationId, "station", nil)
  
  if not success then
    if response == "no_access" then
      notify(text.station_access_denied)
    else
      print("Invalid Requirements for station " .. stationId)
    end
    return
  end
  
  SendCraftingDataToUI(response)
  sendTranslations()
  openCraftingUI()
end

function CreateCraftingStations()
  for stationId, stationConfig in pairs(Config.Stations) do
    if type(stationConfig) == "table" then
      local stationName = stationId
      local targetConfig = stationConfig.target
      local coords = targetConfig.coords
      local modelHash = targetConfig.model
      local heading = targetConfig.heading
      
      local nuiIsOpen = NuiOpen
      
      if not stationPoints[stationName] then
        stationPoints[stationName] = lib.points.new({
          entity = nil,
          coords = coords,
          distance = Config.Stations.HideStationDistance or 50,
          
          onEnter = function()
            if DoesEntityExist(stationPoints[stationName].entity) then
              if DeveloperMode then
                print("The station entity already exists.")
              end
              return
            end
            
            local modelTimedOut = LoadModel(modelHash)
            if modelTimedOut then
              print("Timed out. Could not load crafting station entity models.")
            end
            
            local groundFound, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, true)
            
            if not (groundFound and groundZ) or groundZ == 0 then
              Citizen.Wait(500)
              groundFound, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, true)
            end
            
            if groundFound then
              coords = vector3(coords.x, coords.y, groundZ)
            end
            
            local entity
            
            if targetConfig.type == "npc" then
              entity = CreatePed(5, modelHash, coords.x, coords.y, coords.z, heading, false, false)
              SetEntityAsMissionEntity(entity, true, true)
              SetBlockingOfNonTemporaryEvents(entity, true)
              FreezeEntityPosition(entity, true)
              SetEntityInvincible(entity, true)
              SetBlockingOfNonTemporaryEvents(entity, true)
              PlaceObjectOnGroundProperly(entity)
              
              stationPoints[stationName].entity = entity
              
              if not DoesEntityExist(entity) then
                print("Retrying to create crafting station entities")
                Wait(1000)
                entity = CreatePed(5, modelHash, coords.x, coords.y, coords.z, heading, false, false)
                SetEntityAsMissionEntity(entity, true, true)
                SetBlockingOfNonTemporaryEvents(entity, true)
                FreezeEntityPosition(entity, true)
                SetEntityInvincible(entity, true)
                SetBlockingOfNonTemporaryEvents(entity, true)
                PlaceObjectOnGroundProperly(entity)
                stationPoints[stationName].entity = entity
              end
              
              if not DoesEntityExist(entity) then
                print("Failed to create crafting station entities.")
              end
            elseif targetConfig.type == "prop" then
              entity = CreateObject(GetHashKey(modelHash), coords.x, coords.y, coords.z, false, true, false)
              SetEntityHeading(entity, heading)
              SetEntityAsMissionEntity(entity, true, true)
              SetBlockingOfNonTemporaryEvents(entity, true)
              FreezeEntityPosition(entity, true)
              SetEntityInvincible(entity, true)
              PlaceObjectOnGroundProperly(entity)
              
              stationPoints[stationName].entity = entity
              
              if not DoesEntityExist(entity) then
                print("Retrying to create crafting station entities")
                Wait(1000)
                entity = CreateObject(GetHashKey(modelHash), coords.x, coords.y, coords.z, false, true, false)
                SetEntityHeading(entity, heading)
                SetEntityAsMissionEntity(entity, true, true)
                SetBlockingOfNonTemporaryEvents(entity, true)
                FreezeEntityPosition(entity, true)
                SetEntityInvincible(entity, true)
                PlaceObjectOnGroundProperly(entity)
                stationPoints[stationName].entity = entity
              end
              
              if not DoesEntityExist(entity) then
                print("Failed to create crafting station entities.")
              end
            end
            
            stationPoints[stationName].interactionId = addInteractionPoint({
              coords = vector3(coords.x, coords.y, coords.z + 1.2),
              dist = 2.5,
              message = stationConfig.title or "Atelier",
              icon = "fa-solid fa-cogs",
              onPress = function()
                OpenStationCraftingUI(stationName)
              end
            })
            
            SetModelAsNoLongerNeeded(modelHash)
          end,
          
          onExit = function()
            if stationPoints[stationName].entity then
              if DoesEntityExist(stationPoints[stationName].entity) then
                DeleteEntity(stationPoints[stationName].entity)
                stationPoints[stationName].entity = 0
              end
            end
            
            if stationPoints[stationName].interactionId then
              removeInteractionPoint(stationPoints[stationName].interactionId)
              stationPoints[stationName].interactionId = nil
            end
            
            if nuiIsOpen then
              closeUIManual()
            end
          end
        })
      end
    end
  end
end

local function StartResourceGather(pointId)
  if isGatheringResource then
    notify(text.gather_in_progress)
    return
  end

  local resourceConfig = Config.ResourcePoints
  if not (resourceConfig and resourceConfig.enabled) then
    notify(text.gather_disabled)
    return
  end

  local pointConfig = resourceConfig.points and resourceConfig.points[pointId]
  local resourcePoint = resourcePoints[pointId]

  if not (pointConfig and resourcePoint) then
    notify(text.gather_point_missing)
    return
  end

  local distanceLimit = resourcePoint.interactionDist or resourceConfig.interactionDist or 2.0
  if resourcePoint.currentDistance and resourcePoint.currentDistance > (distanceLimit + 0.5) then
    notify(text.gather_too_far)
    return
  end

  isGatheringResource = true

  local label = resourcePoint.label or getResourceLabel(pointConfig, pointId)
  local progressTemplate = pointConfig.progressLabel or resourceConfig.progressLabel or text.gather_progress
  local progressLabel = formatGatherString(progressTemplate, label) or label
  local duration = pointConfig.duration or resourceConfig.defaultDuration or 6000
  local canCancel = pointConfig.canCancel ~= false

  local animation = pointConfig.animation or resourceConfig.defaultAnimation
  local animOptions = nil

  if animation and animation.dict and animation.clip then
    animOptions = {
      dict = animation.dict,
      clip = animation.clip,
      flag = animation.flag
    }
  end

  local disableControls = resourceConfig.disableControls
  if pointConfig.disableControls ~= nil then
    disableControls = pointConfig.disableControls
  end

  if disableControls ~= false then
    disableControls = {
      move = true,
      car = true,
      combat = true,
      mouse = true
    }
  else
    disableControls = nil
  end

  local success = lib.progressCircle({
    duration = duration,
    label = progressLabel,
    position = "bottom",
    canCancel = canCancel,
    disable = disableControls,
    anim = animOptions
  })

  ClearPedTasks(PlayerPedId())

  if success then
    local result = lib.callback.await("nv-crafting:server:collectResource", false, pointId)
    if result and result.success then
      local amount = tonumber(result.amount) or 1
      if amount <= 0 then
        amount = 1
      end

      local rewardLabel = result.label or label
      if text.gather_success then
        notify(string.format(text.gather_success, amount, rewardLabel))
      else
        notify(("Récolte réussie : x%s %s"):format(amount, rewardLabel))
      end
    else
      local reason = result and result.reason or "failed"
      if reason == "inventory_full" then
        notify(text.gather_inventory_full)
      elseif reason == "disabled" then
        notify(text.gather_disabled)
      elseif reason == "busy" then
        local busyMsg = text.gather_busy or "Gisement occupé."
        local remaining = result and tonumber(result.remaining) or 1
        if busyMsg:find("%%s", 1, true) then
          notify(string.format(busyMsg, math.max(remaining, 1)))
        else
          notify(busyMsg)
        end
      else
        notify(text.gather_failed)
      end
    end
  else
    notify(text.gather_cancelled)
  end

  isGatheringResource = false
end

local function CreateResourcePoints()
  local resourceConfig = Config.ResourcePoints
  if not (resourceConfig and resourceConfig.enabled) then
    return
  end

  local pointsConfig = resourceConfig.points or {}

  for pointId, pointData in pairs(pointsConfig) do
    if type(pointData) == "table" and pointData.coords and pointData.item then
      local resourcePoint = lib.points.new({
        coords = pointData.coords,
        distance = pointData.renderDistance or resourceConfig.renderDistance or 35.0
      })

      resourcePoint.resourceId = pointId
      resourcePoint.pointConfig = pointData
      resourcePoint.label = getResourceLabel(pointData, pointId)
      resourcePoint.interactionDist = pointData.interactionDist or resourceConfig.interactionDist or 2.0
      resourcePoint.markerRenderDistance = pointData.markerDistance or resourceConfig.markerDistance or 20.0

      local interactionOffset = pointData.interactionOffset or resourceConfig.interactionOffset or 0.8
      resourcePoint.interactionCoords = vector3(
        pointData.coords.x,
        pointData.coords.y,
        pointData.coords.z + interactionOffset
      )

      local interactTemplate = pointData.interactionLabel or resourceConfig.interactionLabel or text.gather_interact
      resourcePoint.interactionMessage = formatGatherString(interactTemplate, resourcePoint.label) or resourcePoint.label
      resourcePoint.interactionIcon = pointData.interactionIcon or resourceConfig.interactionIcon or "fa-solid fa-helmet-safety"

      resourcePoint.markerConfig = buildMarkerConfig(pointData.marker or resourceConfig.marker)
      if resourcePoint.markerConfig then
        local offset = resourcePoint.markerConfig.offset
        resourcePoint.markerCoords = vector3(
          pointData.coords.x + offset.x,
          pointData.coords.y + offset.y,
          pointData.coords.z + offset.z
        )
      end

      function resourcePoint:onEnter()
        if self.interactionId then
          removeInteractionPoint(self.interactionId)
          self.interactionId = nil
        end

        self.interactionId = addInteractionPoint({
          coords = self.interactionCoords,
          dist = self.interactionDist,
          message = self.interactionMessage,
          icon = self.interactionIcon,
          onPress = function()
            StartResourceGather(self.resourceId)
          end
        })
      end

      function resourcePoint:onExit()
        if self.interactionId then
          removeInteractionPoint(self.interactionId)
          self.interactionId = nil
        end
      end

      function resourcePoint:nearby()
        local marker = self.markerConfig
        local coords = self.markerCoords

        if not (marker and coords) then
          return
        end

        local renderDist = self.markerRenderDistance or 20.0
        if self.currentDistance and self.currentDistance > renderDist then
          return
        end

        DrawMarker(
          marker.type,
          coords.x,
          coords.y,
          coords.z,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          marker.scale.x,
          marker.scale.y,
          marker.scale.z,
          marker.color.r,
          marker.color.g,
          marker.color.b,
          marker.color.a,
          marker.bob,
          marker.face,
          2,
          marker.rotate,
          nil,
          nil,
          false
        )
      end

      resourcePoints[pointId] = resourcePoint
    elseif DeveloperMode then
      print(("[nv-crafting] Invalid resource point configuration for '%s'."):format(pointId))
    end
  end
end

RegisterNUICallback("craftingResult", function(data, callback)
  ClearPedTasks(PlayerPedId())
  
  local craftingType = nil
  
  if string.find(data.stationID, "bench") then
    craftingType = "bench"
  else
    craftingType = "station"
  end
  
  if craftingType == "station" then
    local stationPoint = stationPoints[data.stationID] or nil
    
    if not stationPoint then
      print("Station point was not found!")
      return
    end
    
    if stationPoint.currentDistance > 5.0 then
      print("Player is too far from the crafting station!")
      closeUIManual()
      return
    end
  end
  
  callback("ok")
  
  local craftResult = lib.callback.await(
    "nv-crafting:server:validateCraft",
    false,
    data.stationID,
    data.item.itemName,
    data.amount,
    data.success,
    craftingType
  )
  
  if craftResult == nil then
    print("Something went wrong trying to validate the craft.")
  end
  
  if craftResult then
    PlayCelebrationAnimation()
  end
end)

function PreviewBenchPlacement(benchName, propModel, metadata, itemSlot)
  local citizenId = playerCitizenId

  if not citizenId then
    notify("Impossible de récupérer votre identifiant personnage.")
    return
  end
  
  if benchOwnedByPlayer[citizenId] then
    notify(text.no_more_benches)
    return
  end
  
  local playerPed = PlayerPedId()
  local playerHeading = GetEntityHeading(playerPed)
  local rotationOffset = {x = 0, y = playerHeading + 90, z = 0}
  
  local rayHit, _, hitCoords = lib.raycast.fromCamera(511, playerPed, 10.0)
  
  if rayHit then
    if not previewProp then
      previewProp = true
      
      local previewEntity = CreateObjectNoOffset(GetHashKey(propModel), hitCoords.x, hitCoords.y, hitCoords.z, false, true, false)
      SetEntityHeading(previewEntity, playerHeading)
      PlaceObjectOnGroundProperly(previewEntity)
      SetEntityCollision(previewEntity, false, true)
      SetEntityAlpha(previewEntity, 100)
      FreezeEntityPosition(previewEntity, true)
      SetModelAsNoLongerNeeded(GetHashKey(propModel))
      
      previewBenchId = previewEntity
      
      lib.showTextUI([[
[E] - Place Bench  
 [R] - Cancel]])
      
      local raycastInterval = 0
      
      CreateThread(function()
        while previewProp do
          Wait(0)
          DisableControlAction(1, 140, true)
          DisableControlAction(1, 263, true)
          DisableControlAction(1, 24, true)
          DisableControlAction(1, 257, true)
          
          if IsControlPressed(1, 14) then
            rotationOffset.y = rotationOffset.y - 15.0
          end
          
          if IsControlPressed(1, 15) then
            rotationOffset.y = rotationOffset.y + 15.0
          end
          
          if IsDisabledControlJustPressed(1, 140) then
            DeleteObject(previewBenchId)
            previewProp = false
            break
          end
        end
      end)
      
      CreateThread(function()
        while previewProp do
          Wait(raycastInterval)
          
          local hit, _, coords = lib.raycast.fromCamera(511, playerPed, 9)
          hitCoords = coords
          rayHit = hit
          
          if rayHit and hitCoords then
            raycastInterval = 20
            SetEntityCoordsNoOffset(previewBenchId, hitCoords.x, hitCoords.y, hitCoords.z)
            SetEntityHeading(previewBenchId, rotationOffset.y)
            PlaceObjectOnGroundProperly(previewBenchId)
            
            if IsControlPressed(1, 38) then
              previewProp = false
              
              local finalCoords = GetEntityCoords(previewBenchId)
              local finalHeading = GetEntityHeading(previewBenchId)
              
              DeleteObject(previewBenchId)
              
              if not playerHasItem(benchName, 1) then
                break
              end
              
              if placementZones and isBlacklistMode ~= nil then
                if Config.Benches.benchPlacement.enabled then
                  if (isBlacklistMode and insidePlacementZone) or (not isBlacklistMode and not insidePlacementZone) then
                    local errorMessage = isBlacklistMode and text.bench_blacklist or text.bench_whitelist
                    
                    lib.hideTextUI()
                    notify(errorMessage)
                    return
                  end
                end
              end
              
              local playerPos = GetEntityCoords(playerPed)
              local distance = #(playerPos - finalCoords)
              
              if distance <= 3.0 then
                lib.hideTextUI()
                
                local playerRoutingBucket = lib.callback.await("nv-crafting:server:getPlyRB", false)
                
                handleProgress({
                  duration = Config.BenchAnimations.putting_down_bench.duration,
                label = text.putting_down,
                  canCancel = true,
                  disableControls = true,
                  animDict = Config.BenchAnimations.putting_down_bench.animDict,
                  anim = Config.BenchAnimations.putting_down_bench.anim,
                  flag = Config.BenchAnimations.putting_down_bench.flag
                }, function()
                  local benchData = {
                    coords = finalCoords,
                    distance = Config.Benches.HideBenchDistance or 50,
                    propName = propModel,
                    benchName = benchName,
                    prop = nil,
                    heading = finalHeading,
                    identifier = citizenId,
                    metadata = metadata or nil,
                    routingBucket = playerRoutingBucket or Config.MainRoutingBucket
                  }
                  
                  local newBenchId = lib.callback.await("nv-crafting:server:storePoint", false, benchData, true)
                  
                  if not newBenchId then
                    if DeveloperMode then
                      print("Could not get benchId. Failed to place bench.")
                    end
                    return
                  end
                  
                  lib.callback.await("nv-crafting:server:removeItem", false, {
                    name = benchName,
                    amount = 1,
                    slot = itemSlot
                  })
                  
                    notify(text.bench_placed)
                  
                  if Config.Blueprints.store == "bench" then
                    benchBlueprints[newBenchId] = nil
                    
                    if not (benchBlueprints[newBenchId] and next(benchBlueprints[newBenchId]) ~= nil) then
                      if metadata then
                        benchBlueprints[newBenchId] = metadata.blueprints or nil
                      else
                        benchBlueprints[newBenchId] = nil
                      end
                    end
                  end
                end, function()
                    notify(text.bench_cancelled)
                end)
                
                break
              else
                notify(text.bench_too_far)
                break
              end
            end
          else
            raycastInterval = 300
          end
        end
        
        lib.hideTextUI()
      end)
    end
  end
end

RegisterNetEvent("nv-crafting:client:previewProp")
AddEventHandler("nv-crafting:client:previewProp", PreviewBenchPlacement)

exports("previewProp", PreviewBenchPlacement)

function AddPoint(benchData, benchId)
  local existingPoint = benchPoints[benchId]
  
  if existingPoint and next(existingPoint) ~= nil then
    if existingPoint.entity and existingPoint.entity ~= 0 then
      print("Something went wrong while syncing points.")
      return
    end
  end
  
  benchPoints[benchId] = lib.points.new(benchData)
  
  benchPoints[benchId].onEnter = function()
    if DoesEntityExist(benchPoints[benchId].entity) then
      if DeveloperMode then
        print("Entity already exists")
      end
      return
    end
    
    local playerRoutingBucket = lib.callback.await("nv-crafting:server:getPlyRB", false)
    
    if playerRoutingBucket ~= benchPoints[benchId].routingBucket then
      if DeveloperMode then
        print("Player is not in the same bucket as the entity.", "Player Bucket:", playerRoutingBucket, "Entity Bucket:", benchPoints[benchId].routingBucket)
      end
      return
    end
    
    local coords = benchPoints[benchId].coords
    local groundFound, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, true)
    
    if not (groundFound and groundZ) or groundZ == 0 then
      Citizen.Wait(500)
      groundFound, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, true)
    end
    
    if groundFound then
      coords = vector3(coords.x, coords.y, groundZ)
    end
    
    benchPoints[benchId].entity = CreateObjectNoOffset(
      GetHashKey(benchData.propName),
      coords,
      false,
      true,
      false
    )
    
    SetEntityHeading(benchPoints[benchId].entity, benchPoints[benchId].heading)
    FreezeEntityPosition(benchPoints[benchId].entity, true)
    SetEntityInvincible(benchPoints[benchId].entity, true)
    SetModelAsNoLongerNeeded(GetHashKey(benchPoints[benchId].propName))
    
    if Config.Blueprints.store == "bench" then
      benchBlueprints[benchId] = nil
      
      if not (benchBlueprints[benchId] and next(benchBlueprints[benchId]) ~= nil) then
        if benchPoints[benchId].metadata then
          benchBlueprints[benchId] = benchPoints[benchId].metadata.blueprints or nil
        else
          benchBlueprints[benchId] = nil
        end
      end
    end
    
    benchPoints[benchId].interactionId = addInteractionPoint({
      coords = vector3(coords.x, coords.y, coords.z + 0.8),
      dist = 2.5,
      message = benchPoints[benchId].benchLabel or text.craft_on_bench,
      icon = "fa-solid fa-hammer",
      onPress = function()
        openBenchContext(benchId)
      end
    })
    
    local identifier = benchPoints[benchId].identifier
    benchOwnedByPlayer[identifier] = benchPoints[benchId].entity
  end
  
  benchPoints[benchId].onExit = function()
    if NuiOpen then
      closeUIManual()
    end
    
    if benchPoints[benchId].interactionId then
      removeInteractionPoint(benchPoints[benchId].interactionId)
      benchPoints[benchId].interactionId = nil
    end
    
    if DoesEntityExist(benchPoints[benchId].entity) then
      DeleteEntity(benchPoints[benchId].entity)
      
      local identifier = benchPoints[benchId].identifier
      benchOwnedByPlayer[identifier] = nil
      benchBlueprints[benchId] = nil
      benchPoints[benchId].entity = 0
    end
  end
end

RegisterNetEvent("AddPoint")
AddEventHandler("AddPoint", function(benchData, benchId)
  if benchData and benchId then
    AddPoint(benchData, benchId)
  end
end)

function DeletePoint(benchId)
  local benchPoint = benchPoints[benchId]
  
  if benchPoint then
    benchPoint:remove()
    benchPoints[benchId] = nil
    
    if benchPoint.entity then
      if DoesEntityExist(benchPoint.entity) then
        DeleteEntity(benchPoint.entity)
      end
    end
    
    if benchPoint.interactionId then
      removeInteractionPoint(benchPoint.interactionId)
    end
    
    local identifier = benchPoint.identifier
    benchOwnedByPlayer[identifier] = nil
    benchBlueprints[benchId] = nil
  else
    if DeveloperMode then
      print("Could not find the bench")
    end
  end
end

RegisterNetEvent("DeletePoint")
AddEventHandler("DeletePoint", function(benchId)
  if benchId then
    DeletePoint(benchId)
  end
end)

function HandleBlueprintUsage(blueprintItemName, blueprintMetadata, itemSlot)
  if Config.Blueprints.store == "bench" then
    local currentTime = GetGameTimer()
    local timeSinceLastUse = currentTime - lastBlueprintUseTime
    
    if timeSinceLastUse < blueprintCooldown then
      notify(text.blueprint_too_fast)
      return
    end
    
    lastBlueprintUseTime = currentTime
    
    local nearbyPoints = lib.points.getNearbyPoints()
    local closestBench = nil
    local closestDistance = 5.0
    
    for _, point in pairs(nearbyPoints) do
      if point and point.benchName then
        if closestDistance > point.currentDistance then
          closestBench = point
          closestDistance = point.currentDistance
        end
      end
    end
    
    if closestBench then
      lib.showTextUI("[E] - Use " .. blueprintMetadata.label .. "\n[R] - Cancel")
      
      CreateThread(function()
        local isWaiting = true
        
        while isWaiting do
          Wait(0)
          DisableControlAction(1, 140, true)
          
          if IsControlJustReleased(0, 38) then
            lib.hideTextUI()
            isWaiting = false
            
            local benchBPs = benchBlueprints[closestBench.benchId] or {}
            local blueprintContent = blueprintMetadata.blueprintContent
            
            if type(blueprintContent) == "table" then
              blueprintContent = blueprintContent[1]
            end
            
            for _, existingBP in ipairs(benchBPs) do
              if existingBP == blueprintContent then
                notify(text.blueprint_duplicate)
                return
              end
            end
            
            if closestBench.benchName ~= Config.Blueprints.items[blueprintContent].bench then
              notify(text.blueprint_incompatible)
              return
            end
            
            if playerHasItem(blueprintItemName, 1) then
              local removeSuccess = lib.callback.await("nv-crafting:server:removeItem", false, {
                name = blueprintItemName,
                amount = 1,
                slot = itemSlot or nil
              })
              
              if removeSuccess then
                table.insert(benchBPs, blueprintContent)
                
                if UpdateBenchBPs(closestBench.benchId, benchBPs) then
                  local saveSuccess = lib.callback.await(
                    "nv-crafting:server:updateBlueprints",
                    false,
                    {blueprints = benchBPs},
                    closestBench.identifier,
                    closestBench.benchName
                  )
                  
                  if not saveSuccess then
                    print("Something went wrong trying to save the blueprints to the database.")
                  end
                  
                  notify(text.blueprint_added)
                else
                  print("Failure to add blueprint")
                end
              end
            end
          elseif IsDisabledControlJustReleased(0, 140) then
            lib.hideTextUI()
            isWaiting = false
            return
          end
          
          if closestBench.currentDistance > closestDistance then
            lib.hideTextUI()
            isWaiting = false
          end
        end
      end)
    else
      notify(text.bench_not_found)
    end
  elseif Config.Blueprints.store == "player" then
    local citizenId = playerCitizenId
    if not citizenId then
      notify("Identifiant joueur introuvable.")
      return
    end

    local playerBPs = playerBlueprints[citizenId] or {}
    local blueprintContent = blueprintMetadata.blueprintContent
    
    if type(blueprintContent) == "table" then
      blueprintContent = blueprintContent[1]
    end
    
    for _, existingBP in ipairs(playerBPs) do
      if existingBP == blueprintContent then
        notify(text.blueprint_duplicate)
        return
      end
    end
    
    if playerHasItem(blueprintItemName, 1) then
      local removeSuccess = lib.callback.await("nv-crafting:server:removeItem", false, {
        name = blueprintItemName,
        amount = 1,
        slot = itemSlot or nil
      })
      
      if removeSuccess then
        table.insert(playerBPs, blueprintContent)
        
        if UpdatePlayerBPs(citizenId, playerBPs) then
          local saveSuccess = lib.callback.await(
            "nv-crafting:server:updateBlueprints",
            false,
            {blueprints = playerBPs},
            citizenId,
            "ply"
          )
          
          if not saveSuccess then
            print("Something went wrong trying to save the blueprints to the database.")
          end
          
          notify(text.blueprint_added)
        else
          print("Failure to add blueprint")
        end
      end
    end
  end
end

RegisterNetEvent("nv-crafting:client:checkNearbyBenches")
AddEventHandler("nv-crafting:client:checkNearbyBenches", HandleBlueprintUsage)

exports("checkNearbyBenches", HandleBlueprintUsage)

AddEventHandler("onClientResourceStart", function(resourceName)
  if resourceName ~= GetCurrentResourceName() then
    return
  end
  
  isBlacklistMode = Config.Benches.benchPlacement.mode == "blacklist"
  
  if not playerDataLoaded then
    InitializePlayerData()
  end
  
  if Config.Benches.benchPlacement.enabled then
    CreateZones()
  end
  
  CreateCraftingStations()
  CreateResourcePoints()
  
  sendTranslations()
end)

AddEventHandler("onClientResourceStop", function(resourceName)
  if resourceName ~= GetCurrentResourceName() then
    return
  end
  
  local allPoints = lib.points.getAllPoints()
  
  for _, point in pairs(allPoints) do
    if point.entity and point.entity ~= 0 then
      DeleteEntity(point.entity)
      point.entity = 0
    end
    point:remove()
  end
end)

TriggerEvent("chat:addSuggestion", "/createblueprint", "Helps you create a blueprint! (DEV MODE)", {
  {name = "player", help = "Player ID"},
  {name = "blueprintName", help = "Blueprint Name"},
  {name = "amount", help = "The amount of blueprints"}
})