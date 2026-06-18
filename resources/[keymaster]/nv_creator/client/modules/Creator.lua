Creator = {}
Creator.__index = Creator

Creator.cam               = nil
Creator.camThreadRunning  = false
Creator.controlThreadRunning = false

local function lerp(a, b, t)
    return a + (b - a) * t
end

function Creator:applyPlayerModel(sex, x, y, z, heading)
    local promise = promise.new()
    
    TriggerEvent("skinchanger:loadDefaultModel", sex == "m", function()
        promise:resolve(true)
    end)
    
    Citizen.Await(promise)
    
    Citizen.Wait(1000)

    TriggerEvent("skinchanger:getSkin", function (skin)
        if not skin or not skin.sex then
            skin = {
                sex = sex == "m" and 0 or 1,
                tshirt_1 = 15, tshirt_2 = 0,
                torso_1 = sex == "m" and 32 or 5, torso_2 = 2,
                arms = sex == "m" and 15 or 5,
                pants_1 = sex == "m" and 26 or 1, pants_2 = sex == "m" and 1 or 0,
                shoes_1 = sex == "m" and 17 or 32, shoes_2 = 0,
                mask_1 = 0, mask_2 = 0,
                bproof_1 = 0, bproof_2 = 0,
                chain_1 = 0, chain_2 = 0,
                bags_1 = 0, bags_2 = 0,
                helmet_1 = -1, helmet_2 = 0,
                glasses_1 = -1, glasses_2 = 0,
                watches_1 = -1, watches_2 = 0,
                bracelets_1 = -1, bracelets_2 = 0,
                ears_1 = -1, ears_2 = 0,
                decals_1 = 0, decals_2 = 0,
                hair_1 = 0, hair_2 = 0,
                hair_color_1 = 0, hair_color_2 = 0,
                face = 0, skin = 0,
                mom = 21, dad = 0,
                face_md_weight = 50, skin_md_weight = 50,
                nose_1 = 0, nose_2 = 0, nose_3 = 0, nose_4 = 0, nose_5 = 0, nose_6 = 0,
                cheeks_1 = 0, cheeks_2 = 0, cheeks_3 = 0,
                lip_thickness = 0,
                jaw_1 = 0, jaw_2 = 0,
                chin_1 = 0, chin_2 = 0, chin_3 = 0, chin_4 = 0,
                neck_thickness = 0,
                age_1 = 0, age_2 = 0,
                beard_1 = 0, beard_2 = 0, beard_3 = 0, beard_4 = 0,
                eye_color = 0, eye_squint = 0,
                eyebrows_1 = 0, eyebrows_2 = 0, eyebrows_3 = 0, eyebrows_4 = 0, eyebrows_5 = 0, eyebrows_6 = 0,
                makeup_1 = 0, makeup_2 = 0, makeup_3 = 0, makeup_4 = 0,
                lipstick_1 = 0, lipstick_2 = 0, lipstick_3 = 0, lipstick_4 = 0,
                blemishes_1 = 0, blemishes_2 = 0,
                blush_1 = 0, blush_2 = 0, blush_3 = 0,
                complexion_1 = 0, complexion_2 = 0,
                sun_1 = 0, sun_2 = 0,
                moles_1 = 0, moles_2 = 0,
                chest_1 = 0, chest_2 = 0, chest_3 = 0,
                bodyb_1 = 0, bodyb_2 = 0, bodyb_3 = 0, bodyb_4 = 0
            }
        end
        TriggerEvent("skinchanger:loadSkin", skin)
    end)

    if not (x and y and z and heading) then
        return
    end

    local ped = PlayerPedId()
    SetEntityCoords(ped, x, y, z, false, false, false, true)
    SetEntityHeading(ped, heading)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    
    SetEntityAlpha(ped, 255, false)
    SetEntityVisible(ped, true, false)
end

