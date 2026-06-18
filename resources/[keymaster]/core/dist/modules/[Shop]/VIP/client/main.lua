VIP = {
    data = {
        have = false,
        time = 0,
    },
    haveVip = function()
        return VIP.data.have
    end,

    entity = {
        sorted = false,
        entityid = nil,
        sitting = false,
        nameActive = false,
        name = {},
        followMe = false,
    },

    animals = {
        {label = 'Husky | chien loup', entityName = 'a_c_husky'}
    }
}

RegisterNetEvent('sunny:vip:refreshData', function(v)
    VIP.data = {}
    VIP.data = v

    ESX.ShowNotification(('Information VIP ~s~\n\nVotre '..SunnyConfigServ.GTACOLOR..'VIP~s~ prendra fin dans '..SunnyConfigServ.GTACOLOR..'%s~s~ heure(s)'):format(VIP.data.time))
end)

RegisterNetEvent('sunny:vip:animals:sort', function(coords, entityName)
    if VIP.entity.sorted == true then return ESX.ShowNotification('🐕 Vous avez déjà un animal de sorti') end

    local ee = GetHashKey(entityName)
    ESX.Game.SpawnPed(1, entityName, vector3(coords.x, coords.y, coords.z), 90.0, function(ped)
            
        -- Entity(ped).state.entityId = ped

        VIP.entity.entityid = ped

        VIP.entity.sorted = true

        ESX.ShowNotification('🐕 Animal sorti avec succès')
    end)
end)

RegisterNetEvent('sunny:vip:animals:remove', function()
    CreateThread(function()
        if VIP.entity and DoesEntityExist(VIP.entity.entityid) then
            ClearPedTasksImmediately(VIP.entity.entityid)
            DeleteEntity(VIP.entity.entityid)
        end

        VIP.entity.followMe = false
        VIP.entity.entityid = nil
        VIP.entity.name = {}
        VIP.entity.sorted = false

        ESX.ShowNotification('🐕 Animal rentré avec succès')
    end)
end)


local aTag = {}

RegisterNetEvent('sunny:animals:setName', function(entityId, name)
    CreateThread(function()
        VIP.entity.name[entityId] = {
            entityId = entityId,
            name = name,
            coords = GetEntityCoords(entityId)
        }
    end)
end)

Citizen.CreateThread(function()
    local interval = 2000
    while true do
        Wait(interval)
        interval = 2000

        for k,v in pairs(VIP.entity.name) do
            if DoesEntityExist(v.entityId) then
                dist = #(GetEntityCoords(PlayerPedId())-GetEntityCoords(v.entityId))
                if dist > 2 then goto continue end
            else
                break
            end
        
            interval = 1
    
            aTag[v.entityId] = CreateFakeMpGamerTag(v.entityId, ('%s | %s'):format('Animal', v.name), true, false, 'NPC', 1)
            SetMpGamerTagName(aTag[v.entityId], ('%s | %s'):format('Animal', v.name))
            SetMpGamerTagColour(aTag[v.entityId], 0, 34)
            SetMpGamerTagVisibility(aTag[v.entityId], 14, true)
            SetMpGamerTagColour(aTag[v.entityId], 14, 34)
            SetMpGamerTagAlpha(aTag[v.entityId], 14, 255)
            SetMpGamerTagHealthBarColor(aTag[v.entityId], 34)

            if dist > 2 then
                RemoveMpGamerTag(aTag[v.entityId])
            end
    
            if not DoesEntityExist(v.entityId) then
                RemoveMpGamerTag(aTag[v.entityId])
            end
    
            if not VIP.entity.name[k] then
                RemoveMpGamerTag(aTag[v.entityId])
            end
        end

        ::continue::
    end
end)

RegisterNetEvent('sunny:vip:animals:editName', function(entityId, newName)
    VIP.entity.name[entityId].name = newName
end)

RegisterNetEvent('sunny:vip:animals:removeName', function(entityID)
    VIP.entity.name[entityID] = nil
    RemoveMpGamerTag(aTag[entityID])
end)

