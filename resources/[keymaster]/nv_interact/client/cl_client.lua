local KeyCodes = {
  A = 34,
  B = 29,
  C = 26,
  D = 30,
  E = 46,
  F = 49,
  G = 47,
  H = 74,
  K = 311,
  L = 7,
  M = 244,
  N = 249,
  P = 199,
  Q = 44,
  R = 45,
  S = 33,
  T = 245,
  U = 303,
  V = 0,
  W = 32,
  X = 73,
  Y = 246,
  Z = 20,
  UpArr = 27,
  DownArr = 173,
  LeftArr = 174,
  RightArr = 175,
  LAlt = 19,
  F11 = 344,
  NUM1 = 157,
  NUM2 = 158,
  NUM3 = 160,
  NUM4 = 164,
  NUM5 = 165,
  NUM6 = 159,
  NUM7 = 161,
  NUM8 = 162,
  NUM9 = 163,
  LShift = 21,
  ESC = 322,
  F1 = 288,
  F2 = 289,
  F3 = 170,
  F5 = 166,
  F6 = 167,
  F7 = 168,
  F8 = 169,
  F9 = 56,
  F10 = 57,
  ["~"] = 243,
  ["1"] = 157,
  ["2"] = 158,
  ["3"] = 160,
  ["4"] = 164,
  ["5"] = 165,
  ["6"] = 159,
  ["7"] = 161,
  ["8"] = 162,
  ["9"] = 163,
  ["-"] = 84,
  ["="] = 83,
  BACKSPACE = 177,
  TAB = 37,
  ["]"] = 40,
  ENTER = 18,
  CAPS = 137,
  LEFTSHIFT = 21,
  [","] = 82,
  ["."] = 81,
  LEFTCTRL = 36,
  LEFTALT = 19,
  SPACE = 22,
  RIGHTCTRL = 70,
  HOME = 213,
  PAGEUP = 10,
  PAGEDOWN = 11,
  DELETE = 178,
  LEFT = 174,
  RIGHT = 175,
  TOP = 27,
  DOWN = 173,
  NENTER = 201,
  N4 = 108,
  N5 = 60,
  N6 = 107,
  ["N+"] = 96,
  ["N-"] = 97,
  N7 = 117,
  N8 = 61,
  N9 = 118,
}

local interactionPoints = {}
local pointsByResource = {}
local nextPointId = 1

local bucketSize = 120.0
local buckets = {}
local pointBucket = {}

local function getBucketKey(coords)
  if not coords then return nil end
  local bx = math.floor(coords.x / bucketSize)
  local by = math.floor(coords.y / bucketSize)
  return ("%s:%s"):format(bx, by)
end

local function addToBucket(pointId, coords)
  local key = getBucketKey(coords)
  if not key then return end
  if not buckets[key] then
    buckets[key] = {}
  end
  table.insert(buckets[key], pointId)
  pointBucket[pointId] = key
end

local function removeFromBucket(pointId)
  local key = pointBucket[pointId]
  if not key then return end
  local bucket = buckets[key]
  if bucket then
    for i = #bucket, 1, -1 do
      if bucket[i] == pointId then
        table.remove(bucket, i)
        break
      end
    end
    if #bucket == 0 then
      buckets[key] = nil
    end
  end
  pointBucket[pointId] = nil
end

local function moveBucket(pointId, coords)
  local newKey = getBucketKey(coords)
  if newKey == pointBucket[pointId] then return end
  removeFromBucket(pointId)
  if newKey then
    if not buckets[newKey] then
      buckets[newKey] = {}
    end
    table.insert(buckets[newKey], pointId)
    pointBucket[pointId] = newKey
  end
end

local duiObject = nil
local duiTxdName = nil
local duiTxtName = nil
local isDisabled = false

function initializeDui()
  if duiObject then
    return
  end

  local screenWidth, screenHeight = GetActiveScreenResolution()
  local duiUrl = "https://cfx-nui-" .. GetCurrentResourceName() .. "/web/index.html"

  duiObject = CreateDui(duiUrl, screenWidth, screenHeight)
  local duiHandle = GetDuiHandle(duiObject)

  duiTxdName = "dui_global_txd"
  duiTxtName = "dui_global_txt"

  local txd = CreateRuntimeTxd(duiTxdName)
  CreateRuntimeTextureFromDuiHandle(txd, duiTxtName, duiHandle)

  RequestStreamedTextureDict(duiTxdName)
  while not HasStreamedTextureDictLoaded(duiTxdName) do
    Wait(0)
  end
end

function addInteractionPoint(pointData)
  initializeDui()

  if not pointData or not pointData.coords then
    return nil
  end

  local invokingResource = GetInvokingResource()
  local newId = nextPointId
  nextPointId = nextPointId + 1

  pointData.id = newId
  pointData.active = false
  interactionPoints[newId] = pointData
  addToBucket(newId, pointData.coords)

  if not pointsByResource[invokingResource] then
    pointsByResource[invokingResource] = {}
  end
  table.insert(pointsByResource[invokingResource], newId)

  if pointData.ped then
    CreateThread(function()
      RequestModel(pointData.ped)
      while not HasModelLoaded(pointData.ped) do
        Wait(0)
      end

      local pedEntity = CreatePed(
        4,
        pointData.ped,
        pointData.coords.x,
        pointData.coords.y,
        pointData.coords.z,
        pointData.heading,
        false,
        true
      )
      pointData.pedEntity = pedEntity

      SetEntityInvincible(pedEntity, true)
      SetBlockingOfNonTemporaryEvents(pedEntity, true)
      FreezeEntityPosition(pedEntity, true)

      if pointData.scenario then
        TaskStartScenarioInPlace(pedEntity, pointData.scenario, 0, true)
      end
    end)
  end

  return newId