function Creator:createCamera()
    if not self.cam then
        self.cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamActive(self.cam, true)
        RenderScriptCams(true, false, 500, true, true)

        SetCamUseShallowDofMode(self.cam, true)
        SetCamNearDof(self.cam, 0.7)
        SetCamFarDof(self.cam, 1.3)
        SetCamDofStrength(self.cam, 1.0)

        if not self.camThreadRunning then
            self.camThreadRunning = true
            CreateThread(function()
                while self.cam do
                    SetUseHiDof()
                    Wait(0)
                end
                self.camThreadRunning = false
            end)
        end
    end
    return self.cam
end

function Creator:offsetPosition(x, y, heading, distance)
    local rad = math.rad(heading)
    return {
        x = x + math.sin(rad) * distance,
        y = y + math.cos(rad) * distance
    }
end

function Creator:setCameraFocus(focusType, ped, transitionDuration, latOffset)
    latOffset = latOffset or 0

    local coords = GetEntityCoords(ped)

    local settings = {
        full = { distance = 1.5, heightOffset = 0.2, fov = 50.0 },
        head = { distance = 1.0, heightOffset = 0.6, fov = 30.0 },
        legs = { distance = 1.5, heightOffset = -0.5, fov = 50.0 }
    }
    local cfg = settings[focusType] or settings.full

    local front = GetOffsetFromEntityInWorldCoords(ped,
        latOffset,
        cfg.distance,
        cfg.heightOffset
    )

    local targetZ = coords.z + cfg.heightOffset
    local targetPt = vector3(coords.x, coords.y, targetZ)

    local targetFov = cfg.fov

    local function applyCam(x, y, z, fov)
        SetCamCoord(self.cam, x, y, z)
        PointCamAtCoord(self.cam, targetPt.x, targetPt.y, targetPt.z)
        SetCamFov(self.cam, fov)
        SetCamUseShallowDofMode(self.cam, true)
        SetCamNearDof(self.cam, math.max(0.2, cfg.distance * 0.2))
        SetCamFarDof(self.cam, math.min(5.0, cfg.distance * 1.2))
        SetCamDofStrength(self.cam, 1.0)
    end

    if not transitionDuration or transitionDuration <= 0 then
        applyCam(front.x, front.y, front.z, targetFov)
    else
        local startPos = GetCamCoord(self.cam)
        local startFov = GetCamFov(self.cam)
        local t0       = GetGameTimer()

        CreateThread(function()
            while true do
                local now = GetGameTimer()
                local t = math.min((now - t0) / transitionDuration, 1.0)

                local ix = lerp(startPos.x, front.x, t)
                local iy = lerp(startPos.y, front.y, t)
                local iz = lerp(startPos.z, front.z, t)
                local f  = lerp(startFov,    targetFov, t)

                applyCam(ix, iy, iz, f)

                if t >= 1.0 then break end
                Wait(0)
            end
        end)
    end
end

function Creator:destroyCamera()
    if self.cam then
        RenderScriptCams(false, false, 500, true, true)
        DestroyCam(self.cam, false)
        self.cam = nil
        self.camThreadRunning = false
        self.controlThreadRunning = false

        local player = PlayerPedId()
        FreezeEntityPosition(player, false)
        SetEntityInvincible(player, false)
    end
end

function Creator:stopIdleEmote()
    local ped = PlayerPedId()
    ClearPedTasks(ped)
end

function Creator:playIdleEmote(cb)
    local ped = PlayerPedId()
    local dict, anim = "mini@strip_club@idles@bouncer@base", "base"

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end

    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 1, 0, false, false, false)

    CreateThread(function()
        local timeout = GetGameTimer() + 2000
        while not IsEntityPlayingAnim(ped, dict, anim, 3) and GetGameTimer() < timeout do
            Wait(0)
        end
        if cb then
            cb()
        end
    end)
end

function Creator:disableControls()
    DisableAllControlActions(0)
    EnableControlAction(0, 1, true)   -- LookLeftRight
    EnableControlAction(0, 2, true)   -- LookUpDown
    EnableControlAction(0, 200, true) -- ESC
    EnableControlAction(0, 322, true) -- ESC
end

function Creator:setData()
    TriggerEvent('skinchanger:getData', function(data, max)
        sendMessage("GetData", data)
        sendMessage("GetMaxVals", max)
	end)
end