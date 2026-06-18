ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

function initCreator(xPlayer)
    if isInCreator then
        return
    end
    
    TriggerEvent("enterspawn:creatorStarted")
    
    local lastPosition, lastSkin
    if not xPlayer then
        lastPosition = {
            x = GetEntityCoords(PlayerPedId()),
            heading = GetEntityHeading(PlayerPedId())
        }
        TriggerEvent("skinchanger:getSkin", function(skin)
            lastSkin = skin
        end)
    end

    local sex, spawnCoords = (xPlayer and xPlayer.sex) or 'm', (xPlayer and xPlayer.coords) or Config.Spawn
    local x, y, z, heading = spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.w
    

    DoScreenFadeOut(0)
    while not IsScreenFadedOut() do Wait(0) end

    DisplayRadar(false)
    TriggerEvent("lyozz::Hud::StateHud", false)
    TriggerEvent("lyozz:Hud:StateStatus", false)

    Creator:setData()
    -- Normalize sex to string and update skin sex in state to ensure persistence
    local sexStr = sex
    if sexStr == 0 or sexStr == "0" or (type(sexStr) == 'string' and sexStr:lower() == 'male') or sexStr == 'm' then sexStr = "m"
    elseif sexStr == 1 or sexStr == "1" or (type(sexStr) == 'string' and sexStr:lower() == 'female') or sexStr == 'f' then sexStr = "f" else sexStr = 'm' end
    TriggerEvent("skinchanger:change", 'sex', (sexStr == "m") and 0 or 1)
    Creator:applyPlayerModel(sexStr, x, y, z, heading)
    Creator:createCamera()
    Creator:setCameraFocus('full', PlayerPedId(), 300, 0.5)

    local idlePromise = promise.new()
    Creator:playIdleEmote(function()
        idlePromise:resolve(true)
    end)
    Citizen.Await(idlePromise)

    if not Creator.controlThreadRunning then
        Creator.controlThreadRunning = true
        CreateThread(function()
            while Creator.cam do
                Creator:disableControls()
                SetUseHiDof()
                Wait(0)
            end
            Creator.controlThreadRunning = false
        end)
    end

    TriggerServerEvent("addBucket")

    DoScreenFadeIn(0)
    sendMessage("displayCreator", Creator.cam)
    Focus(Creator.cam)
    
    isInCreator = true
    Creator.lastPosition = lastPosition
    Creator.lastSkin = lastSkin
    Creator.wasInitWithXPlayer = xPlayer
end

local FirstSpawn, PlayerLoaded, PlayerData = true, false, nil
local isInCreator = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerLoaded = true
    PlayerData = xPlayer
end)

AddEventHandler('playerSpawned', function()
    CreateThread(function()
        while not PlayerLoaded do
            Citizen.Wait(10)
        end
        if FirstSpawn then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if skin == nil then
                    initCreator(PlayerData);
                else
                    TriggerEvent('skinchanger:loadSkin', skin, function()
                        Citizen.Wait(1000)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                end
            end)
            FirstSpawn = false
        end
    end)
end)


RegisterNUICallback("creator:ChangeCam", function (type, cb)
    if not type then return end

    Creator:setCameraFocus(type, PlayerPedId(), 300, 0.5)

    cb("ok ChangeCam")
end)

RegisterNUICallback("creator:changeGender", function (gender, cb)
    if not gender then return end

    local sex = "m"
    if gender == "male" or gender == 'm' or gender == '0' or gender == 0 then sex = "m" else sex = "f" end
    -- Update skin sex immediately so subsequent saves include correct value
    TriggerEvent("skinchanger:change", 'sex', (sex == "m") and 0 or 1)
    Creator:applyPlayerModel(sex)
    
    local idlePromise = promise.new()
    Creator:playIdleEmote(function()
        idlePromise:resolve(true)
    end)
    Citizen.Await(idlePromise)

    cb("ok changeGender")
end)

RegisterNUICallback("creator:onChange", function (data, cb)
    if not data then return end

    local key, val = data.key, data.val
    TriggerEvent("skinchanger:change", key, val)

    cb("ok onChange")
end)

RegisterNUICallback("creator:changeHr", function (data, cb)
    if not data then return end

    local key, val = data.key, data.val
    TriggerEvent("skinchanger:change", key, val)

    cb("ok changeHr")
end)

