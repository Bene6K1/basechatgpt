RegisterNetEvent("rp:RecieveMenu") -- For opening the emote menu from another resource.
AddEventHandler("rp:RecieveMenu", function()
    FlashLandEmotesMenu()
end)

lang = Config.MenuLanguage
local propsEmotesIndex = 1
local HasFocusPedThread = false
local Offset = nil
local DrawMyPed = true

local ignoredCategories = {
    ["Walks"] = true,
    ["Expressions"] = true,
    ["Shared"] = not Config.SharedEmotesEnabled
}

FlashLandEmotesMenu = function()
    if IsEntityDead(PlayerPedId()) then return end;
    if (IsPedSwimming(PlayerPedId()) or IsPedSwimmingUnderWater(PlayerPedId())) and not Config.AllowInWater then return end;

    FocusPedThread(vector3(0.6, 0.4, 0.0))

    lastAnim = nil

    local results = {}

    local EmotesMenus = RageUI.CreateMenu("", "Menu emotes")

    local Emotes = RageUI.CreateSubMenu(EmotesMenus, "", "Emotes")
    local SearchEmotes = RageUI.CreateSubMenu(Emotes, "", "Menu de recherche")
    local Dances = RageUI.CreateSubMenu(Emotes, "", "Danses")
    local AnimalEmotes = RageUI.CreateSubMenu(Emotes, "", "Emotes animaux")
    local PropsEmotes = RageUI.CreateSubMenu(Emotes, "", "Props emotes")
    local SharedEmotes = RageUI.CreateSubMenu(Emotes, "", "Emotes Partagées")

    if Config.SharedEmotesEnabled then
        SharedDances = RageUI.CreateSubMenu(SharedEmotes, "", "Dances partagées")
    end

    local WalkingStyles = RageUI.CreateSubMenu(EmotesMenus, "", "Styles de marche")
    local Moods = RageUI.CreateSubMenu(EmotesMenus, "", "Humeurs")

    RageUI.Visible(EmotesMenus, not RageUI.Visible(EmotesMenus))

    while EmotesMenus do 
        RageUI.IsVisible(EmotesMenus, function() 

            RageUI.Button("Emotes", "Découvrez toutes les animations disponibles", {RightLabel = "🎬"}, true, {}, Emotes)

            RageUI.Button("Annuler Emote", "Annulez l'animation actuel", {RightLabel = "🚷"}, true, {
                onSelected = function()
                    EmoteCancel()
                    DestroyAllProps()
                end
            })

            RageUI.Button("Styles de marche", "Découvrez toutes les styles de marche disponibles", {RightLabel = "🚶🏻‍♂️"}, true, {}, WalkingStyles)

            RageUI.Button("Humeurs", "Découvrez toutes les humeurs disponibles", {RightLabel = "😒"}, true, {}, Moods)
        end)

        RageUI.IsVisible(Emotes, function() 
            if Config.Search then
                RageUI.Button("Rechercher des emotes", "Recherchez facilement des animations", {RightLabel = "🔍"}, true, {
                    onSelected = function()
                        results = {}
                        local input = KeyboardInput("Nom de l'emote", 50)

                        if input ~= nil and input ~= "" then 
                            for k, v in pairs(RP) do
                                if not ignoredCategories[k] then
                                    for a, b in pairs(v) do
                                        if string.find(string.lower(a), string.lower(input)) or (b[3] ~= nil and string.find(string.lower(b[3]), string.lower(input))) then
                                            table.insert(results, {table = k, name = a, data = b})
                                        end
                                    end
                                end
                            end

                            if results then 
                                table.sort(results, function(a, b) return a.name < b.name end)
                            end
                        end
                    end
                }, SearchEmotes)
            end

            RageUI.Button("Danses", "Découvrez toutes les danses disponibles", {RightLabel = "🕺"}, true, {}, Dances)

            if Config.AnimalEmotesEnabled then
                RageUI.Button("Emotes d'animaux", "Découvrez toutes les emotes animaux disponibles", {RightLabel = "🐩"}, true, {}, AnimalEmotes)
            end

            RageUI.Button("Emotes objets", "Découvrez toutes les emotes avec des objets disponibles", {RightLabel = "📦"}, true, {}, PropsEmotes)

            RageUI.Button("Emotes partagées", "Découvrez toutes les emotes partagées disponibles", {RightLabel = "👫"}, true, {}, SharedEmotes)

            for a, b in pairsByKeys(RP.Emotes) do
                x, y, z = table.unpack(b)

                RageUI.Button(z, "/e (" .. a .. ")", {RightLabel = "→"}, true, {
                    onSelected = function()
                        EmoteMenuStart(a, "emotes")
                    end,

                    onActive = function()
                        playOneTime(a, "emotes")
                    end
                })
            end

        end)

        RageUI.IsVisible(Dances, function() 
            for a, b in pairsByKeys(RP.Dances) do
                x, y, z = table.unpack(b)

                RageUI.Button(z, "/e (" .. a .. ")", {RightLabel = "→"}, true, {
                    onSelected = function()
                        EmoteMenuStart(a, "dances")
                    end,

                    onActive = function()
                        playOneTime(a, "dances")
                    end
                })
            end
        end)

        RageUI.IsVisible(AnimalEmotes, function() 
            if Config.AnimalEmotesEnabled then
                for a, b in pairsByKeys(RP.AnimalEmotes) do
                    x, y, z = table.unpack(b)

                    RageUI.Button(z, "/e (" .. a .. ")", {RightLabel = "→"}, true, {
                        onSelected = function()
                            EmoteMenuStart(a, "animals")
                        end
                    })
                end
            end
        end)

        RageUI.IsVisible(PropsEmotes, function() 
            for a, b in pairsByKeys(RP.PropEmotes) do
                x, y, z = table.unpack(b)
        
                if b.AnimationOptions.PropTextureVariations then
                    RageUI.List(z, b.AnimationOptions.PropTextureVariations, propsEmotesIndex, "/e (" .. a .. ")", {}, true, {
                        onListChange = function(Index)
                            if propsEmotesIndex ~= Index then
                                propsEmotesIndex = Index;
                            end
                        end,
        
                        onSelected = function(Index)
                            EmoteMenuStart(a, "props", propsEmotesIndex - 1)
                        end,

                        onActive = function() 
                            playOneTime(a, "props", propsEmotesIndex - 1)
                        end
                    })

                else
                    RageUI.Button(z, "/e (" .. a .. ")", {RightLabel = "→"}, true, {
                        onSelected = function()
                            EmoteMenuStart(a, "props")
                        end,

                        onActive = function() 
                            playOneTime(a, "props")
                        end
                    })
                end
            end
        end)

        RageUI.IsVisible(SharedEmotes, function() 
            if Config.SharedEmotesEnabled then
                RageUI.Button("Dances partagées", nil, {RightLabel = "🕺"}, true, {}, SharedDances)
            end

            for a, b in pairsByKeys(RP.Shared) do
                x, y, z, otheremotename = table.unpack(b)

                if otheremotename == nil then
                    RageUI.Button(z, "/nearby (~g~" .. a .. "~w~)", {RightLabel = "→"}, true, {
                        onSelected = function()
                            target, distance = GetClosestPlayer()

                            if (distance ~= -1 and distance < 3) then
                                TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), a)
                                SimpleNotify(Config.Languages[lang]['sentrequestto'] .. GetPlayerName(target))
                            else
                                SimpleNotify(Config.Languages[lang]['nobodyclose'])
                            end
                        end,

                        onActive = function()
                            playOneTime(a, "shared")
                        end
                    })
                else
                    RageUI.Button(z, "/nearby (~g~" ..a .. "~w~) " .. Config.Languages[lang]['makenearby'] .. " (~y~" .. otheremotename .. "~w~)", {RightLabel = "→"}, true, {
                        onSelected = function()
                            target, distance = GetClosestPlayer()

                            if (distance ~= -1 and distance < 3) then
                                TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), a)
                                SimpleNotify(Config.Languages[lang]['sentrequestto'] .. GetPlayerName(target))
                            else
                                SimpleNotify(Config.Languages[lang]['nobodyclose'])
                            end
                        end,

                        onActive = function()
                            playOneTime(a, "shared")
                        end
                    })
                end
            end
        end)

        RageUI.IsVisible(SharedDances, function() 
            for a, b in pairsByKeys(RP.Dances) do
                x, y, z = table.unpack(b)

                RageUI.Button(z, "/e (" .. a .. ")", {RightLabel = "→"}, true, {
                    onSelected = function()
                        target, distance = GetClosestPlayer()

                        if (distance ~= -1 and distance < 3) then
                            TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), a, 'Dances')
                            SimpleNotify(Config.Languages[lang]['sentrequestto'] .. GetPlayerName(target))
                        else
                            SimpleNotify(Config.Languages[lang]['nobodyclose'])
                        end
                    end,

                    onActive = function()
                        playOneTime(a, "dances")
                    end
                })
            end
        end)

        RageUI.IsVisible(WalkingStyles, function() 
            RageUI.Button("Normal (réinitialiser)", Config.Languages[lang]['resetdef'], {RightLabel = "→"}, true, {
                onSelected = function()
                    ResetWalk()
                    DeleteResourceKvp("walkstyle")
                end
            })
        
            for a, b in pairsByKeys(RP.Walks) do
                x, label = table.unpack(b)

                RageUI.Button(label or a, "/walk (" .. string.lower(a) .. ")", {RightLabel = "→"}, true, {
                    onSelected = function()
                        x, label = table.unpack(b)
                        WalkMenuStart(x)
                    end,

                    onActive = function() 
                        playOneTime(x, "walk")
                    end
                })
            end
        end)

        RageUI.IsVisible(Moods, function() 

            RageUI.Button("Normal (réinitialiser)", Config.Languages[lang]['resetdef'], {RightLabel = "→"}, true, {
                onSelected = function()
                    ClearFacialIdleAnimOverride(PlayerPedId())
                end
            })
        
            for name, data in pairsByKeys(RP.Expressions) do                
                RageUI.Button(data[2] or name, nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        EmoteMenuStart(name, "expression")
                    end,

                    onActive = function() 
                        playOneTime(name, "expression")
                    end
                })
            end
        end)

        RageUI.IsVisible(SearchEmotes, function() 
            if results and #results > 0 then 
                for k, v in pairs(results) do
                    local desc = ""
                    if v.table == "Shared" then
                        local otheremotename = v.data[4]
                        if otheremotename == nil then
                           desc = "/nearby (~g~" .. v.name .. "~w~)"
                        else
                           desc = "/nearby (~g~" .. v.name .. "~w~) " .. Config.Languages[lang]['makenearby'] .. " (~y~" .. otheremotename .. "~w~)"
                        end
                    else
                        desc = "/e (" .. v.name .. ")" .. (favEnabled and "\n" .. Config.Languages[lang]['searchshifttofav'] or "")
                    end
    
                    if v.data.AnimationOptions and v.data.AnimationOptions.PropTextureVariations then
                        RageUI.List(v.data[3], v.data.AnimationOptions.PropTextureVariations, propsEmotesIndex, desc, {}, true, {
                            onListChange = function(Index)
                                if propsEmotesIndex ~= Index then
                                    propsEmotesIndex = Index;
                                end
                            end,
            
                            onSelected = function()
                                EmoteMenuStart(v.name, "props", propsEmotesIndex - 1)
                            end,

                            onActive = function() 
                                playOneTime(v.name, "props", propsEmotesIndex - 1)
                            end
                        })
                    else
                        RageUI.Button(v.data[3], desc, {RightLabel = "→"}, true, {
                            onSelected = function()
                                if v.table == "Dances" then 
                                    EmoteMenuStart(v.name, "dances")
                                elseif v.table == "PropEmotes" then
                                    EmoteMenuStart(v.name, "props")
                                elseif v.table == "Shared" then
                                    target, distance = GetClosestPlayer()

                                    if (distance ~= -1 and distance < 3) then
                                        TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), v.name)
                                        SimpleNotify(Config.Languages[lang]['sentrequestto'] .. GetPlayerName(target))
                                    else
                                        SimpleNotify(Config.Languages[lang]['nobodyclose'])
                                    end
                                elseif v.table == "Emotes" then
                                    EmoteMenuStart(v.name, "emotes")
                                end
                            end,

                            onActive = function() 
                                if v.table == "Dances" then 
                                    playOneTime(v.name, "dances")
                                elseif v.table == "PropEmotes" then
                                    playOneTime(v.name, "props")
                                elseif v.table == "Emotes" then
                                    playOneTime(v.name, "emotes")
                                end
                            end
                        })
                    end
                end
            else
                RageUI.Separator("Aucune emote trouvée")
            end
        end)

        if not DrawMyPed then 
            FocusPedThread(vector3(0.6, 0.4, 0.0))
        end

        if not RageUI.Visible(EmotesMenus) and not RageUI.Visible(Emotes) and not RageUI.Visible(SearchEmotes) and not RageUI.Visible(Dances) and not RageUI.Visible(AnimalEmotes) and not RageUI.Visible(PropsEmotes) and not RageUI.Visible(SharedEmotes) and not RageUI.Visible(SharedDances) and not RageUI.Visible(WalkingStyles) and not RageUI.Visible(Moods)
        then 
            DrawMyPed = false
            DestroyAllPreviewProps()
            EmotesMenus = RMenu:DeleteType("EmotesMenus")
        end

        Wait(0)
    end
