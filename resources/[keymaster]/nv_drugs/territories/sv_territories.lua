


if Config and Config.ESXMode == "old" then
    ESX = ESX or nil
    TriggerEvent("esx:getSharedObject", function(obj)
        ESX = obj
    end)
else
    ESX = exports.es_extended:getSharedObject()
end


local territoriesFilePath = string.format("%s/territories/territories.json", GetResourcePath(GetCurrentResourceName()))


function EnsureTerritoriesFolder()
    local folderPath = territoriesFilePath:gsub("territories.json", "")
    SaveResourceFile(GetCurrentResourceName(), "territories/.keep", "", -1)
end


function LoadTerritoriesFromFile()
    local fileContent = LoadResourceFile(GetCurrentResourceName(), "territories/territories.json")

    if not fileContent or #fileContent == 0 then
        return {}
    end

    local success, territories = pcall(json.decode, fileContent)

    if not success then
        return {}
    end

    return territories or {}
end


function GetPlayerGroup(xPlayer)
    if not xPlayer then
        return nil
    end

    local group = nil

    if Config.ESXMode == "old" then
        if xPlayer.getGroup then
            group = xPlayer.getGroup()
        else
            group = xPlayer.group
        end
    else
        if xPlayer.getGroup then
            group = xPlayer.getGroup()
        else
            group = xPlayer.group
        end
    end

    if group then
        return tostring(group):lower()
    end

    return nil
end


function IsAdminGroup(group)
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


ESX.RegisterServerCallback("nvTerritory:getPlayerGroup", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(GetPlayerGroup(xPlayer))
end)


function EncodeJSON(data, indent)
    indent = indent or 0
    local indentStr = string.rep("  ", indent)
    local dataType = type(data)

    if dataType == "table" then

        local isArray = true
        local maxIndex = 0

        for key, value in pairs(data) do
            if type(key) == "number" and key >= 1 and key == math.floor(key) then
                if key > maxIndex then
                    maxIndex = key
                end
            else
                isArray = false
                break
            end
        end


        if isArray and maxIndex == #data then
            local result = "[\n"
            for i = 1, #data do
                if i > 1 then
                    result = result .. ",\n"
                end
                result = result .. indentStr .. "  " .. EncodeJSON(data[i], indent + 1)
            end
            result = result .. "\n" .. indentStr .. "]"
            return result
        else

            local isSimple = true
            local propCount = 0

            for key, value in pairs(data) do
                propCount = propCount + 1
                if propCount > 2 or type(value) == "table" then
                    isSimple = false
                    break
                end
            end


            if isSimple and propCount <= 2 then
                local result = "{"
                local first = true

                for key, value in pairs(data) do
                    if not first then
                        result = result .. ", "
                    end
                    first = false

                    if type(key) == "string" then
                        result = result .. "\"" .. key .. "\": "
                    else
                        result = result .. tostring(key) .. ": "
                    end

                    result = result .. EncodeJSON(value, 0)
                end

                result = result .. "}"
                return result
            else

                local result = "{\n"
                local first = true

                for key, value in pairs(data) do
                    if not first then
                        result = result .. ",\n"
                    end
                    first = false

                    if type(key) == "string" then
                        result = result .. indentStr .. "  \"" .. key .. "\": "
                    else
                        result = result .. indentStr .. "  " .. tostring(key) .. ": "
                    end

                    result = result .. EncodeJSON(value, indent + 1)
                end

                result = result .. "\n" .. indentStr .. "}"
                return result
            end
        end
    elseif dataType == "string" then
        local escaped = data:gsub("\"", "\\\"")
        return "\"" .. escaped .. "\""
    elseif dataType == "number" then
        return tostring(data)
    elseif dataType == "boolean" then
        return tostring(data)
    else
        return "\"" .. tostring(data) .. "\""
    end
end


function SaveTerritoriesToFile(territories)
    EnsureTerritoriesFolder()

    local jsonData = EncodeJSON(territories)
    SaveResourceFile(GetCurrentResourceName(), "territories/territories.json", jsonData or "[]", -1)

    return true
end


function GetAllTerritories()
    return LoadTerritoriesFromFile() or {}