RegisterNUICallback("creator:onValidate", function (data, cb)
    if not data then return end

    TriggerEvent("skinchanger:getSkin", function (skin)
        TriggerEvent("skinchanger:loadSkin", skin, function()
            Citizen.Wait(200)
            TriggerEvent("skinchanger:loadSkin", skin)
        end)
        
        Citizen.Wait(500)
        
        TriggerServerEvent("creator:onValidate", data, json.encode(skin))
        TriggerServerEvent("removeBucket")

        -- IMPORTANT : Événements de fin de création
        TriggerEvent('enterspawn:creatorFinished')  -- Ancien événement (compatibilité)
        TriggerServerEvent('nv_enterspawn:finished')  -- Nouveau événement (ox_inventory)
        
        TriggerEvent("creator:onReset", false)

        Wait(500)
        
        if exports['nv_enterspawn'] then
            exports['nv_enterspawn']:showEnterSpawn()
        end
    end)

    cb("ok onValidate")
end)

RegisterNUICallback("creator:onCancel", function(data, cb)
    TriggerEvent("creator:onReset", true)
    cb("ok onCancel")
end)

RegisterNUICallback("creator:updateClothes", function(data, cb)
    local tenueId = data.selectedClothes
    local gender = data.gender or "male"
    
    local tenue
    if gender == "male" then
        tenue = Config.MaleOutfits[tenueId]
    else
        tenue = Config.FemaleOutfits[tenueId]
    end

    if tenue then
        TriggerEvent("skinchanger:getSkin", function (skin)
            local ped = PlayerPedId()
            local validTenue = {}
            
            local map = { mask=1, hair=2, arms=3, pants=4, bags=5, shoes=6, chain=7, tshirt=8, bproof=9, decals=10, torso=11 }
            
            for key, value in pairs(tenue) do
                if key:match("_1$") then
                    local base = key:gsub("_[12]$", "")
                    local componentId = map[base]
                    if componentId and GetNumberOfPedDrawableVariations(ped, componentId) > value then
                        validTenue[key] = value
                    end
                elseif key:match("_2$") then
                    local base = key:gsub("_[12]$", "")
                    local componentId = map[base]
                    local drawableKey = base .. "_1"
                    if componentId and GetNumberOfPedTextureVariations(ped, componentId, tenue[drawableKey] or 0) > value then
                        validTenue[key] = value
                    end
                else
                    validTenue[key] = value
                end
            end
            
            TriggerEvent("skinchanger:loadClothes", skin, validTenue)
        end)
    end

    cb("ok updateClothes")
end)

RegisterNetEvent("creator:onReset", function(isForced)
    isForced = isForced or false

    sendMessage("displayCreator", false)
    Focus(false)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    
    Creator:destroyCamera()
    Creator:stopIdleEmote()
    
    isInCreator = false

    if not isForced then
        local ped = PlayerPedId()
        
        local spawnCoords
        if Creator.wasInitWithXPlayer and Creator.wasInitWithXPlayer.coords then
            spawnCoords = Creator.wasInitWithXPlayer.coords
        else
            spawnCoords = Config.AfterCreator
        end
        
        SetEntityCoords(ped, spawnCoords.x, spawnCoords.y, spawnCoords.z)
        SetEntityHeading(ped, spawnCoords.w)
        
        FreezeEntityPosition(ped, false)
        SetEntityInvincible(ped, false)
        SetEntityVisible(ped, true)
        SetEntityCollision(ped, true)
        
        DisplayRadar(true)
        DisplayHud(true)
        TriggerEvent('hud:show')
        TriggerEvent("lyozz::Hud::StateHud", true)
        TriggerEvent("lyozz:Hud:StateStatus", true)
        TriggerEvent('zstatus:show')
        TriggerEvent('zstatus:toggle', true)
        
        pcall(function() exports.zhud:toggle(true) end)
        pcall(function() exports.zstatus:toggle(true) end)
        pcall(function() exports.core_nui:SetHudVisible(true) end)
        
        CreateThread(function()
            Wait(100)
            SetNuiFocus(false, false)
            SetNuiFocusKeepInput(false)
            Wait(100)
            SetNuiFocus(false, false)
            SetNuiFocusKeepInput(false)
        end)
    else
        Wait(100)
        if Creator.wasInitWithXPlayer then
            initCreator(xPlayer)
        else
            initCreator(nil)
        end
    end
end)