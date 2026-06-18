


ESX = nil
if Config and Config.ESXMode == "old" then
    ESX = ESX or nil
    TriggerEvent("esx:getSharedObject", function(obj)
        ESX = obj
    end)
else
    ESX = exports.es_extended:getSharedObject()
end


territoryDuis = {}
OVERLAY_TXD = "nvTerritory_polys"
currentTerritoryData = nil
mapInitialized = false
overlayBatchId = 0
territoryStateCache = {}
cityBatchDui = nil
northBatchDui = nil
BATCH_TAG_CITY = "nvTerritory_all"
cityOverlayBbox = nil
cityOverlayVisible = false
cityOverlayName = nil
cityOverlayRetryCount = 0
cityBatchData = nil
BATCH_TAG_NORTH = "nvTerritory_all_north"
northOverlayBbox = nil
northOverlayVisible = false
northOverlayName = nil
northOverlayRetryCount = 0
northBatchData = nil


playerGroup = nil


RegisterNetEvent("esx:setGroup", function(group)
    playerGroup = group
end)


function IsPlayerAdmin(group)
    if not group then
        return false
    end

    local adminGroups = Config.AdminGroups or {}
    local groupLower = tostring(group):lower()

    for _, adminGroup in ipairs(adminGroups) do
        if tostring(adminGroup):lower() == groupLower then
            return true
        end
    end

    return false
end


local lastPermissionCheck = 0
local canSeeMap = true
local permissionCheckInterval = 5000
local allTerritories = {}
local lastTerritoriesUpdate = 0
local territoriesUpdateInterval = 10000
local lastCursorPosition = {x = 0, y = 0}
local hoveredTerritory = nil
local cursorMovementThreshold = 50.0
local territoryTooltipCache = {}
local citizenForceShowTerritories = false

exports('ToggleCitizenTerritories', function(state)
    citizenForceShowTerritories = state
    if state then
        TriggerEvent("nvTerritory:reloadTerritories")
    end
end)

exports('GetCitizenTerritoriesState', function()
    return citizenForceShowTerritories
end)

function IsPointInPolygon(x, y, polygon)
    if not polygon or #polygon < 3 then
        return false
    end
    local inside = false
    local count = #polygon
    local j = count

    for i = 1, count do
        local xi, yi = polygon[i].x, polygon[i].y
        local xj, yj = polygon[j].x, polygon[j].y

        local intersect = ((yi > y) ~= (yj > y)) and (x < (xj - xi) * (y - yi) / (yj - yi) + xi)
        if intersect then
            inside = not inside
        end

        j = i
    end

    return inside
end


function GetCursorMapCoordinates()
    local coords = Citizen.InvokeNative(0xE5E0CF92, Citizen.ResultAsVector())

    if coords then
        local x = coords.x or coords[1]
        local y = coords.y or coords[2]

        if x and y then
            return x + 0.0, y + 0.0
        end
    end

    return nil, nil
end


function CheckMapVisibility(callback)
    if citizenForceShowTerritories then
        callback(true)
        return
    end

    local whoCanSee = tostring(Config.WhoCanSee or "everyone"):lower()

    if whoCanSee == "everyone" then
        callback(true)
    elseif whoCanSee == "crews" then
        local done = false
        local hasCrew = false

        ESX.TriggerServerCallback("GetCrewPly", function(crewData)
            hasCrew = not crewData
            done = true
        end)

        local timeout = 3000
        while not done and timeout > 0 do
            Wait(50)
            timeout = timeout - 50
        end

        callback(hasCrew)
    elseif whoCanSee == "admin" then
        local done = false
        local group = nil

        local playerData = ESX.GetPlayerData and ESX.GetPlayerData() or nil
        if playerData and playerData.group then
            group = playerData.group
        end

        if not group and playerGroup == nil then
            done = false
            ESX.TriggerServerCallback("nvTerritory:getPlayerGroup", function(serverGroup)
                playerGroup = serverGroup
                done = true
            end)

            local timeout = 1000
            while not done and timeout > 0 do
                Wait(50)
                timeout = timeout - 50
            end
        end

        group = playerGroup
        callback(IsPlayerAdmin(group))
    else
        callback(true)
    end
end