end

function removeInteractionPoint(pointId)
  local point = interactionPoints[pointId]
  if not point then
    return
  end

  if point.pedEntity and DoesEntityExist(point.pedEntity) then
    DeleteEntity(point.pedEntity)
  end

  interactionPoints[pointId] = nil
  removeFromBucket(pointId)
end

exports("addInteractionPoint", addInteractionPoint)
exports("removeInteractionPoint", removeInteractionPoint)

local function updateInteractionPoint(pointId, updates)
  local point = interactionPoints[pointId]
  if not point or not updates then return end

  if updates.coords then
    point.coords = updates.coords
    moveBucket(pointId, point.coords)
  end

  if updates.message then
    point.message = updates.message
  end

  if updates.key then
    point.key = updates.key
  end

  if updates.icon then
    point.icon = updates.icon
  end
end

exports("updateInteractionPoint", updateInteractionPoint)

exports("SetActive", function(activeState)
  isDisabled = not activeState
end)

AddEventHandler("onResourceStop", function(resourceName)
  local points = pointsByResource[resourceName]
  if points then
    for _, pointId in ipairs(points) do
      removeInteractionPoint(pointId)
    end
    pointsByResource[resourceName] = nil
  end
end)

RegisterNUICallback("close", function(data, callback)
  Wait(500)
  callback("ok")
end)

local function collectNearbyBuckets(coords)
  local bx = math.floor(coords.x / bucketSize)
  local by = math.floor(coords.y / bucketSize)
  local list = {}
  for dx = -1, 1 do
    for dy = -1, 1 do
      local key = ("%s:%s"):format(bx + dx, by + dy)
      if buckets[key] and #buckets[key] > 0 then
        list[#list + 1] = key
      end
    end
  end
  return list
end

Citizen.CreateThread(function()
  while true do
    local waitTime = 800

    if not isDisabled then
      local playerPed = PlayerPedId()
      local playerCoords = GetEntityCoords(playerPed)
      local nearestDist = nil
      local hasInteraction = false
      local bucketList = collectNearbyBuckets(playerCoords)

      local function handlePoint(id, point)
        if not point or not point.coords or type(point.coords) ~= "vector3" then
          interactionPoints[id] = nil
          removeFromBucket(id)
          return
        end

        local distance = #(playerCoords - point.coords)
        if not nearestDist or distance < nearestDist then
          nearestDist = distance
        end
        local detectionDistance = point.dist or 2.0

        if distance < detectionDistance then
          hasInteraction = true
          waitTime = 0

          if not point.active then
            point.active = true
            local message = {
              type = "open",
              message = point.message,
              key = point.key,
              icon = point.icon,
            }
            SendDuiMessage(duiObject, json.encode(message))
          end

          local interactionKey = KeyCodes[point.key]
          if interactionKey == nil then
            print(("^3[nv_interact] ATTENTION: touche \"%s\" non reconnue pour l'interaction #%s^7"):format(
              tostring(point.key),
              tostring(id)
            ))
          elseif point.onPress and IsControlJustPressed(0, interactionKey) then
            local ok, err = pcall(point.onPress)
            if not ok then
              print(("^1[nv_interact] ERREUR: onPress pour l'interaction #%s a échoué: %s^7"):format(
                tostring(id),
                tostring(err)
              ))
            end
            local message = { type = "keyPressed" }
            SendDuiMessage(duiObject, json.encode(message))
          end

          local zOffset = point.ped and 1.0 or 0
          SetDrawOrigin(point.coords.x, point.coords.y, point.coords.z + zOffset, 0)
          DrawSprite(duiTxdName, duiTxtName, 0.0, 0.0, 0.5, 0.5, 0.0, 255, 255, 255, 255)
          ClearDrawOrigin()
        elseif point.active then
          point.active = false
          local message = { type = "close" }
          SendDuiMessage(duiObject, json.encode(message))
        end
      end

      if #bucketList > 0 then
        for _, key in ipairs(bucketList) do
          local bucket = buckets[key]
          if bucket then
            for _, pointId in ipairs(bucket) do
              handlePoint(pointId, interactionPoints[pointId])
            end
          end
        end
      else
        for id, point in pairs(interactionPoints) do
          handlePoint(id, point)
        end
      end

      if waitTime ~= 0 then
        if hasInteraction or (nearestDist and nearestDist <= 40.0) then
          waitTime = 0
        elseif nearestDist and nearestDist <= 80.0 then
          waitTime = 120
        elseif nearestDist and nearestDist <= 150.0 then
          waitTime = 300
        else
          waitTime = 800
        end
      end
    end

    Wait(waitTime)
  end
end)