end


ESX.RegisterServerCallback("nvTerritory:getAllTerritories", function(source, cb)
    cb(GetAllTerritories())
end)


function IsPointInPolygon(x, y, polygon)
    local inside = false
    local j = #polygon

    for i = 1, #polygon do
        local xi, yi = polygon[i].x, polygon[i].y
        local xj, yj = polygon[j].x, polygon[j].y

        if (yi < y) ~= (yj < y) then
            if x < (xj - xi) * (y - yi) / (yj - yi) + xi then
                inside = not inside
            end
        end

        j = i
    end

    return inside
end


ESX.RegisterServerCallback("nvTerritory:getPlayerTerritory", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        cb(nil)
        return
    end

    local playerPed = GetPlayerPed(source)
    local coords = GetEntityCoords(playerPed)
    local x, y = coords.x, coords.y

    local territories = LoadTerritoriesFromFile()

    if not territories then
        cb(nil)
        return
    end

    for _, territory in pairs(territories) do
        if territory.points and #territory.points >= 3 then
            if IsPointInPolygon(x, y, territory.points) then
                cb(territory.id)
                return
            end
        end
    end

    cb(nil)
end)


Citizen.CreateThread(function()
    Wait(1000)

    local territories = LoadTerritoriesFromFile()

    if territories and #territories > 0 then
        local jsonData = EncodeJSON(territories)
        if jsonData then
            SaveResourceFile(GetCurrentResourceName(), "territories/territories.json", jsonData, -1)
        end
    end
end)


RegisterServerEvent("nvTerritory:saveTerritory")
AddEventHandler("nvTerritory:saveTerritory", function(territoryData)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        TriggerClientEvent("nvTerritory:territorySaved", source, false, "Joueur non trouvé")
        return
    end

    local playerGroup = GetPlayerGroup(xPlayer)

    if not playerGroup then
        TriggerClientEvent("nvTerritory:territorySaved", source, false, "Groupe inconnu")
        return
    end

    if not IsAdminGroup(playerGroup) then
        TriggerClientEvent("nvTerritory:territorySaved", source, false, "Accès refusé (admin uniquement)")
        return
    end

    local territories = LoadTerritoriesFromFile()


    for _, territory in ipairs(territories) do
        if territory.id == territoryData.id then
            TriggerClientEvent("nvTerritory:territorySaved", source, false, "Un territoire avec cet ID existe déjà")
            return
        end
    end

    table.insert(territories, territoryData)

    local jsonData = EncodeJSON(territories)

    if jsonData then
        SaveResourceFile(GetCurrentResourceName(), "territories/territories.json", jsonData, -1)
        TriggerClientEvent("nvTerritory:territorySaved", source, true, "Territoire créé avec succès")
        TriggerClientEvent("nvTerritory:territoriesUpdated", -1, territoryData)
    else
        TriggerClientEvent("nvTerritory:territorySaved", source, false, "Erreur lors de la sauvegarde")
    end
end)


RegisterServerEvent("nvTerritory:updateTerritory")
AddEventHandler("nvTerritory:updateTerritory", function(territoryData)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        TriggerClientEvent("nvTerritory:territoryUpdated", source, false, "Joueur non trouvé")
        return
    end

    local playerGroup = GetPlayerGroup(xPlayer)

    if not playerGroup then
        TriggerClientEvent("nvTerritory:territoryUpdated", source, false, "Groupe inconnu")
        return
    end

    if not IsAdminGroup(playerGroup) then
        TriggerClientEvent("nvTerritory:territoryUpdated", source, false, "Accès refusé (admin uniquement)")
        return
    end

    local territories = LoadTerritoriesFromFile()
    local territoryIndex = nil


    for i, territory in ipairs(territories) do
        if territory.id == territoryData.originalId then
            territoryIndex = i
            break
        end
    end

    if not territoryIndex then
        TriggerClientEvent("nvTerritory:territoryUpdated", source, false, "Territoire non trouvé")
        return
    end


    for i, territory in ipairs(territories) do
        if i ~= territoryIndex and territory.id == territoryData.id then
            TriggerClientEvent("nvTerritory:territoryUpdated", source, false, "Un territoire avec cet ID existe déjà")
            return
        end
    end


    territories[territoryIndex] = {
        id = territoryData.id,
        name = territoryData.name,
        description = territoryData.description,
        frequentation = territoryData.frequentation,
        points = territoryData.points
    }

    local jsonData = EncodeJSON(territories)

    if jsonData then
        SaveResourceFile(GetCurrentResourceName(), "territories/territories.json", jsonData, -1)
        TriggerClientEvent("nvTerritory:territoryUpdated", source, true, "Territoire modifié avec succès")
        TriggerClientEvent("nvTerritory:territoriesUpdated", -1, territoryData)
    else
        TriggerClientEvent("nvTerritory:territoryUpdated", source, false, "Erreur lors de la modification")
    end
end)