CreateThread(function()
    while true do
        Wait(100)

        local inventoryOpen = false
        if Config.Inventory == "ox" then
            local state = GetResourceState("ox_inventory")
            if state == "started" then
                local success, isOpen = pcall(function()
                    return exports.ox_inventory:isOpen()
                end)
                if success and isOpen then
                    inventoryOpen = true
                end
            end
        end

        local isPauseActive = IsPauseMenuActive()

        if not isPauseActive then
            SendNUIMessage({
                action = "tooltip",
                show = false
            })
            goto continue
        end

        if not Config.Map or Config.Map.ShowTooltip == false or inventoryOpen then
            SendNUIMessage({
                action = "tooltip",
                show = false
            })
            goto continue
        end

        local currentTime = GetGameTimer()
        if currentTime - lastPermissionCheck > permissionCheckInterval then
            CheckMapVisibility(function(canSee)
                canSeeMap = canSee
                lastPermissionCheck = currentTime
            end)
            Wait(100)
        end

        if not canSeeMap then
            SendNUIMessage({
                action = "tooltip",
                show = false
            })
        else
            local cursorX, cursorY = GetCursorMapCoordinates()

            if cursorX and cursorY then
                lastCursorPosition.x = cursorX
                lastCursorPosition.y = cursorY

                local foundTerritory = nil

                if currentTime - lastTerritoriesUpdate > territoriesUpdateInterval then
                    local done = false
                    ESX.TriggerServerCallback("nvTerritory:getAllTerritories", function(territories)
                        allTerritories = territories or {}
                        done = true
                    end)

                    local timeout = 1000
                    while not done and timeout > 0 do
                        Wait(50)
                        timeout = timeout - 50
                    end

                    lastTerritoriesUpdate = currentTime
                end

                for i = 1, #allTerritories do
                    local territory = allTerritories[i]
                    if territory and territory.points and #territory.points >= 3 then
                        if IsPointInPolygon(cursorX, cursorY, territory.points) then
                            foundTerritory = territory
                            break
                        end
                    end
                end

                hoveredTerritory = foundTerritory

                if hoveredTerritory then
                    local cacheKey = hoveredTerritory.name .. "_" .. (hoveredTerritory.id or "")
                    local tooltipData = territoryTooltipCache[cacheKey]

                    if not tooltipData then
                        local frequentation = hoveredTerritory.frequentation or "normale"
                        local competition = nil
                        local controlled = false
                        local crewName = nil
                        local crewDevise = nil

                        local stateData = territoryStateCache[hoveredTerritory.name]
                        if stateData then
                            competition = stateData.competition
                            controlled = stateData.controlled == true
                            crewName = stateData.crewName
                            crewDevise = stateData.crewDevise
                        end

                        local competitionThresholds = (Config.Map and Config.Map.Competition) or {
                            LowMax = 1,
                            NormalMax = 4
                        }

                        local description = hoveredTerritory.description or ""
                        if hoveredTerritory.id and _U then
                            local descKey = string.format("territory_desc_%s", tostring(hoveredTerritory.id))
                            local translated = _U(descKey)
                            if type(translated) == "string" then
                                description = translated
                            end
                        end

                        tooltipData = {
                            id = hoveredTerritory.id or "",
                            name = hoveredTerritory.name,
                            description = description,
                            frequentation = tostring(frequentation),
                            isControlled = controlled,
                            competition = competition,
                            crewName = crewName,
                            crewDevise = crewDevise,
                            competitionThresholds = {
                                low = competitionThresholds.LowMax,
                                normal = competitionThresholds.NormalMax
                            },
                            labels = {
                                frequentation = (_U and _U("tooltip_frequentation")) or "Fréquentation",
                                competition = (_U and _U("tooltip_competition")) or "Concurrence",
                                levelLow = (_U and _U("level_low")) or "Faible",
                                levelNormal = (_U and _U("level_normal")) or "Normal",
                                levelHigh = (_U and _U("level_high")) or "Forte",
                                none = (_U and _U("none")) or "Aucune",
                                crewLeader = (_U and _U("tooltip_crew_leader")) or "Crew Leader"
                            }
                        }

                        territoryTooltipCache[cacheKey] = tooltipData
                    end

                    local message = {action = "tooltip", show = true}
                    for k, v in pairs(tooltipData) do
                        message[k] = v
                    end

                    SendNUIMessage(message)
                else
                    SendNUIMessage({
                        action = "tooltip",
                        show = false
                    })
                end
            else
                SendNUIMessage({
                    action = "tooltip",
                    show = false
                })
            end
        end

        ::continue::
    end
end)


function CalculateBoundingBox(points)
    local minX = math.huge
    local minY = math.huge
    local maxX = -math.huge
    local maxY = -math.huge

    for i = 1, #points do
        local point = points[i]
        if point.x < minX then minX = point.x end
        if point.x > maxX then maxX = point.x end
        if point.y < minY then minY = point.y end
        if point.y > maxY then maxY = point.y end
    end

    return minX, minY, maxX, maxY
end


function ParseHexColor(hexStr, fallback)
    if type(hexStr) ~= "string" then
        return fallback
    end

    local hex = hexStr:gsub("#", "")
    if #hex ~= 6 then
        return fallback
    end

    local r = tonumber(hex:sub(1, 2), 16) or fallback.r
    local g = tonumber(hex:sub(3, 4), 16) or fallback.g
    local b = tonumber(hex:sub(5, 6), 16) or fallback.b

    return {r = r, g = g, b = b, a = fallback.a}
end


function GeneratePolygonDrawJSON(territory, canvasWidth, canvasHeight, minX, minY, maxX, maxY, isControlled, color, crewName)
    local freeColor = (Config.Map and Config.Map.FreeColor) or {r = 80, g = 180, b = 255}
    local freeOpacity = tonumber((Config.Map and Config.Map.FreeOpacity)) or 0.35
    local controlledOpacity = tonumber((Config.Map and Config.Map.ControlledOpacity)) or 0.35

    local fillColor
    if isControlled then
        fillColor = ParseHexColor(color, {r = 220, g = 30, b = 30, a = controlledOpacity})
        fillColor.a = controlledOpacity
    else
        fillColor = {
            r = tonumber(freeColor.r) or 80,
            g = tonumber(freeColor.g) or 180,
            b = tonumber(freeColor.b) or 255,
            a = freeOpacity
        }
    end

    local crewLogo = crewName and crewName:gsub("%s+", "_"):lower() .. ".webp" or nil
    local crewLogoRaw = crewName and crewName .. ".webp" or nil

    return json.encode({
        action = "drawPolygon",
        name = territory.name,
        width = canvasWidth,
        height = canvasHeight,
        bbox = {
            minX = minX,
            minY = minY,
            maxX = maxX,
            maxY = maxY
        },
        points = territory.points,
        controlled = isControlled == true,
        fill = fillColor,
        stroke = {r = 255, g = 255, b = 255, a = 0.9, width = 2},
        crewName = crewName,
        crewLogo = crewLogo,
        crewLogoRaw = crewLogoRaw,
        showLogo = Config.Showlogo ~= false
    })
end


function CalculateGlobalBoundingBox(territories)
    local minX = math.huge
    local minY = math.huge
    local maxX = -math.huge
    local maxY = -math.huge

    for i = 1, #territories do
        local territory = territories[i]
        if territory and territory.points then
            local tMinX, tMinY, tMaxX, tMaxY = CalculateBoundingBox(territory.points)
            if tMinX < minX then minX = tMinX end
            if tMinY < minY then minY = tMinY end
            if tMaxX > maxX then maxX = tMaxX end
            if tMaxY > maxY then maxY = tMaxY end
        end
    end

    if minX == math.huge then
        return -3000.0, -3000.0, 3000.0, 3000.0
    end

    local paddingX = math.max(50.0, (maxX - minX) * 0.02)
    local paddingY = math.max(50.0, (maxY - minY) * 0.02)

    return minX - paddingX, minY - paddingY, maxX + paddingX, maxY + paddingY
