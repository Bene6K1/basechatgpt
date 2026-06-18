


if Config and Config.ESXMode == "old" then
    ESX = ESX or nil
    TriggerEvent("esx:getSharedObject", function(obj)
        ESX = obj
    end)
else
    ESX = exports.es_extended:getSharedObject()
end


local polygonPoints = {}
local newTerritoryData = {
    name = "",
    id = "",
    description = "",
    frequentation = "normale"
}
local territoriesLoaded = false
local adminCheckRequired = true


local playerGroup = nil
local selectedTerritory = nil
local selectedTerritoryIndex = nil
local editPoints = {}
local editTerritoryData = {
    name = "",
    id = "",
    description = "",
    frequentation = "normale"
}


local menuOpen = false
local allTerritories = {}

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

RegisterNetEvent("esx:setGroup", function(group)
    playerGroup = group
end)

function CheckIsAdmin()
    local group = nil


    if ESX and ESX.GetPlayerData then
        local playerData = ESX.GetPlayerData()
        if playerData and playerData.group then
            group = playerData.group
        end
    end


    if not group then
        if playerGroup == nil then
            local callbackReceived = false

            ESX.TriggerServerCallback("nvTerritory:getPlayerGroup", function(serverGroup)
                playerGroup = serverGroup
                callbackReceived = true
            end)

            local startTime = GetGameTimer()
            while not callbackReceived do
                if (GetGameTimer() - startTime) >= 1000 then
                    break
                end
                Citizen.Wait(0)
            end
        end
        group = playerGroup
    end

    if not group then
        return false
    end

    return IsAdminGroup(tostring(group):lower())
end

RegisterCommand("territories", function()
    if adminCheckRequired then
        if not CheckIsAdmin() then
            ESX.ShowNotification(_U("access_denied_admin"))
            return
        end
    end

    TriggerEvent("nvTerritory:openTerritoryMenu")
end)