end

FocusPedThread = function(offset)
    if HasFocusPedThread then return end

    HasFocusPedThread = true
    DrawMyPed = true
    Offset = offset

    CreateThread(function() 
        DeleteEntity(PlayerPedPreview)

        PlayerPedPreview = CreatePed(0, GetEntityModel(PlayerPedId()), 0.0, 0.0, 0.0, 0.0, false, false)
        ClonePedToTarget(PlayerPedId(), PlayerPedPreview)
        Entity(PlayerPedPreview).state.deleteOnRestart = true
        SetEntityInvincible(PlayerPedPreview, true)
        SetPedCanBeTargetted(PlayerPedPreview, false)
        SetPedHearingRange(PlayerPedPreview, 0.0)
        SetPedSeeingRange(PlayerPedPreview, 0.0)
        SetPedAlertness(PlayerPedPreview, 0.0)
        SetPedFleeAttributes(PlayerPedPreview, 0, 0)
        SetBlockingOfNonTemporaryEvents(PlayerPedPreview, true)
        SetPedCombatAttributes(PlayerPedPreview, 46, true)
        SetPedFleeAttributes(PlayerPedPreview, 0, 0)
        SetEntityAsMissionEntity(PlayerPedPreview, 1, 1)
        SetEntityCollision(PlayerPedPreview, false, false)
        SetPedMotionBlur(PlayerPedPreview, false)
        FreezeEntityPosition(PlayerPedPreview, true)
        ClearPedTasksImmediately(PlayerPedPreview)

        local cam = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 90.0, 0, 2)

        local PedDist = 2.4

        while DrawMyPed do
            local pos = GetFinalRenderedCamCoord()
            local rot = GetFinalRenderedCamRot(2)

            SetCamCoord(cam, pos)
            SetCamRot(cam, vector3(-rot.x, rot.y, rot.z) + vector3(0, 0, 180.0), 2)
            SetCamFov(cam, math.random(30, 90) + 0.0)

            local camRight, camForward, camUp, camCoords = GetCamMatrix(cam)
            local pedPos = camCoords + camForward * -(PedDist or 2.0) + (camRight * ((Offset and Offset.x or 0.0) + 0.15)) + (camUp * ((Offset and Offset.y or 0.0) + 0.2))
            
            SetEntityMatrix(PlayerPedPreview, camForward*0.5, camRight*0.5, camUp*0.5, pedPos)
            SetEntityVisible(PlayerPedPreview, true)
            SetHidofOverride(false, true, 0.5, 0.4 + 0.2, 0.0, 0.5)

            Wait(0)
        end

        SetHidofOverride(false, true, 0.5, 2.5, 0.0, 0.5)
        DeleteEntity(PlayerPedPreview)
        DestroyCam(cam)
        HasFocusPedThread = false
    end)