end


function ParseHexColorWithOpacity(hexStr, opacity)
    local fallback = {r = 220, g = 30, b = 30, a = opacity}

    if type(hexStr) ~= "string" then
        return fallback
    end

    local hex = hexStr:gsub("#", "")
    if #hex ~= 6 then
        return fallback
    end

    local r = tonumber(hex:sub(1, 2), 16) or fallback.r
    local g = tonumber(hex:sub(3, 4), 16) or fallback.g
    local b = tonumber(hex:sub(5, 6), 16) or fallback.b

    return {r = r, g = g, b = b, a = opacity}
end


function PrepareBatchPolygons(territories, stateData)
    local minX, minY, maxX, maxY = CalculateGlobalBoundingBox(territories)

    local width = math.max(0.1, maxX - minX)
    local height = math.max(0.1, maxY - minY)

    local canvasSize = 2048
    local canvasWidth, canvasHeight

    if width >= height then
        canvasWidth = canvasSize
        canvasHeight = math.max(256, math.floor(canvasSize * (height / width)))
    else
        canvasHeight = canvasSize
        canvasWidth = math.max(256, math.floor(canvasSize * (width / height)))
    end

    local freeColor = (Config.Map and Config.Map.FreeColor) or {r = 80, g = 180, b = 255}
    local freeOpacity = tonumber((Config.Map and Config.Map.FreeOpacity)) or 0.35
    local controlledOpacity = tonumber((Config.Map and Config.Map.ControlledOpacity)) or 0.35

    local polygons = {}

    for i = 1, #territories do
        local territory = territories[i]
        if territory and territory.points and #territory.points >= 3 then
            local state = stateData and stateData[territory.name]

            local isControlled = false
            local color = nil
            local crewName = nil

            if type(state) == "table" then
                isControlled = state.controlled == true or state.controlled == 1 or state.controlled == "true"
                color = state.color
                crewName = state.crewName
            elseif state ~= nil then
                isControlled = state == true or state == 1 or state == "true"
            end

            local fillColor
            if isControlled then
                fillColor = ParseHexColorWithOpacity(color, controlledOpacity)
            else
                fillColor = {
                    r = tonumber(freeColor.r) or 80,
                    g = tonumber(freeColor.g) or 180,
                    b = tonumber(freeColor.b) or 255,
                    a = freeOpacity
                }
            end

            local crewDevise = (type(state) == "table") and state.crewDevise or nil

            local crewLogo = crewName and crewName:gsub("%s+", "_"):lower() .. ".webp" or nil
            local crewLogoRaw = crewName and crewName .. ".webp" or nil

            table.insert(polygons, {
                id = territory.id,
                name = territory.name,
                points = territory.points,
                controlled = isControlled,
                fill = fillColor,
                stroke = {r = 255, g = 255, b = 255, a = 0.9, width = 2},
                crewName = crewName,
                crewLogo = crewLogo,
                crewLogoRaw = crewLogoRaw,
                showLogo = Config.Showlogo ~= false
            })

            territoryStateCache[territory.name] = territoryStateCache[territory.name] or {}
            territoryStateCache[territory.name].controlled = isControlled
            territoryStateCache[territory.name].color = color
            territoryStateCache[territory.name].competition = (type(state) == "table") and state.competition or nil
            territoryStateCache[territory.name].crewName = crewName
            territoryStateCache[territory.name].crewDevise = crewDevise
        end
    end

    local batchData = {
        action = "drawPolygons",
        name = "nvTerritoryBatch",
        width = canvasWidth,
        height = canvasHeight,
        bbox = {
            minX = minX,
            minY = minY,
            maxX = maxX,
            maxY = maxY
        },
        polygons = polygons,
        logo = {
            opacity = tonumber((Config.Map and Config.Map.LogoOpacity)) or 0.95,
            size = tonumber((Config.Map and Config.Map.LogoSize)) or 5
        }
    }

    return batchData, minX, minY, maxX, maxY
end