RegisterNetEvent('sunny:vip:animals:followMe', function()
    VIP.entity.followMe = true

    local entityToFollow = VIP.entity.entityid
    local speed = 4.0  
    local playerPed = PlayerPedId()

    if not DoesEntityExist(entityToFollow) then
        print("Erreur : L'entité de l'animal n'existe pas.")
        return
    end

    TaskFollowToOffsetOfEntity(entityToFollow, playerPed, 0.0, 0.0, 0.0, speed, -1, 2.0, true)

    while VIP.entity.followMe do
        Wait(1000)

        if not DoesEntityExist(entityToFollow) then
            print("Erreur : L'entité de l'animal a disparu.")
            break
        end

        local playerPos = GetEntityCoords(playerPed)
        local entityPos = GetEntityCoords(entityToFollow)
        local distance = #(playerPos - entityPos)

        if distance > 10 then
            ClearPedTasks(entityToFollow)
            TaskFollowToOffsetOfEntity(entityToFollow, playerPed, 0.0, 0.0, 0.0, speed, -1, 2.0, true)
        end

        if not VIP.entity.followMe then
            ClearPedTasks(entityToFollow)
            break
        end
    end
end)




AddEventHandler('onResourceStop', function(rName)
    if GetCurrentResourceName() ~= rName then return end

    if VIP.entity.entityid ~= nil then
        if DoesEntityExist(Entity(VIP.entity.entityid).state.entityId) then
            DeleteEntity(Entity(VIP.entity.entityid).state.entityId)
        end
    end
end)

RegisterNetEvent('sunny:en:sertcoords', function(ped, coords)
    SetEntityCoords(ped, coords)
end)

local driftBackup = {}

RegisterNetEvent('sunny:vip:client:applyTint')
AddEventHandler('sunny:vip:client:applyTint', function(tintId)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    if weapon ~= `WEAPON_UNARMED` and type(tintId) == 'number' then
        SetPedWeaponTintIndex(ped, weapon, tintId)
    end
end)

RegisterNetEvent('sunny:vip:client:applyComponent')
AddEventHandler('sunny:vip:client:applyComponent', function(weaponName, component)
    local ped = PlayerPedId()
    if type(weaponName) ~= 'string' or type(component) ~= 'string' then return end
    local weaponHash = GetHashKey(weaponName)
    local compHash = GetHashKey(component)
    if HasPedGotWeapon(ped, weaponHash, false) then
        GiveWeaponComponentToPed(ped, weaponHash, compHash)
    else
        ESX.ShowNotification('Vous n\'avez pas cette arme')
    end
end)

local function backupHandling(veh)
    if driftBackup[veh] then return end
    driftBackup[veh] = {
        tl = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionLossMult'),
        lstl = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult'),
        di = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fDriveInertia')
    }
end

local function applyDrift(veh)
    SetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionLossMult', 2.2)
    SetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult', 2.0)
    SetVehicleHandlingFloat(veh, 'CHandlingData', 'fDriveInertia', 1.1)
end

local function restoreHandling(veh)
    local b = driftBackup[veh]
    if not b then return end
    SetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionLossMult', b.tl or 1.0)
    SetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult', b.lstl or 1.0)
    SetVehicleHandlingFloat(veh, 'CHandlingData', 'fDriveInertia', b.di or 1.0)
    driftBackup[veh] = nil
end

RegisterNetEvent('sunny:vip:client:toggleDrift')
AddEventHandler('sunny:vip:client:toggleDrift', function(enabled)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh == 0 then return end
    if enabled then
        backupHandling(veh)
        applyDrift(veh)
        ESX.ShowNotification('Mode drift activé')
    else
        restoreHandling(veh)
        ESX.ShowNotification('Mode drift désactivé')
    end
end)

RegisterCommand('vipdrift', function()
    TriggerServerEvent('sunny:vip:toggleDrift')
end)