end

lastAnim = nil
lastTexture = nil

local previewProps = {}

function playOneTime(anim, v, texture)
    if lastAnim == anim and lastTexture == texture then return end;
    if not PlayerPedPreview then return end;

    PreViewPedEmote(anim, v, PlayerPedPreview, texture)

    lastAnim = anim
    lastTexture = texture
end

function KeyboardInput(TextEntry, MaxStringLength)
    ExampleText = ""

	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

PreViewPedEmote = function(anim, etype, PlayerPedPreview, textureVariation)
    DestroyAllPreviewProps()
    ClearPedTasksImmediately(PlayerPedPreview)

    local InVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
    
    if etype == "dances" then
        if RP.Dances[anim] ~= nil then
            local emotename = RP.Dances[anim]
            local ChosenDict, ChosenAnimation, ename = table.unpack(emotename)
            local animOption = emotename.AnimationOptions

            local MovementType = 0

            if InVehicle == 1 then
                MovementType = 51
            elseif animOption then
                if animOption.EmoteMoving then
                    MovementType = 51
                elseif animOption.EmoteLoop then
                    MovementType = 1
                elseif animOption.EmoteStuck then
                    MovementType = 50
                end
            end

            if animOption and animOption.Prop then 
                PropName = animOption.Prop
                PropBone = animOption.PropBone
                PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(animOption.PropPlacement)
            end

            if animOption and animOption.SecondProp then
                SecondPropName = animOption.SecondProp
                SecondPropBone = animOption.SecondPropBone
                SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(animOption.SecondPropPlacement)
            end

            CreateThread(function() 
                LoadAnim(ChosenDict)

                TaskPlayAnim(PlayerPedPreview, ChosenDict, ChosenAnimation, 5.0, 5.0, -1, MovementType, 0, false, false, false)

                if animOption and animOption.Prop then 
                    if IsModelValid(PropName) then
                        if not HasModelLoaded(PropName) then
                            LoadPropDict(PropName)
                        end
        
                        prop = CreateObject(joaat(PropName), 0, 0, 0 + 0.2, false, false, true)
        
                        --NetworkSetEntityInvisibleToNetwork(prop, true)
        
                        table.insert(previewProps, prop)
        
                        if textureVariation ~= nil then
                            SetObjectTextureVariation(prop, textureVariation)
                        end
        
                        AttachEntityToEntity(prop, PlayerPedPreview, GetPedBoneIndex(PlayerPedPreview, PropBone), PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6, true, true, false, true, 1, true)
        
                        SetModelAsNoLongerNeeded(PropName)
        
                        if animOption and animOption.SecondProp then
                            if not HasModelLoaded(SecondPropName) then
                                LoadPropDict(SecondPropName)
                            end
            
                            Secondprop = CreateObject(joaat(SecondPropName), 0, 0, 0 + 0.2, false, false, true)
                            
                           -- NetworkSetEntityInvisibleToNetwork(Secondprop, true)
        
                            if textureVariation ~= nil then
                                SetObjectTextureVariation(Secondprop, textureVariation)
                            end
        
                            table.insert(previewProps, Secondprop)
            
                            AttachEntityToEntity(Secondprop, PlayerPedPreview, GetPedBoneIndex(PlayerPedPreview, SecondPropBone), SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6, true, true, false, true, 1, true)
            
                            SetModelAsNoLongerNeeded(SecondPropName)
                        end
                    end
                end
            end)
        end
    elseif etype == "props" then
        local emotename = RP.PropEmotes[anim]
        local ChosenDict, ChosenAnimation, ename = table.unpack(emotename)
        local animOption = emotename.AnimationOptions
        
        local MovementType = 0

        if InVehicle == 1 then
            MovementType = 51
        elseif animOption then
            if animOption.EmoteMoving then
                MovementType = 51
            elseif animOption.EmoteLoop then
                MovementType = 1
            elseif animOption.EmoteStuck then
                MovementType = 50
            end
        end

        local PropName = animOption.Prop
        local PropBone = animOption.PropBone
        local PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(animOption.PropPlacement)
        
        if animOption.SecondProp then
            SecondPropName = animOption.SecondProp
            SecondPropBone = animOption.SecondPropBone
            SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(animOption.SecondPropPlacement)
        end

        CreateThread(function() 
            LoadAnim(ChosenDict)
            TaskPlayAnim(PlayerPedPreview, ChosenDict, ChosenAnimation, 5.0, 5.0, -1, MovementType, 0, false, false, false)

            if IsModelValid(PropName) then
                if not HasModelLoaded(PropName) then
                    LoadPropDict(PropName)
                end

                prop = CreateObject(joaat(PropName), 0, 0, 0 + 0.2, false, false, true)

                --NetworkSetEntityInvisibleToNetwork(prop, true)

                table.insert(previewProps, prop)

                if textureVariation ~= nil then
                    SetObjectTextureVariation(prop, textureVariation)
                end

                AttachEntityToEntity(prop, PlayerPedPreview, GetPedBoneIndex(PlayerPedPreview, PropBone), PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6, true, true, false, true, 1, true)

                SetModelAsNoLongerNeeded(PropName)

                if animOption and animOption.SecondProp then
                    if not HasModelLoaded(SecondPropName) then
                        LoadPropDict(SecondPropName)
                    end
    
                    Secondprop = CreateObject(joaat(SecondPropName), 0, 0, 0 + 0.2, false, false, true)
                    
                    --NetworkSetEntityInvisibleToNetwork(Secondprop, true)

                    if textureVariation ~= nil then
                        SetObjectTextureVariation(Secondprop, textureVariation)
                    end

                    table.insert(previewProps, Secondprop)
    
                    AttachEntityToEntity(Secondprop, PlayerPedPreview, GetPedBoneIndex(PlayerPedPreview, SecondPropBone), SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6, true, true, false, true, 1, true)
    
                    SetModelAsNoLongerNeeded(SecondPropName)
                end
            end
        end)
    elseif etype == "emotes" then
        if RP.Emotes[anim] ~= nil then
            local emotename = RP.Emotes[anim]
            local ChosenDict, ChosenAnimation, ename = table.unpack(emotename)
            local animOption = emotename.AnimationOptions

            local MovementType = 0

            if InVehicle == 1 then
                MovementType = 51
            elseif animOption then
                if animOption.EmoteMoving then
                    MovementType = 51
                elseif animOption.EmoteLoop then
                    MovementType = 1
                elseif animOption.EmoteStuck then
                    MovementType = 50
                end
            end

            if animOption and animOption.Prop then 
                PropName = animOption.Prop
                PropBone = animOption.PropBone
                PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(animOption.PropPlacement)
            end
            
            if animOption and animOption.SecondProp then
                SecondPropName = animOption.SecondProp
                SecondPropBone = animOption.SecondPropBone
                SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(animOption.SecondPropPlacement)
            end
            
            CreateThread(function() 
                LoadAnim(ChosenDict)

                TaskPlayAnim(PlayerPedPreview, ChosenDict, ChosenAnimation, 5.0, 5.0, -1, MovementType, 0, false, false, false)

                if animOption and animOption.Prop then 
                    if IsModelValid(PropName) then
                        if not HasModelLoaded(PropName) then
                            LoadPropDict(PropName)
                        end
        
                        prop = CreateObject(joaat(PropName), 0, 0, 0 + 0.2, false, false, true)
        
                        --NetworkSetEntityInvisibleToNetwork(prop, true)
        
                        table.insert(previewProps, prop)
        
                        if textureVariation ~= nil then
                            SetObjectTextureVariation(prop, textureVariation)
                        end
        
                        AttachEntityToEntity(prop, PlayerPedPreview, GetPedBoneIndex(PlayerPedPreview, PropBone), PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6, true, true, false, true, 1, true)
        
                        SetModelAsNoLongerNeeded(PropName)
        
                        if animOption and animOption.SecondProp then
                            if not HasModelLoaded(SecondPropName) then
                                LoadPropDict(SecondPropName)
                            end
            
                            Secondprop = CreateObject(joaat(SecondPropName), 0, 0, 0 + 0.2, false, false, true)
                            
                            --NetworkSetEntityInvisibleToNetwork(Secondprop, true)
        
                            if textureVariation ~= nil then
                                SetObjectTextureVariation(Secondprop, textureVariation)
                            end
        
                            table.insert(previewProps, Secondprop)
            
                            AttachEntityToEntity(Secondprop, PlayerPedPreview, GetPedBoneIndex(PlayerPedPreview, SecondPropBone), SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6, true, true, false, true, 1, true)
            
                            SetModelAsNoLongerNeeded(SecondPropName)
                        end
                    end
                end
            end)
        end
    elseif etype == "shared" then
        if RP.Shared[anim] ~= nil then
            local emotename = RP.Shared[anim]
            local ChosenDict, ChosenAnimation, ename = table.unpack(emotename)

            local MovementType = 0

            if InVehicle == 1 then
                MovementType = 51
            elseif animOption then
                if animOption.EmoteMoving then
                    MovementType = 51
                elseif animOption.EmoteLoop then
                    MovementType = 1
                elseif animOption.EmoteStuck then
                    MovementType = 50
                end
            end
            
            CreateThread(function() 
                LoadAnim(ChosenDict)

                TaskPlayAnim(PlayerPedPreview, ChosenDict, ChosenAnimation, 5.0, 5.0, -1, MovementType, 0, false, false, false)
            end)
        end
    elseif etype == "expression" then
        if RP.Expressions[anim] ~= nil then
            SetFacialIdleAnimOverride(PlayerPedPreview, RP.Expressions[anim][1], 0)
        end
    end
end

function DestroyAllPreviewProps()
    for _, v in pairs(previewProps) do
        DeleteEntity(v)
    end
end