function DrawCityBatchOverlay(batchData, minX, minY, maxX, maxY, shouldShow)
    local resourceName = GetCurrentResourceName()
    local duiUrl = string.format("nui://%s/html/index.html", resourceName)

    local width = batchData.width
    local height = batchData.height

    if not cityBatchDui then
        cityBatchDui = CreateDui(duiUrl, width, height)
        if not cityBatchDui then
            print("[nvTerritory:cl_map] DUI creation failed for batch")
            return false
        end
    end

    batchData.name = batchData.name or "nvTerritoryBatch_city"
    batchData.zone = "city"

    local encodedData = json.encode(batchData)

    local polyCount = (batchData.polygons and #batchData.polygons) or 0
    local consoleMsg = json.encode({
        action = "console",
        message = string.format("BATCH SEND zone=city %dx%d polys=%d", batchData.width, batchData.height, polyCount)
    })
    SendDuiMessage(cityBatchDui, consoleMsg)

    for i = 1, 4 do
        SendDuiMessage(cityBatchDui, encodedData)
        Wait(200)
    end

    Wait(1000)

    cityOverlayBbox = {minX = minX, minY = minY, maxX = maxX, maxY = maxY}
    cityOverlayName = string.format("territories_batch_%d", overlayBatchId)
    cityBatchData = batchData
    cityOverlayRetryCount = 0

    shouldShow = shouldShow ~= false

    if not shouldShow then
        if exports[resourceName] and exports[resourceName].removeCustomOverlayByTag then
            exports[resourceName]:removeCustomOverlayByTag(BATCH_TAG_CITY)
        end
        return true
    end

    local duiHandle = GetDuiHandle(cityBatchDui)
    local centerX = (minX + maxX) / 2.0
    local centerY = (minY + maxY) / 2.0
    local spanX = maxX - minX
    local spanY = maxY - minY

    if exports[resourceName] and exports[resourceName].isOverlayReady and exports[resourceName].addOverlaySpriteFromDuiHandle then
        if exports[resourceName]:isOverlayReady() then
            local success = exports[resourceName]:addOverlaySpriteFromDuiHandle(
                duiHandle,
                OVERLAY_TXD,
                cityOverlayName,
                centerX,
                centerY,
                spanX,
                spanY,
                100,
                true,
                0.0,
                BATCH_TAG_CITY
            )

            if not success then
                cityOverlayRetryCount = cityOverlayRetryCount + 1

                if cityOverlayRetryCount % 3 == 0 and cityBatchData then
                    local reEncoded = json.encode(cityBatchData)
                    for i = 1, 3 do
                        SendDuiMessage(cityBatchDui, reEncoded)
                        Wait(250)
                    end
                    Wait(500)
                end

                if cityOverlayRetryCount >= 10 and cityBatchData then
                    cityOverlayRetryCount = 0
                    pcall(function() DestroyDui(cityBatchDui) end)
                    cityBatchDui = nil

                    local newDui = CreateDui(duiUrl, cityBatchData.width, cityBatchData.height)
                    cityBatchDui = newDui

                    if cityBatchDui then
                        local reEncoded = json.encode(cityBatchData)
                        for i = 1, 4 do
                            SendDuiMessage(cityBatchDui, reEncoded)
                            Wait(250)
                        end
                        Wait(1500)

                        duiHandle = GetDuiHandle(cityBatchDui)
                        success = exports[resourceName]:addOverlaySpriteFromDuiHandle(
                            duiHandle,
                            OVERLAY_TXD,
                            cityOverlayName,
                            centerX,
                            centerY,
                            spanX,
                            spanY,
                            100,
                            true,
                            0.0,
                            BATCH_TAG_CITY
                        )
                    end
                end

                if not success then
                    print("[nvTerritory:cl_map] addOverlaySpriteFromDuiHandle failed for batch (temp)")
                    return false
                end
            end

            return true
        end
    else
        print("[nvTerritory:cl_map] overlay exports not found")
    end

    return false
end


function RefreshCityOverlay()
    if not cityOverlayBbox or not cityBatchDui then
        return false
    end

    local minX = cityOverlayBbox.minX
    local minY = cityOverlayBbox.minY
    local maxX = cityOverlayBbox.maxX
    local maxY = cityOverlayBbox.maxY

    local duiHandle = GetDuiHandle(cityBatchDui)
    local centerX = (minX + maxX) / 2.0
    local centerY = (minY + maxY) / 2.0
    local spanX = maxX - minX
    local spanY = maxY - minY

    local resourceName = GetCurrentResourceName()
    if exports[resourceName] and exports[resourceName].isOverlayReady and exports[resourceName].addOverlaySpriteFromDuiHandle then
        if exports[resourceName]:isOverlayReady() then
            local success = exports[resourceName]:addOverlaySpriteFromDuiHandle(
                duiHandle,
                OVERLAY_TXD,
                cityOverlayName,
                centerX,
                centerY,
                spanX,
                spanY,
                100,
                true,
                0.0,
                BATCH_TAG_CITY
            )

            if not success and cityBatchData then
                local reEncoded = json.encode(cityBatchData)
                for i = 1, 2 do
                    SendDuiMessage(cityBatchDui, reEncoded)
                    Wait(200)
                end
                Wait(600)

                success = exports[resourceName]:addOverlaySpriteFromDuiHandle(
                    duiHandle,
                    OVERLAY_TXD,
                    cityOverlayName,
                    centerX,
                    centerY,
                    spanX,
                    spanY,
                    100,
                    true,
                    0.0,
                    BATCH_TAG_CITY
                )
            end

            return success == true
        end
    end

    return false
end


function ToggleCityOverlay(show)
    if show then
        if RefreshCityOverlay() then
            cityOverlayVisible = true
        else
            cityOverlayVisible = false
        end
    else
        if cityOverlayVisible then
            local resourceName = GetCurrentResourceName()
            if exports[resourceName] and exports[resourceName].removeCustomOverlayByTag then
                exports[resourceName]:removeCustomOverlayByTag(BATCH_TAG_CITY)
            end
            cityOverlayVisible = false
        end
    end
end


function DrawNorthBatchOverlay(batchData, minX, minY, maxX, maxY, shouldShow)
    local resourceName = GetCurrentResourceName()
    local duiUrl = string.format("nui://%s/html/index.html", resourceName)

    local width = batchData.width
    local height = batchData.height

    if not northBatchDui then
        northBatchDui = CreateDui(duiUrl, width, height)
        if not northBatchDui then
            print("[nvTerritory:cl_map] DUI creation failed for batch NORTH")
            return false
        end
    end

    batchData.name = batchData.name or "nvTerritoryBatch_north"
    batchData.zone = "north"

    local encodedData = json.encode(batchData)

    local polyCount = (batchData.polygons and #batchData.polygons) or 0
    local consoleMsg = json.encode({
        action = "console",
        message = string.format("BATCH SEND zone=north %dx%d polys=%d", batchData.width, batchData.height, polyCount)
    })
    SendDuiMessage(northBatchDui, consoleMsg)

    for i = 1, 4 do
        SendDuiMessage(northBatchDui, encodedData)
        Wait(200)
    end

    Wait(1000)

    northOverlayBbox = {minX = minX, minY = minY, maxX = maxX, maxY = maxY}
    northOverlayName = string.format("territories_batch_north_%d", overlayBatchId)
    northBatchData = batchData
    northOverlayRetryCount = 0

    shouldShow = shouldShow ~= false

    if not shouldShow then
        if exports[resourceName] and exports[resourceName].removeCustomOverlayByTag then
            exports[resourceName]:removeCustomOverlayByTag(BATCH_TAG_NORTH)
        end
        return true
    end

    local duiHandle = GetDuiHandle(northBatchDui)
    local centerX = (minX + maxX) / 2.0
    local centerY = (minY + maxY) / 2.0
    local spanX = maxX - minX
    local spanY = maxY - minY

    if exports[resourceName] and exports[resourceName].isOverlayReady and exports[resourceName].addOverlaySpriteFromDuiHandle then
        if exports[resourceName]:isOverlayReady() then
            local success = exports[resourceName]:addOverlaySpriteFromDuiHandle(
                duiHandle,
                OVERLAY_TXD,
                northOverlayName,
                centerX,
                centerY,
                spanX,
                spanY,
                100,
                true,
                0.0,
                BATCH_TAG_NORTH
            )

            if not success then
                northOverlayRetryCount = northOverlayRetryCount + 1

                if northOverlayRetryCount % 3 == 0 and northBatchData then
                    local reEncoded = json.encode(northBatchData)
                    for i = 1, 3 do
                        SendDuiMessage(northBatchDui, reEncoded)
                        Wait(250)
                    end
                    Wait(500)
                end

                if northOverlayRetryCount >= 10 and northBatchData then
                    northOverlayRetryCount = 0
                    pcall(function() DestroyDui(northBatchDui) end)
                    northBatchDui = nil

                    local newDui = CreateDui(duiUrl, northBatchData.width, northBatchData.height)
                    northBatchDui = newDui

                    if northBatchDui then
                        local reEncoded = json.encode(northBatchData)
                        for i = 1, 4 do
                            SendDuiMessage(northBatchDui, reEncoded)
                            Wait(250)
                        end
                        Wait(1500)

                        duiHandle = GetDuiHandle(northBatchDui)
                        success = exports[resourceName]:addOverlaySpriteFromDuiHandle(
                            duiHandle,
                            OVERLAY_TXD,
                            northOverlayName,
                            centerX,
                            centerY,
                            spanX,
                            spanY,
                            100,
                            true,
                            0.0,
                            BATCH_TAG_NORTH
                        )
                    end
                end

                if not success then
                    print("[nvTerritory:cl_map] addOverlaySpriteFromDuiHandle failed for batch NORTH (temp)")
                    return false
                end
            end

            return true
        end
    else
        print("[nvTerritory:cl_map] overlay exports not found")
    end

    return false
end


function RefreshNorthOverlay()
    if not northOverlayBbox or not northBatchDui then
        return false
    end

    local minX = northOverlayBbox.minX
    local minY = northOverlayBbox.minY
    local maxX = northOverlayBbox.maxX
    local maxY = northOverlayBbox.maxY

    local duiHandle = GetDuiHandle(northBatchDui)
    local centerX = (minX + maxX) / 2.0
    local centerY = (minY + maxY) / 2.0
    local spanX = maxX - minX
    local spanY = maxY - minY

    local resourceName = GetCurrentResourceName()
    if exports[resourceName] and exports[resourceName].isOverlayReady and exports[resourceName].addOverlaySpriteFromDuiHandle then
        if exports[resourceName]:isOverlayReady() then
            local success = exports[resourceName]:addOverlaySpriteFromDuiHandle(
                duiHandle,
                OVERLAY_TXD,
                northOverlayName,
                centerX,
                centerY,
                spanX,
                spanY,
                100,
                true,
                0.0,
                BATCH_TAG_NORTH
            )

            if not success and northBatchData then
                local reEncoded = json.encode(northBatchData)
                for i = 1, 2 do
                    SendDuiMessage(northBatchDui, reEncoded)
                    Wait(200)
                end
                Wait(600)

                success = exports[resourceName]:addOverlaySpriteFromDuiHandle(
                    duiHandle,
                    OVERLAY_TXD,
                    northOverlayName,
                    centerX,
                    centerY,
                    spanX,
                    spanY,
                    100,
                    true,
                    0.0,
                    BATCH_TAG_NORTH
                )
            end

            return success == true
        end
    end

    return false
end


function ToggleNorthOverlay(show)
    if show then
        if RefreshNorthOverlay() then
            northOverlayVisible = true
        else
            northOverlayVisible = false
        end
    else
        if northOverlayVisible then
            local resourceName = GetCurrentResourceName()
            if exports[resourceName] and exports[resourceName].removeCustomOverlayByTag then
                exports[resourceName]:removeCustomOverlayByTag(BATCH_TAG_NORTH)
            end
            northOverlayVisible = false
        end
    end
end


function DrawIndividualTerritory(territory, territoryId, isControlled, color, crewName)
    local minX, minY, maxX, maxY = CalculateBoundingBox(territory.points)

    local width = math.max(0.1, maxX - minX)
    local height = math.max(0.1, maxY - minY)

    local canvasSize = 1024
    local canvasWidth, canvasHeight

    if width >= height then
        canvasWidth = canvasSize
        canvasHeight = math.max(64, math.floor(canvasSize * (height / width)))
    else
        canvasHeight = canvasSize
        canvasWidth = math.max(64, math.floor(canvasSize * (width / height)))
    end

    local paddingX = math.max(1.0, width * 0.01)
    local paddingY = math.max(1.0, height * 0.01)

    minX = minX - paddingX
    maxX = maxX + paddingX
    minY = minY - paddingY
    maxY = maxY + paddingY

    width = maxX - minX
    height = maxY - minY

    local resourceName = GetCurrentResourceName()
    local duiUrl = string.format("nui://%s/html/index.html", resourceName)
    local dui = CreateDui(duiUrl, canvasWidth, canvasHeight)

    if not dui then
        print(string.format("[nvTerritory:cl_map] DUI creation failed for '%s'", territory.name))
        return
    end

    local duiHandle = GetDuiHandle(dui)
    local overlayName = string.format("territory_%d_%d", territoryId, overlayBatchId)

    local drawJson = GeneratePolygonDrawJSON(territory, canvasWidth, canvasHeight, minX, minY, maxX, maxY, isControlled, color, crewName)

    for i = 1, 6 do
        SendDuiMessage(dui, drawJson)

        if i == 1 then
            local consoleMsg = json.encode({
                action = "console",
                message = string.format("drawPolygon sent %s %dx%d (attempt %d)", territory.name, canvasWidth, canvasHeight, i)
            })
            SendDuiMessage(dui, consoleMsg)
        end

        Wait(300)
    end

    local finalConsole = json.encode({
        action = "console",
        message = string.format("draw sent %s %dx%d", territory.name, canvasWidth, canvasHeight)
    })
    SendDuiMessage(dui, finalConsole)

    Wait(1500)

    local centerX = (minX + maxX) / 2.0
    local centerY = (minY + maxY) / 2.0

    local success = false

    if exports[resourceName] and exports[resourceName].isOverlayReady and exports[resourceName].addOverlaySpriteFromDuiHandle then
        if exports[resourceName]:isOverlayReady() then
            local tagName = territory.name

            if exports[resourceName].removeCustomOverlayByTag then
                exports[resourceName]:removeCustomOverlayByTag(tagName)
            end

            for attempt = 1, 20 do
                success = exports[resourceName]:addOverlaySpriteFromDuiHandle(
                    duiHandle,
                    OVERLAY_TXD,
                    overlayName,
                    centerX,
                    centerY,
                    width,
                    height,
                    100,
                    true,
                    0.0,
                    tagName
                )

                if success then
                    break
                end

                Wait(500)
            end
        end
    else
        print("[nvTerritory:cl_map] overlay exports not found")
    end

    territoryDuis[territoryId] = {
        dui = dui,
        txd = OVERLAY_TXD,
        txn = overlayName,
        tag = territory.name,
        name = territory.name
    }
end


function BuildMapOverlays()
    if not Config.Showmap then
        if not mapInitialized then
            print("[nvTerritory:cl_map] Config.Showmap=false, skip building map overlays")
            mapInitialized = true
        end
        return
    end

    local timeout = 0
    while true do
        local resourceName = GetCurrentResourceName()
        if exports[resourceName] and exports[resourceName].isOverlayReady and exports[resourceName]:isOverlayReady() then
            break
        end
        Wait(100)
        timeout = timeout + 100
        if timeout > 20000 then
            break
        end
    end

    local territories = {}
    local done = false
    ESX.TriggerServerCallback("nvTerritory:getAllTerritories", function(data)
        territories = data or {}
        done = true
    end)

    local wait = 3000
    while not done and wait > 0 do
        Wait(50)
        wait = wait - 50
    end

    local territoryStates = {}
    done = false
    ESX.TriggerServerCallback("Territories:StatusWithColor", function(data)
        territoryStates = data or {}
        done = true
    end)

    wait = 3000
    while not done and wait > 0 do
        Wait(50)
        wait = wait - 50
    end

    if not mapInitialized then
        local resourceName = GetCurrentResourceName()
        if exports[resourceName] and exports[resourceName].isOverlayReady and exports[resourceName]:isOverlayReady() then

        end
        mapInitialized = true
    end

    local northBoundary = 1800.0
    local cityTerritories = {}
    local northTerritories = {}

    for i = 1, #territories do
        local territory = territories[i]
        if territory and territory.points and #territory.points >= 3 then
            local minX, minY, maxX, maxY = CalculateBoundingBox(territory.points)
            local midY = (minY + maxY) / 2.0

            if midY <= northBoundary then
                table.insert(northTerritories, territory)
            else
                table.insert(cityTerritories, territory)
            end
        end
    end

    if #cityTerritories > 0 then
        local batchData, minX, minY, maxX, maxY = PrepareBatchPolygons(cityTerritories, territoryStates)
        DrawCityBatchOverlay(batchData, minX, minY, maxX, maxY, false)
        Wait(300)
    end

    if #northTerritories > 0 then
        local batchData, minX, minY, maxX, maxY = PrepareBatchPolygons(northTerritories, territoryStates)
        DrawNorthBatchOverlay(batchData, minX, minY, maxX, maxY, false)
    end

    CreateThread(function()
        Wait(1000)

        if cityBatchData and cityBatchDui then
            local consoleMsg = json.encode({
                action = "console",
                message = string.format("BATCH RESEND zone=city %dx%d polys=%d",
                    cityBatchData.width or 0,
                    cityBatchData.height or 0,
                    (cityBatchData.polygons and #cityBatchData.polygons) or 0)
            })
            SendDuiMessage(cityBatchDui, consoleMsg)

            local reEncoded = json.encode(cityBatchData)
            for i = 1, 2 do
                SendDuiMessage(cityBatchDui, reEncoded)
                Wait(200)
            end
        end

        if northBatchData and northBatchDui then
            local consoleMsg = json.encode({
                action = "console",
                message = string.format("BATCH RESEND zone=north %dx%d polys=%d",
                    northBatchData.width or 0,
                    northBatchData.height or 0,
                    (northBatchData.polygons and #northBatchData.polygons) or 0)
            })
            SendDuiMessage(northBatchDui, consoleMsg)

            local reEncoded = json.encode(northBatchData)
            for i = 1, 2 do
                SendDuiMessage(northBatchDui, reEncoded)
                Wait(200)
            end
        end
    end)

    local showOnMinimap = Config.Map and Config.Map.ShowOnMinimap == true
    ToggleCityOverlay(showOnMinimap)
    ToggleNorthOverlay(showOnMinimap)
end


CreateThread(function()
    while true do
        if not ESX.IsPlayerLoaded() then
            Wait(250)
        else
            break
        end
    end

    Wait(2000)
    Wait(1200)

    local resourceName = GetCurrentResourceName()
    local pingDui = CreateDui(string.format("nui://%s/html/index.html", resourceName), 64, 64)
    if pingDui then
        SendDuiMessage(pingDui, json.encode({action = "ping"}))
        DestroyDui(pingDui)
    end

    if exports[resourceName] and exports[resourceName].clearCustomOverlays then
        exports[resourceName]:clearCustomOverlays()
        Wait(100)
    end

    overlayBatchId = overlayBatchId + 1

    local whoCanSee = tostring(Config.WhoCanSee or "everyone"):lower()

    local function buildMap()
        BuildMapOverlays()
    end

    if whoCanSee == "everyone" then
        buildMap()
    elseif whoCanSee == "crews" then
        local done = false
        local hasCrew = false

        ESX.TriggerServerCallback("GetCrewPly", function(crewData)
            hasCrew = not crewData
            done = true
        end)

        local wait = 3000
        while not done and wait > 0 do
            Wait(50)
            wait = wait - 50
        end

        if hasCrew then
            buildMap()
        end
    elseif whoCanSee == "admin" then
        local done = false
        local group = nil

        local playerData = ESX.GetPlayerData and ESX.GetPlayerData() or nil
        if playerData and playerData.group then
            group = playerData.group
        end

        if not group and playerGroup == nil then
            done = false
            ESX.TriggerServerCallback("nvTerritory:getPlayerGroup", function(serverGroup)
                playerGroup = serverGroup
                done = true
            end)

            local wait = 1000
            while not done and wait > 0 do
                Wait(50)
                wait = wait - 50
            end
        end

        group = playerGroup
        if group then
            group = tostring(group):lower()
        end

        if IsPlayerAdmin(group) then
            buildMap()
        end
    else
        buildMap()
    end
end)


CreateThread(function()
    while true do
        Wait(500)

        if not Config.Showmap then
            ToggleCityOverlay(false)
            ToggleNorthOverlay(false)
        else
            local currentTime = GetGameTimer()
            if currentTime - lastPermissionCheck > permissionCheckInterval then
                CheckMapVisibility(function(canSee)
                    canSeeMap = canSee
                    lastPermissionCheck = currentTime
                end)
                Wait(100)
            end

            if canSeeMap then
                local showOnMinimap = Config.Map and Config.Map.ShowOnMinimap == true

                if IsPauseMenuActive() and not Config.Showmap then
                    showOnMinimap = false
                end

                ToggleCityOverlay(showOnMinimap)
                ToggleNorthOverlay(showOnMinimap)
            else
                ToggleCityOverlay(false)
                ToggleNorthOverlay(false)
            end
        end
    end
end)


RegisterNetEvent("nvTerritory:reloadTerritories", function()
    TriggerEvent("nvTerritory:territoriesUpdated")
end)

RegisterNetEvent("nvTerritory:territoriesUpdated", function()
    local currentTime = GetGameTimer()
    if currentTime - lastPermissionCheck > permissionCheckInterval then
        CheckMapVisibility(function(canSee)
            canSeeMap = canSee
            lastPermissionCheck = currentTime
        end)
        Wait(100)
    end

    if not canSeeMap then
        return
    end

    overlayBatchId = overlayBatchId + 1

    local territoryStates = nil
    local done = false
    ESX.TriggerServerCallback("Territories:StatusWithColor", function(data)
        territoryStates = data or {}
        done = true
    end)

    local wait = 3000
    while not done and wait > 0 do
        Wait(100)
        wait = wait - 100
    end

    local territories = {}
    done = false
    ESX.TriggerServerCallback("nvTerritory:getAllTerritories", function(data)
        territories = data or {}
        done = true
    end)

    wait = 3000
    while not done and wait > 0 do
        Wait(100)
        wait = wait - 100
    end

    if #territories > 0 then
        local northBoundary = 1800.0
        local cityTerritories = {}
        local northTerritories = {}

        for i = 1, #territories do
            local territory = territories[i]
            if territory and territory.points and #territory.points >= 3 then
                local minX, minY, maxX, maxY = CalculateBoundingBox(territory.points)
                local midY = (minY + maxY) / 2.0

                if midY <= northBoundary then
                    table.insert(northTerritories, territory)
                else
                    table.insert(cityTerritories, territory)
                end
            end
        end

        if #cityTerritories > 0 then
            local batchData, minX, minY, maxX, maxY = PrepareBatchPolygons(cityTerritories, territoryStates)
            DrawCityBatchOverlay(batchData, minX, minY, maxX, maxY, true)
        end

        if #northTerritories > 0 then
            local batchData, minX, minY, maxX, maxY = PrepareBatchPolygons(northTerritories, territoryStates)
            DrawNorthBatchOverlay(batchData, minX, minY, maxX, maxY, true)
        end

        local showOnMinimap = Config.Map and Config.Map.ShowOnMinimap == true
        ToggleCityOverlay(showOnMinimap)
        ToggleNorthOverlay(showOnMinimap)

        CreateThread(function()
            Wait(2000)

            if not cityOverlayVisible and cityBatchData and cityBatchDui then
                local consoleMsg = json.encode({
                    action = "console",
                    message = string.format("REFRESH RESEND zone=city %dx%d polys=%d",
                        cityBatchData.width or 0,
                        cityBatchData.height or 0,
                        (cityBatchData.polygons and #cityBatchData.polygons) or 0)
                })
                SendDuiMessage(cityBatchDui, consoleMsg)

                local reEncoded = json.encode(cityBatchData)
                for i = 1, 2 do
                    SendDuiMessage(cityBatchDui, reEncoded)
                    Wait(200)
                end

                ToggleCityOverlay(showOnMinimap)
            end

            if not northOverlayVisible and northBatchData and northBatchDui then
                local consoleMsg = json.encode({
                    action = "console",
                    message = string.format("REFRESH RESEND zone=north %dx%d polys=%d",
                        northBatchData.width or 0,
                        northBatchData.height or 0,
                        (northBatchData.polygons and #northBatchData.polygons) or 0)
                })
                SendDuiMessage(northBatchDui, consoleMsg)

                local reEncoded = json.encode(northBatchData)
                for i = 1, 2 do
                    SendDuiMessage(northBatchDui, reEncoded)
                    Wait(200)
                end

                ToggleNorthOverlay(showOnMinimap)
            end
        end)
    end
end)


CreateThread(function()
    while true do
        Wait(180000)

        if not Config.Showmap then
            goto continue
        end

        local currentTime = GetGameTimer()
        if currentTime - lastPermissionCheck > permissionCheckInterval then
            CheckMapVisibility(function(canSee)
                canSeeMap = canSee
                lastPermissionCheck = currentTime
            end)
            Wait(100)
        end

        if not canSeeMap then
            goto continue
        end

        local territoryStates = nil
        local done = false
        ESX.TriggerServerCallback("Territories:StatusWithColor", function(data)
            territoryStates = data or {}
            done = true
        end)

        local wait = 3000
        while not done and wait > 0 do
            Wait(100)
            wait = wait - 100
        end

        if territoryStates then
            local territories = {}
            done = false
            ESX.TriggerServerCallback("nvTerritory:getAllTerritories", function(data)
                territories = data or {}
                done = true
            end)

            wait = 3000
            while not done and wait > 0 do
                Wait(100)
                wait = wait - 100
            end

            local hasChanges = false
            for i = 1, #territories do
                local territory = territories[i]
                if territory then
                    local cached = territoryStateCache[territory.name] or {controlled = false, color = nil}
                    local current = territoryStates[territory.name]

                    local isControlled = false
                    local color = nil
                    local crewName = nil

                    if type(current) == "table" then
                        isControlled = current.controlled == true or current.controlled == 1 or current.controlled == "true"
                        color = current.color
                        crewName = current.crewName
                    end

                    local competition = (type(current) == "table") and current.competition or nil

                    if cached.controlled ~= isControlled then
                        hasChanges = true
                    end
                end

                Wait(5)
            end

            if hasChanges then
                overlayBatchId = overlayBatchId + 1

                local northBoundary = 1800.0
                local cityTerritories = {}
                local northTerritories = {}

                for i = 1, #territories do
                    local territory = territories[i]
                    if territory and territory.points and #territory.points >= 3 then
                        local minX, minY, maxX, maxY = CalculateBoundingBox(territory.points)
                        local midY = (minY + maxY) / 2.0

                        if midY <= northBoundary then
                            table.insert(northTerritories, territory)
                        else
                            table.insert(cityTerritories, territory)
                        end
                    end
                end

                if #cityTerritories > 0 then
                    local batchData, minX, minY, maxX, maxY = PrepareBatchPolygons(cityTerritories, territoryStates)
                    DrawCityBatchOverlay(batchData, minX, minY, maxX, maxY, true)
                end

                if #northTerritories > 0 then
                    local batchData, minX, minY, maxX, maxY = PrepareBatchPolygons(northTerritories, territoryStates)
                    DrawNorthBatchOverlay(batchData, minX, minY, maxX, maxY, true)
                end

                local showOnMinimap = Config.Map and Config.Map.ShowOnMinimap == true
                ToggleCityOverlay(showOnMinimap)
                ToggleNorthOverlay(showOnMinimap)

                CreateThread(function()
                    Wait(2000)

                    if not cityOverlayVisible and cityBatchData and cityBatchDui then
                        local consoleMsg = json.encode({
                            action = "console",
                            message = string.format("REFRESH RESEND zone=city %dx%d polys=%d",
                                cityBatchData.width or 0,
                                cityBatchData.height or 0,
                                (cityBatchData.polygons and #cityBatchData.polygons) or 0)
                        })
                        SendDuiMessage(cityBatchDui, consoleMsg)

                        local reEncoded = json.encode(cityBatchData)
                        for i = 1, 2 do
                            SendDuiMessage(cityBatchDui, reEncoded)
                            Wait(200)
                        end

                        ToggleCityOverlay(showOnMinimap)
                    end

                    if not northOverlayVisible and northBatchData and northBatchDui then
                        local consoleMsg = json.encode({
                            action = "console",
                            message = string.format("REFRESH RESEND zone=north %dx%d polys=%d",
                                northBatchData.width or 0,
                                northBatchData.height or 0,
                                (northBatchData.polygons and #northBatchData.polygons) or 0)
                        })
                        SendDuiMessage(northBatchDui, consoleMsg)

                        local reEncoded = json.encode(northBatchData)
                        for i = 1, 2 do
                            SendDuiMessage(northBatchDui, reEncoded)
                            Wait(200)
                        end

                        ToggleNorthOverlay(showOnMinimap)
                    end
                end)
            end
        end

        ::continue::
    end
end)


RegisterNUICallback("uiReady", function(data, cb)
    local context = (data and data.ctx) or ""
    print("[nvTerritory:UI] script.js ready", context)
    if cb then cb("ok") end
end)

RegisterNUICallback("uiLog", function(data, cb)
    if data and data.msg then
        print("[nvTerritory:UI]", data.msg)
    else
        print("[nvTerritory:UI] log (empty)")
    end
    if cb then cb("ok") end
end)


AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    for _, duiData in pairs(territoryDuis) do
        if duiData.dui then
            DestroyDui(duiData.dui)
        end
    end

    if cityBatchDui then
        pcall(function() DestroyDui(cityBatchDui) end)
        cityBatchDui = nil
    end

    if northBatchDui then
        pcall(function() DestroyDui(northBatchDui) end)
        northBatchDui = nil
    end

    territoryDuis = {}

    local resName = GetCurrentResourceName()
    if exports[resName] and exports[resName].clearCustomOverlays then
        exports[resName]:clearCustomOverlays()
    end

    territoryStateCache = {}
end)