RegisterServerEvent("nvTerritory:deleteTerritory")
AddEventHandler("nvTerritory:deleteTerritory", function(territoryId)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        TriggerClientEvent("nvTerritory:territoryDeleted", source, false, "Joueur non trouvé")
        return
    end

    local playerGroup = GetPlayerGroup(xPlayer)

    if not playerGroup then
        TriggerClientEvent("nvTerritory:territoryDeleted", source, false, "Groupe inconnu")
        return
    end

    if not IsAdminGroup(playerGroup) then
        TriggerClientEvent("nvTerritory:territoryDeleted", source, false, "Accès refusé (admin uniquement)")
        return
    end

    local territories = LoadTerritoriesFromFile()
    local territoryIndex = nil
    local territoryName = "Inconnu"

    for i, territory in ipairs(territories) do
        if territory.id == territoryId then
            territoryIndex = i
            territoryName = territory.name or "Inconnu"
            break
        end
    end

    if not territoryIndex then
        TriggerClientEvent("nvTerritory:territoryDeleted", source, false, "Territoire non trouvé")
        return
    end

    table.remove(territories, territoryIndex)

    local jsonData = EncodeJSON(territories)

    if jsonData then
        SaveResourceFile(GetCurrentResourceName(), "territories/territories.json", jsonData, -1)
        TriggerClientEvent("nvTerritory:territoryDeleted", source, true, "Territoire supprimé avec succès")
        TriggerClientEvent("nvTerritory:territoriesUpdated", -1, {id = territoryId, deleted = true})
    else
        TriggerClientEvent("nvTerritory:territoryDeleted", source, false, "Erreur lors de la suppression")
    end
end)


RegisterServerEvent("nvTerritory:addTerritoryPoints")
AddEventHandler("nvTerritory:addTerritoryPoints", function(crewId, territoryId, points)
    local source = source

    if not crewId or not territoryId or not points or type(points) ~= "number" then
        print("^1[nvTerritory] Erreur: Paramètres invalides pour addTerritoryPoints^0")
        return
    end

    local territories = LoadTerritoriesFromFile()
    local territoryName = nil

    for _, territory in pairs(territories) do
        if territory.id == territoryId then
            territoryName = territory.name
            break
        end
    end

    if not territoryName then
        print("^1[nvTerritory] Erreur: Territoire avec l'ID \"" .. territoryId .. "\" non trouvé^0")
        return
    end


    MySQL.Async.execute(
        "UPDATE territoires SET score_total = score_total + ? WHERE territory_name = ? AND id_crew = ?",
        {points, territoryName, crewId},
        function(rowsChanged)
            if rowsChanged == 0 then

                MySQL.Async.execute(
                    "INSERT INTO territoires (id_crew, territory_name, score_total) VALUES (?, ?, ?)",
                    {crewId, territoryName, points},
                    function()
                        TriggerClientEvent("nvTerritory:territoriesUpdated", -1, {id = territoryId, updated = true})
                    end
                )
            else
                TriggerClientEvent("nvTerritory:territoriesUpdated", -1, {id = territoryId, updated = true})
            end
        end
    )
end)


ESX.RegisterServerCallback("nvTerritory:getAllTerritories", function(source, cb)
    local territories = LoadTerritoriesFromFile()
    cb(territories)
end)