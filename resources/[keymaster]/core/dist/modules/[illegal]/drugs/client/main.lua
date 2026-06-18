CreateThread(function()
    local loaded = false
    local interactionIds = {}
    local isProcessing = false
    local handleDrugInteraction
    local activeSpawns = {}
    local maxActiveSpawns = (SunnyDrugs.Settings and SunnyDrugs.Settings.maxActiveSpawns) or 3

    local function targetAvailable()
        return GetResourceState and GetResourceState('nv_interact') == 'started'
    end

    local function removeEntryInteraction(entry)
        if entry and entry.interactionId then
            exports['nv_interact']:removeInteractionPoint(entry.interactionId)
            interactionIds[entry.id] = nil
            entry.interactionId = nil
        end
    end

    local function spawnEntryProp(drugName, phase, entry)
        if not entry then return end
        local itemData = SunnyDrugs.Items[drugName] and SunnyDrugs.Items[drugName][phase]
        if not itemData or itemData.marker or not itemData.props then
            return
        end

        local coords = entry.coords
        if not coords then return end

        ESX.Game.SpawnLocalObject(itemData.props, vector3(coords.x, coords.y, coords.z - 0.98), function(obj)
            if DoesEntityExist(obj) then
                FreezeEntityPosition(obj, true)
                entry.propHandle = obj
                SunnyDrugs.objSpawn[obj] = obj
            end
        end)
    end

    local function clearEntryProp(entry)
        if entry and entry.propHandle and DoesEntityExist(entry.propHandle) then
            DeleteObject(entry.propHandle)
            SunnyDrugs.objSpawn[entry.propHandle] = nil
            entry.propHandle = nil
        end
    end

    local function registerEntryInteraction(drugName, phase, entry)
        if not targetAvailable() then
            removeEntryInteraction(entry)
            return
        end

        local itemData = SunnyDrugs.Items[drugName] and SunnyDrugs.Items[drugName][phase]
        if not (entry and entry.coords and itemData) then
            removeEntryInteraction(entry)
            return
        end

        removeEntryInteraction(entry)

        entry.interactionId = exports['nv_interact']:addInteractionPoint({
            coords = vector3(entry.coords.x, entry.coords.y, entry.coords.z),
            dist = 1.6,
            key = 'E',
            message = itemData.label or ('Récolter ' .. phase),
            icon = itemData.icon or 'fa-cannabis',
            onPress = function()
                if handleDrugInteraction then
                    handleDrugInteraction(drugName, phase, entry.id)
                end
            end
        })

        interactionIds[entry.id] = entry.interactionId
    end

    local function chooseRandomCoords(drugName, phase, exclude)
        local pool = SunnyDrugs.Drugs[drugName] and SunnyDrugs.Drugs[drugName][phase]
        if not (pool and #pool > 0) then return nil end

        local attempts = 0
        while attempts < 20 do
            local idx = math.random(#pool)
            if not exclude or not exclude[idx] then
                return pool[idx], idx
            end
            attempts = attempts + 1
        end

        local idx = math.random(#pool)
        return pool[idx], idx
    end

    local function rebuildPhaseSpawns(drugName, phase)
        local pool = SunnyDrugs.Drugs[drugName] and SunnyDrugs.Drugs[drugName][phase]
        if not (pool and #pool > 0) then
            activeSpawns[phase .. drugName] = nil
            return
        end

        if activeSpawns[phase .. drugName] then
            for _, entry in ipairs(activeSpawns[phase .. drugName]) do
                clearEntryProp(entry)
                removeEntryInteraction(entry)
            end
        end

        activeSpawns[phase .. drugName] = {}
        local desired = math.min(#pool, maxActiveSpawns)
        local used = {}

        for i = 1, desired do
            local coords, idx = chooseRandomCoords(drugName, phase, used)
            if not coords then break end
            used[idx] = true

            local entry = {
                coords = coords,
                poolIndex = idx,
                id = ("%s_%s_%s"):format(drugName, phase, i .. '_' .. math.random(1000, 9999))
            }

            table.insert(activeSpawns[phase .. drugName], entry)
            spawnEntryProp(drugName, phase, entry)
            registerEntryInteraction(drugName, phase, entry)
        end
    end

    local function refreshEntry(drugName, phase, entry)
        if not entry then return end

        local key = phase .. drugName
        local used = {}
        if entry.poolIndex then
            used[entry.poolIndex] = true
        end
        if activeSpawns[key] then
            for _, other in ipairs(activeSpawns[key]) do
                if other ~= entry and other.poolIndex then
                    used[other.poolIndex] = true
                end
            end
        end

        clearEntryProp(entry)
        removeEntryInteraction(entry)

        local coords, idx = chooseRandomCoords(drugName, phase, used)
        if coords then
            entry.coords = coords
            entry.poolIndex = idx
        else
            -- si aucune nouvelle coordonnée valide n'a pu être trouvée,
            -- on réutilise l'ancienne pour éviter de laisser le point vide.
            local fallbackCoords, fallbackIdx = chooseRandomCoords(drugName, phase, nil)
            if fallbackCoords then
                entry.coords = fallbackCoords
                entry.poolIndex = fallbackIdx
            end
        end

        spawnEntryProp(drugName, phase, entry)
        registerEntryInteraction(drugName, phase, entry)
    end

    local function getEntry(drugName, phase, entryId)
        local list = activeSpawns[phase .. drugName]
        if not list then return nil end
        for _, entry in ipairs(list) do
            if entry.id == entryId then
                return entry
            end
        end
    end

    local function refreshDrugInteractions(drugName)
        if not SunnyDrugs.Drugs[drugName] then
            return
        end

        for phase in pairs(SunnyDrugs.Drugs[drugName]) do
            local list = activeSpawns[phase .. drugName]
            if list then
                for _, entry in ipairs(list) do
                    registerEntryInteraction(drugName, phase, entry)
                end
            end
        end
    end

    local function refreshAllInteractions()
        if not targetAvailable() then
            return
        end

        for drugName in pairs(SunnyDrugs.Drugs) do
            refreshDrugInteractions(drugName)
        end
    end

    local function clearDrugInteractions()
        for _, list in pairs(activeSpawns) do
            for _, entry in ipairs(list) do
                clearEntryProp(entry)
                removeEntryInteraction(entry)
            end
        end
        activeSpawns = {}
    end

    RegisterNetEvent('sunny:drugs:load', function(table)
        for k,v in pairs(table) do
            SunnyDrugs.Drugs[v.name] = {
                ["recolte"] = v.position.recolte,
                ["recolte1"] = v.position.recolte1,
                ["recolte2"] = v.position.recolte2,
                ["recolte3"] = v.position.recolte3,
                ["recolte4"] = v.position.recolte4,
                ["traitement"] = v.position.traitement
            }
            SunnyDrugs.Items[v.name] = {
                ["recolte"] = {
                    name = v.data.recolte.name,
                    label = v.data.recolte.label,
                    animtype = v.data.recolte.animtype,
                    animdict = v.data.recolte.animdict,
                    anim = v.data.recolte.anim,
                    animtime = v.data.recolte.animtime,
                    marker = v.data.recolte.marker,
                    props = v.data.recolte.props
                },
                ["recolte1"] = {
                    name = v.data.recolte1.name,
                    label = v.data.recolte1.label,
                    animtype = v.data.recolte1.animtype,
                    animdict = v.data.recolte1.animdict,
                    anim = v.data.recolte1.anim,
                    animtime = v.data.recolte1.animtime,
                    marker = v.data.recolte1.marker,
                    props = v.data.recolte1.props
                },
                ["recolte2"] = {
                    name = v.data.recolte2.name,
                    label = v.data.recolte2.label,
                    animtype = v.data.recolte2.animtype,
                    animdict = v.data.recolte2.animdict,
                    anim = v.data.recolte2.anim,
                    animtime = v.data.recolte2.animtime,
                    marker = v.data.recolte2.marker,
                    props = v.data.recolte2.props
                },
                ["recolte3"] = {
                    name = v.data.recolte3.name,
                    label = v.data.recolte3.label,
                    animtype = v.data.recolte3.animtype,
                    animdict = v.data.recolte3.animdict,
                    anim = v.data.recolte3.anim,
                    animtime = v.data.recolte3.animtime,
                    marker = v.data.recolte3.marker,
                    props = v.data.recolte3.props
                },
                ["recolte4"] = {
                    name = v.data.recolte4.name,
                    label = v.data.recolte4.label,
                    animtype = v.data.recolte4.animtype,
                    animdict = v.data.recolte4.animdict,
                    anim = v.data.recolte4.anim,
                    animtime = v.data.recolte4.animtime,
                    marker = v.data.recolte4.marker,
                    props = v.data.recolte4.props
                },
                ["traitement"] = {
                    name = v.data.traitement.name,
                    label = v.data.traitement.label,
                    animtype = v.data.traitement.animtype,
                    animdict = v.data.traitement.animdict,
                    anim = v.data.traitement.anim,
                    animtime = v.data.traitement.animtime,
                    marker = v.data.traitement.marker,
                    props = v.data.traitement.props
                }
            }

            TriggerServerEvent('sunny:drugs:addTable', SunnyDrugs.Items)
        end
    
        loaded = true
    end)

    RegisterNetEvent('sunny:drugs:refresh', function(drugName)
        local drugConfig = SunnyDrugs.Drugs[drugName]
        if not drugConfig then return end

        for phase in pairs(drugConfig) do
            rebuildPhaseSpawns(drugName, phase)
        end
    end)
    
    Wait(1000)

    TriggerServerEvent('sunny:drugs:load')

    while not loaded do Wait(1) end

    function SunnyDrugs:drugs(item, type)
        Player.playerPed = PlayerPedId()
        local ped = Player.playerPed
    
        ClearPedTasksImmediately(Player.playerPed)
        FreezeEntityPosition(ped, true)
    
        if SunnyDrugs.Items[item][type].animtype == 'anim' then
            local dict, anim = SunnyDrugs.Items[item][type].animdict, SunnyDrugs.Items[item][type].anim
    
            ESX.Streaming.RequestAnimDict(dict)
            TaskPlayAnim(ped, dict, anim, -1.0, -1.0, 3000, 0, 0, true, true, true)
        else
            TaskStartScenarioInPlace(ped, 'PROP_HUMAN_BUM_BIN', 0, true)
        end
    
        Citizen.Wait(SunnyDrugs.Items[item][type].animtime)
    
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
    
        TriggerServerEvent('sunny:drugs:drugs', item, type)
    end
    
    handleDrugInteraction = function(drugName, phase, entryId)
        if isProcessing then
            return
        end

        local phasePool = SunnyDrugs.Drugs[drugName] and SunnyDrugs.Drugs[drugName][phase]
        local itemData = SunnyDrugs.Items[drugName] and SunnyDrugs.Items[drugName][phase]

        if not (phasePool and itemData and #phasePool > 0) then
            return
        end

        local entry = getEntry(drugName, phase, entryId)
        if not entry then
            return
        end

        isProcessing = true

        SunnyDrugs:drugs(drugName, phase)
        refreshEntry(drugName, phase, entry)

        isProcessing = false
    end
    
    CreateThread(function()
    
        for drugName in pairs(SunnyDrugs.Drugs) do
            for phase in pairs(SunnyDrugs.Drugs[drugName]) do
                rebuildPhaseSpawns(drugName, phase)
            end
        end
        
        while true do 
            Wait(SunnyDrugs.Wait)
            SunnyDrugs.Wait = 2000
            
            local ped = PlayerPedId()
            local useTarget = targetAvailable()

            for drugName,_ in pairs(SunnyDrugs.Drugs) do
                for phase,_ in pairs(SunnyDrugs.Drugs[drugName]) do
                    local entries = activeSpawns[phase .. drugName]
                    if entries then
                        for _, entry in ipairs(entries) do
                            local currentZone = entry.coords
                            if not currentZone then goto continue end

                            local distance = #(GetEntityCoords(ped)-vector3(currentZone.x, currentZone.y, currentZone.z))
    
                            if distance > 25.0 then goto continue end
    
                    SunnyDrugs.Wait = 1
    
                            if SunnyDrugs.Items[drugName][phase].marker then
                                DrawMarker(21, currentZone.x, currentZone.y, currentZone.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, tonumber(UTILS.ServerColor.r), tonumber(UTILS.ServerColor.g), tonumber(UTILS.ServerColor.b), 255, false, false, 2, false, false, false, false)
                    end
    
                            if (not useTarget) and distance < 1.5 then
                                DrawInstructionBarNotification(currentZone.x, currentZone.y, currentZone.z, "Appuyez sur [E] pour intéragir")
                        if IsControlJustPressed(1,51) then
                                    if handleDrugInteraction then
                                        handleDrugInteraction(drugName, phase, entry.id)
                            end
                        end
                    end
    
                    ::continue::
                        end
                    end
                end
            end
        end
    end)
    
    AddEventHandler('onResourceStop', function(resourceName)
        if resourceName ~= GetCurrentResourceName() then
            return
        end

        for k,v in pairs(SunnyDrugs.objSpawn) do
            DeleteObject(v)
            SunnyDrugs.objSpawn[k] = nil
        end

        clearDrugInteractions()
    end)
end)