function InitializeMenus()
    if menuOpen then
        return
    end

    menuOpen = true
    polygonPoints = {}
    newTerritoryData = {
        name = "",
        id = "",
        description = "",
        frequentation = "normale"
    }
    territoriesLoaded = false


    local bannerConfig = Config.BannerTerritories
    if bannerConfig and bannerConfig ~= "without" then
        RMenu.Add("territories", "main", RageUI.CreateMenu("", " ", nil, 100, bannerConfig, "interaction_bgd2"))
        RMenu:Get("territories", "main"):DisplayGlare(false)
    else
        RMenu.Add("territories", "main", RageUI.CreateMenu(_U("territory_management"), _U("territory_management")))
        local mainMenu = RMenu:Get("territories", "main")
        mainMenu:SetRectangleBanner(
            Config.MenuBannerColor.r,
            Config.MenuBannerColor.g,
            Config.MenuBannerColor.b,
            Config.MenuBannerColor.a
        )
    end


    RMenu.Add("territories", "config", RageUI.CreateSubMenu(RMenu:Get("territories", "main"), "", _U("territory_configuration")))
    RMenu.Add("territories", "create", RageUI.CreateSubMenu(RMenu:Get("territories", "config"), "", _U("polygon_construction")))
    RMenu.Add("territories", "edit", RageUI.CreateSubMenu(RMenu:Get("territories", "main"), "", _U("territory_editing")))
    RMenu.Add("territories", "editPoints", RageUI.CreateSubMenu(RMenu:Get("territories", "edit"), "", _U("point_modification")))

    RageUI.Visible(RMenu:Get("territories", "main"), true)


    allTerritories = {}
    territoriesLoaded = false

    ESX.TriggerServerCallback("nvTerritory:getAllTerritories", function(territories)
        allTerritories = territories or {}
        territoriesLoaded = true
    end)


    Citizen.CreateThread(function()
        while menuOpen do

            if not (RageUI.Visible(RMenu:Get("territories", "main")) or
                    RageUI.Visible(RMenu:Get("territories", "config")) or
                    RageUI.Visible(RMenu:Get("territories", "create")) or
                    RageUI.Visible(RMenu:Get("territories", "edit")) or
                    RageUI.Visible(RMenu:Get("territories", "editPoints"))) then
                menuOpen = false
                break
            end


            RageUI.IsVisible(RMenu:Get("territories", "main"), function()
                RageUI.Separator("~b~" .. _U("existing_territories"))

                if territoriesLoaded then
                    if allTerritories and #allTerritories > 0 then
                        for i = 1, #allTerritories do
                            local territory = allTerritories[i]
                            local displayName = territory.name or ("Territoire #" .. i)

                            RageUI.Button(
                                string.format("%s", displayName),
                                nil,
                                {RightLabel = "→"},
                                true,
                                {
                                    onSelected = function()
                                        selectedTerritory = territory
                                        selectedTerritoryIndex = i
                                        editPoints = {}

                                        editTerritoryData = {
                                            name = territory.name or "",
                                            id = territory.id or "",
                                            description = territory.description or "",
                                            frequentation = territory.frequentation or "normale"
                                        }

                                        for _, point in ipairs(territory.points or {}) do
                                            table.insert(editPoints, {x = point.x, y = point.y})
                                        end
                                    end
                                },
                                RMenu:Get("territories", "edit")
                            )
                        end
                    else
                        RageUI.Button("~r~" .. _U("no_territories_found"), nil, {}, false, {})
                    end
                else
                    RageUI.Button("~y~" .. _U("loading"), nil, {}, false, {})
                end

                RageUI.Separator("")
                RageUI.Button("~g~" .. _U("create_new_territory"), nil, {RightLabel = "→"}, true, {}, RMenu:Get("territories", "config"))
            end, function() end)


            RageUI.IsVisible(RMenu:Get("territories", "config"), function()
                RageUI.Separator("~y~" .. _U("territory_configuration"))


                local displayName = (newTerritoryData.name ~= "" and newTerritoryData.name) or ""
                if #displayName > 12 then
                    displayName = string.sub(displayName, 1, 12) .. "..."
                end

                RageUI.Button(
                    _U("territory_name"),
                    _U("territory_name_desc"),
                    {RightLabel = displayName},
                    true,
                    {
                        onSelected = function()
                            local input = KeyboardInput(_U("territory_name"), 50)
                            if input and input ~= "" then
                                newTerritoryData.name = input
                            end
                        end
                    }
                )


                local displayId = (newTerritoryData.id ~= "" and newTerritoryData.id) or ""
                if #displayId > 12 then
                    displayId = string.sub(displayId, 1, 12) .. "..."
                end

                RageUI.Button(
                    _U("territory_id"),
                    _U("territory_id_desc"),
                    {RightLabel = displayId},
                    true,
                    {
                        onSelected = function()
                            local input = KeyboardInput(_U("territory_id_desc"), 40)
                            if input and input ~= "" then
                                newTerritoryData.id = input:gsub("%s+", "_")
                            end
                        end
                    }
                )


                local displayDesc = (newTerritoryData.description ~= "" and newTerritoryData.description) or ""
                if #displayDesc > 12 then
                    displayDesc = string.sub(displayDesc, 1, 12) .. "..."
                end

                RageUI.Button(
                    _U("territory_description"),
                    _U("territory_description_desc"),
                    {RightLabel = displayDesc},
                    true,
                    {
                        onSelected = function()
                            local input = KeyboardInput(_U("territory_description"), 500)
                            if input and input ~= "" then
                                newTerritoryData.description = input
                            end
                        end
                    }
                )


                local freqIndex = 2
                if newTerritoryData.frequentation == "low" then
                    freqIndex = 1
                elseif newTerritoryData.frequentation == "high" then
                    freqIndex = 3
                end

                RageUI.List(
                    _U("territory_frequentation"),
                    {
                        _U("territory_frequentation_low"),
                        _U("territory_frequentation_normal"),
                        _U("territory_frequentation_high")
                    },
                    freqIndex,
                    nil,
                    {},
                    true,
                    {
                        onListChange = function(index, item)
                            local freqValues = {"low", "normal", "high"}
                            newTerritoryData.frequentation = freqValues[index]
                        end
                    }
                )

                RageUI.Separator("-----------")

                local canContinue = newTerritoryData.name ~= ""
                local continueDesc = canContinue and _U("continue_to_creation_desc") or ("~r~" .. _U("name_and_id_required"))

                RageUI.Button(
                    "~g~" .. _U("continue_to_creation"),
                    continueDesc,
                    {},
                    canContinue,
                    {
                        onSelected = function()
                            if canContinue then
                                if newTerritoryData.id == "" then
                                    newTerritoryData.id = string.format("custom_%d", math.floor(GetGameTimer()))
                                end
                            end
                        end
                    },
                    RMenu:Get("territories", "create")
                )
            end, function() end)


            RageUI.IsVisible(RMenu:Get("territories", "create"), function()
                RageUI.Separator("~y~" .. _U("polygon_construction"))
                RageUI.Separator(string.format("Territoire:~y~ %s", newTerritoryData.name))

                for i = 1, #polygonPoints do
                    local point = polygonPoints[i]
                    RageUI.Button(
                        string.format("%d: X=%.1f Y=%.1f", i, point.x, point.y),
                        nil,
                        {},
                        false,
                        {}
                    )
                end

                RageUI.Button(
                    _U("add_point"),
                    _U("add_point_desc"),
                    {},
                    true,
                    {
                        onSelected = function()
                            local ped = PlayerPedId()
                            local coords = GetEntityCoords(ped)
                            table.insert(polygonPoints, {x = coords.x + 0.0, y = coords.y + 0.0})
                            ESX.ShowNotification(_U("point_added", #polygonPoints))
                        end
                    }
                )

                local canCreate = #polygonPoints >= 3
                local createDesc = canCreate and _U("create_territory_desc") or ("~r~" .. _U("minimum_3_points"))

                RageUI.Button(
                    "~g~" .. _U("create_territory"),
                    createDesc,
                    {},
                    canCreate,
                    {
                        onSelected = function()
                            local territoryData = {
                                id = newTerritoryData.id,
                                name = newTerritoryData.name,
                                description = newTerritoryData.description,
                                frequentation = newTerritoryData.frequentation,
                                points = polygonPoints
                            }
                            TriggerServerEvent("nvTerritory:saveTerritory", territoryData)
                            menuOpen = false
                        end
                    }
                )
            end, function() end)


            RageUI.IsVisible(RMenu:Get("territories", "edit"), function()
                if not selectedTerritory then
                    RageUI.Button("~r~" .. _U("no_territories_found"), nil, {}, false, {})
                    return
                end

                RageUI.Separator("~y~" .. _U("territory_editing"))
                RageUI.Separator(string.format("Territoire:~y~ %s", selectedTerritory.name or "Inconnu"))


                local displayName = (editTerritoryData.name ~= "" and editTerritoryData.name) or ""
                if #displayName > 12 then
                    displayName = string.sub(displayName, 1, 12) .. "..."
                end

                RageUI.Button(
                    _U("territory_name"),
                    _U("territory_name_desc"),
                    {RightLabel = displayName},
                    true,
                    {
                        onSelected = function()
                            local input = KeyboardInput(_U("territory_name"), 50)
                            if input and input ~= "" then
                                editTerritoryData.name = input
                            end
                        end
                    }
                )


                local displayId = (editTerritoryData.id ~= "" and editTerritoryData.id) or ""
                if #displayId > 12 then
                    displayId = string.sub(displayId, 1, 12) .. "..."
                end

                RageUI.Button(
                    _U("territory_id"),
                    _U("territory_id_desc"),
                    {RightLabel = displayId},
                    true,
                    {
                        onSelected = function()
                            local input = KeyboardInput(_U("territory_id_desc"), 40)
                            if input and input ~= "" then
                                editTerritoryData.id = input:gsub("%s+", "_")
                            end
                        end
                    }
                )


                local displayDesc = (editTerritoryData.description ~= "" and editTerritoryData.description) or ""
                if #displayDesc > 12 then
                    displayDesc = string.sub(displayDesc, 1, 12) .. "..."
                end

                RageUI.Button(
                    _U("territory_description"),
                    _U("territory_description_desc"),
                    {RightLabel = displayDesc},
                    true,
                    {
                        onSelected = function()
                            local input = KeyboardInput(_U("territory_description"), 500)
                            if input and input ~= "" then
                                editTerritoryData.description = input
                            end
                        end
                    }
                )


                local freqIndex = 2
                if editTerritoryData.frequentation == "low" then
                    freqIndex = 1
                elseif editTerritoryData.frequentation == "high" then
                    freqIndex = 3
                end

                RageUI.List(
                    _U("territory_frequentation"),
                    {
                        _U("territory_frequentation_low"),
                        _U("territory_frequentation_normal"),
                        _U("territory_frequentation_high")
                    },
                    freqIndex,
                    nil,
                    {},
                    true,
                    {
                        onListChange = function(index, item)
                            local freqValues = {"low", "normal", "high"}
                            editTerritoryData.frequentation = freqValues[index]
                        end
                    }
                )

                RageUI.Button(
                    "~o~" .. _U("modify_points"),
                    _U("current_points", #editPoints),
                    {RightLabel = "→"},
                    true,
                    {},
                    RMenu:Get("territories", "editPoints")
                )

                RageUI.Separator("-----------")

                local canValidate = editTerritoryData.name ~= ""
                local validateDesc = canValidate and _U("validate_desc") or ("~r~" .. _U("name_and_id_required"))

                RageUI.Button(
                    "~g~" .. _U("validate"),
                    validateDesc,
                    {},
                    canValidate,
                    {
                        onSelected = function()
                            if canValidate then
                                local territoryData = {
                                    id = editTerritoryData.id,
                                    name = editTerritoryData.name,
                                    description = editTerritoryData.description,
                                    frequentation = editTerritoryData.frequentation,
                                    points = editPoints,
                                    originalId = selectedTerritory.id
                                }
                                TriggerServerEvent("nvTerritory:updateTerritory", territoryData)
                            end
                        end
                    }
                )

                RageUI.Button(
                    "~r~" .. _U("delete"),
                    _U("delete_desc"),
                    {},
                    true,
                    {
                        onSelected = function()
                            TriggerServerEvent("nvTerritory:deleteTerritory", selectedTerritory.id)
                            menuOpen = false
                        end
                    }
                )
            end, function() end)


            RageUI.IsVisible(RMenu:Get("territories", "editPoints"), function()
                RageUI.Separator("~y~" .. _U("point_modification"))
                RageUI.Separator(string.format("Territoire:~y~ %s", editTerritoryData.name))

                for i = 1, #editPoints do
                    local point = editPoints[i]
                    RageUI.Button(
                        string.format("%d: X=%.1f Y=%.1f", i, point.x, point.y),
                        _U("click_to_replace"),
                        {},
                        true,
                        {
                            onSelected = function()
                                local ped = PlayerPedId()
                                local coords = GetEntityCoords(ped)
                                editPoints[i] = {x = coords.x + 0.0, y = coords.y + 0.0}
                                ESX.ShowNotification(_U("point_updated", i))
                            end
                        }
                    )
                end

                RageUI.Separator("-----------")

                RageUI.Button(
                    "~g~" .. _U("validate_modifications"),
                    _U("validate_modifications_desc"),
                    {},
                    true,
                    {
                        onSelected = function()
                            RageUI.Visible(RMenu:Get("territories", "editPoints"), false)
                            RageUI.Visible(RMenu:Get("territories", "edit"), true)
                        end
                    }
                )
            end, function() end)

            Citizen.Wait(3)
        end

        if not menuOpen then
            RageUI.CloseAll()
        end
    end)
end

AddEventHandler("nvTerritory:openTerritoryMenu", InitializeMenus)

RegisterNetEvent("nvTerritory:territorySaved", function(success, errorMsg)
    if success then
        ESX.ShowNotification(_U("territory_saved"))
        TriggerEvent("nvTerritory:reloadTerritories")
    else
        ESX.ShowNotification(_U("error", tostring(errorMsg)))
    end
end)

RegisterNetEvent("nvTerritory:territoryUpdated", function(success, errorMsg)
    if success then
        ESX.ShowNotification(_U("territory_updated"))
        menuOpen = false
        RageUI.CloseAll()
    else
        ESX.ShowNotification(_U("error", tostring(errorMsg)))
    end
end)

RegisterNetEvent("nvTerritory:territoryDeleted", function(success, errorMsg)
    if success then
        ESX.ShowNotification(_U("territory_deleted"))
        menuOpen = false
        RageUI.CloseAll()
    else
        ESX.ShowNotification(_U("error", tostring(errorMsg)))
    end
end)