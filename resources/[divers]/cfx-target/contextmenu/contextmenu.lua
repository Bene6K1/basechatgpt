ESX = exports["es_extended"]:getSharedObject()

local menuPool = MenuPool()
local selectedWorldPosition = nil

local currentEntity = nil

EnableEditorRuntime()

menuPool.OnOpenMenu = function(screenPosition, hitSomething, worldPosition, hitEntity, normalDirection)
    local entityType = GetEntityType(hitEntity)
    CreateMenu(screenPosition, worldPosition, entityType, hitEntity, materialHash)
end

menuPool.CustomProcess = function()
    if selectedWorldPosition then
        DrawMarker(28, selectedWorldPosition.x, selectedWorldPosition.y, selectedWorldPosition.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, nil, nil, true)
    end
    if SelectedEntity then
        local entityType = GetEntityType(SelectedEntity)
        DrawMarker(0, GetPedBoneCoords(SelectedEntity, 31086, 0.7, 0.0, 0.0), 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 0, 0, 255, 20, 0, 0, 0, 0, 0, 0, 0)
    end
    if currentEntity then
        local entityType = GetEntityType(currentEntity)
        if entityType == 1 then
            DrawMarker(0, GetPedBoneCoords(currentEntity, 31086, 0.7, 0.0, 0.0), 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 255, 255, 255, 20, 0, 0, 0, 0, 0, 0, 0)
        end
    end
end

menuPool.OnCloseMenu = function()
    if not EditWithGizmo then
        EditEntity = nil
    end
    menuPool.buttonPressed = false
end


function CreateMenu(screenPosition, worldPosition, entityType, hitEntity, materialHash)
    _G.LastEntityHit = hitEntity
    _G.LastCoordsHit = worldPosition
    local playerPed = PlayerPedId()
    local isInAnyVehicle = IsPedInAnyVehicle(playerPed, true)
    local currentVehicle = 0
    menuPool:Reset()
    local contextMenu = menuPool:AddMenu()
    currentEntity = hitEntity
    contextMenu.OnClosed = function()
        currentEntity = nil
    end
    contextMenu.alpha = 150
    contextMenu.colors.border = Color(0, 0, 0, 0)
    ESX.TriggerServerCallback('BahFaut:getUsergroup', function(playergroup)
          if hitEntity ~= nil and DoesEntityExist(hitEntity) then
            
            if playerPed == hitEntity then
                _My()
                local itemsAdded = 0
                for k,v in pairs(Action_Config.My) do 
                    if playergroup == v.user or playergroup == v.mod or playergroup == v.admin or playergroup == v.superadmin or playergroup == v._dev or playergroup == v.owner then
                        if v.Type == "buttom" then 
                            local item = contextMenu:AddItem(v.Label)
                            v.EntityHit = hitEntity
                            item.OnRelease = v.OnClick
                            item.closeMenuOnRelease = v.CloseOnClick
                            itemsAdded = itemsAdded + 1
                        elseif v.Type == "buttom-submenu" then
                            local subMenu = menuPool:AddSubmenu(contextMenu, v.Label)
                            for _, action in pairs(v.Action) do
                                local subItem = subMenu:AddItem(action[1])
                                subItem.OnRelease = action[2]
                                subItem.closeMenuOnRelease = v.CloseOnClick
                            end
                            itemsAdded = itemsAdded + 1
                        end
                        if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'unemployed' and ESX.PlayerData.job.grade_name == 'boss' then
                            if v.Type == "buttom-entreprise" then
                                local subMenu = menuPool:AddSubmenu(contextMenu, v.Label)
                                for _, action in pairs(v.Action) do
                                    local subItem = subMenu:AddItem(action[1])
                                    subItem.OnRelease = action[2]
                                    subItem.closeMenuOnRelease = v.CloseOnClick
                                end
                                itemsAdded = itemsAdded + 1
                            end
                        end
                        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name ~= 'unemployed2' and ESX.PlayerData.job2.grade_name == 'boss' then
                            if v.Type == "buttom-organisation" then
                                local subMenu = menuPool:AddSubmenu(contextMenu, v.Label)
                                for _, action in pairs(v.Action) do
                                    local subItem = subMenu:AddItem(action[1])
                                    subItem.OnRelease = action[2]
                                    subItem.closeMenuOnRelease = v.CloseOnClick
                                end
                                itemsAdded = itemsAdded + 1
                            end
                        end
                    end
                end
        
        elseif IsEntityAVehicle(hitEntity) then
            _Vehicule()
            local itemsAdded = 0
            for k,v in pairs(Action_Config.Vehicule) do 
                if playergroup == v.user or playergroup == v.mod or playergroup == v.admin or playergroup == v.superadmin or playergroup == v._dev or playergroup == v.owner then
                    if v.Type == "buttom" then 
                        local item = contextMenu:AddItem(v.Label)
                        v.EntityHit = hitEntity
                        item.OnRelease = v.OnClick
                        item.closeMenuOnRelease = v.CloseOnClick
                        itemsAdded = itemsAdded + 1
                    elseif v.Type == "buttom-submenu" then
                        local subMenu = menuPool:AddSubmenu(contextMenu, v.Label)
                        for _, action in pairs(v.Action) do
                            local subItem = subMenu:AddItem(action[1])
                            subItem.OnRelease = action[2]
                            subItem.closeMenuOnRelease = v.CloseOnClick
                        end
                        itemsAdded = itemsAdded + 1
                    end
                end
            end
          elseif IsEntityAPed(hitEntity) and IsPedAPlayer(hitEntity) then
            _Player()
            for k,v in pairs(Action_Config.Player) do 
                if playergroup == v.user or playergroup == v.mod or playergroup == v.admin or playergroup == v.superadmin or playergroup == v._dev or playergroup == v.owner then
                    if v.Type == "buttom" then 
                        local item = contextMenu:AddItem(v.Label)
                        v.EntityHit = hitEntity
                        item.OnRelease = v.OnClick
                        item.closeMenuOnRelease = v.CloseOnClick
                    elseif v.Type == "buttom-submenu" then
                        local subMenu = menuPool:AddSubmenu(contextMenu, v.Label)
                        for _, action in pairs(v.Action) do
                            local subItem = subMenu:AddItem(action[1])
                            subItem.OnRelease = action[2]
                            subItem.closeMenuOnRelease = v.CloseOnClick
                        end
                    end
                end
            end
          elseif IsEntityAPed(hitEntity) then
            _Peds()
            for k,v in pairs(Action_Config.Peds) do 
                if playergroup == v.user or playergroup == v.mod or playergroup == v.admin or playergroup == v.superadmin or playergroup == v._dev or playergroup == v.owner then
                    if v.Type == "buttom" then 
                        local item = contextMenu:AddItem(v.Label)
                        v.EntityHit = hitEntity
                        item.OnRelease = v.OnClick
                        item.closeMenuOnRelease = v.CloseOnClick
                    elseif v.Type == "buttom-submenu" then
                        local subMenu = menuPool:AddSubmenu(contextMenu, v.Label)
                        for _, action in pairs(v.Action) do
                            local subItem = subMenu:AddItem(action[1])
                            subItem.OnRelease = action[2]
                            subItem.closeMenuOnRelease = v.CloseOnClick
                        end
                    end
                end
            end
        
        elseif IsEntityAnObject(hitEntity) then
            if GetEntityModel(LastEntityHit) == 1114264700 then
                _Soda()
                for k,v in pairs(Action_Config.Soda) do 
                    if playergroup == v.user or playergroup == v.mod or playergroup == v.admin or playergroup == v.superadmin or playergroup == v._dev or playergroup == v.owner then
                        if v.Type == "buttom" then 
                            local item = contextMenu:AddItem(v.Label)
                            v.EntityHit = hitEntity
                            item.OnRelease = v.OnClick
                            item.closeMenuOnRelease = v.CloseOnClick
                        elseif v.Type == "buttom-submenu" then
                            local subMenu = menuPool:AddSubmenu(contextMenu, v.Label)
                            for _, action in pairs(v.Action) do
                                local subItem = subMenu:AddItem(action[1])
                                subItem.OnRelease = action[2]
                                subItem.closeMenuOnRelease = v.CloseOnClick
                            end
                        end
                    end
                end
            elseif GetEntityModel(LastEntityHit) == 690372739 then
                _Coffee()
                for k,v in pairs(Action_Config.Coffee) do 
                    if playergroup == v.user or playergroup == v.mod or playergroup == v.admin or playergroup == v.superadmin or playergroup == v._dev or playergroup == v.owner then
                        if v.Type == "buttom" then 
                            local item = contextMenu:AddItem(v.Label)
                            v.EntityHit = hitEntity
                            item.OnRelease = v.OnClick
                            item.closeMenuOnRelease = v.CloseOnClick
                        elseif v.Type == "buttom-submenu" then
                            local subMenu = menuPool:AddSubmenu(contextMenu, v.Label)
                            for _, action in pairs(v.Action) do
                                local subItem = subMenu:AddItem(action[1])
                                subItem.OnRelease = action[2]
                                subItem.closeMenuOnRelease = v.CloseOnClick
                            end
                        end
                    end
                end
            else
                _Object()
                for k,v in pairs(Action_Config.Object) do 
                    if playergroup == v.user or playergroup == v.mod or playergroup == v.admin or playergroup == v.superadmin or playergroup == v._dev or playergroup == v.owner then
                        if v.Type == "buttom" then 
                            local item = contextMenu:AddItem(v.Label)
                            v.EntityHit = hitEntity
                            item.OnRelease = v.OnClick
                            item.closeMenuOnRelease = v.CloseOnClick
                        elseif v.Type == "buttom-submenu" then
                            local subMenu = menuPool:AddSubmenu(contextMenu, v.Label)
                            for _, action in pairs(v.Action) do
                                local subItem = subMenu:AddItem(action[1])
                                subItem.OnRelease = action[2]
                                subItem.closeMenuOnRelease = v.CloseOnClick
                            end
                        end
                    end
                end
            end
        
        else
            _Ground()
            for k,v in pairs(Action_Config.Ground) do 
                if playergroup == v.user or playergroup == v.mod or playergroup == v.admin or playergroup == v.superadmin or playergroup == v._dev or playergroup == v.owner then
                    if v.Type == "buttom" then 
                        local item = contextMenu:AddItem(v.Label)
                        v.EntityHit = hitEntity
                        item.OnRelease = v.OnClick
                        item.closeMenuOnRelease = v.CloseOnClick
                    elseif v.Type == "buttom-submenu" then
                        local subMenu = menuPool:AddSubmenu(contextMenu, v.Label)
                        for _, action in pairs(v.Action) do
                            local subItem = subMenu:AddItem(action[1])
                            subItem.OnRelease = action[2]
                            subItem.closeMenuOnRelease = v.CloseOnClick
                        end
                    end
                end
            end
        end
    else
        _sky()
        for k,v in pairs(Action_Config.Sky) do 
            if playergroup == v.user or playergroup == v.mod or playergroup == v.admin or playergroup == v.superadmin or playergroup == v._dev or playergroup == v.owner then
                if v.Type == "buttom" then 
                    local item = contextMenu:AddItem(v.Label)
                    v.EntityHit = hitEntity
                    item.OnRelease = v.OnClick
                    item.closeMenuOnRelease = v.CloseOnClick
                elseif v.Type == "buttom-submenu" then
                    local subMenu = menuPool:AddSubmenu(contextMenu, v.Label)
                    for _, action in pairs(v.Action) do
                        local subItem = subMenu:AddItem(action[1])
                        subItem.OnRelease = action[2]
                        subItem.closeMenuOnRelease = v.CloseOnClick
                    end
                end
            end
        end
    end
    contextMenu:SetPosition(screenPosition)
    contextMenu:Visible(true)
    end)
end
