---@diagnostic disable: duplicate-set-field
local Config <const> = require 'dist.modules.[World].nv_keys.config.main'

local resourceName = 'nv_interact'
local configValue = Config.Target

local resourceMissing = GetResourceState(resourceName) == 'missing'
if resourceMissing then return end

local shouldLoad = false
if configValue == 'auto' then
    shouldLoad = GetResourceState(resourceName) == 'started'
else
    shouldLoad = configValue == resourceName
end

if not shouldLoad then return end
if GetResourceState(resourceName) ~= 'started' then return end

Target = Target or {}

local interactExports = exports[resourceName]
local activeInteractions = {}

Target.FixOptions = function(options)
    for k, v in ipairs(options) do
        local action = v.onSelect or v.action
        options[k].onSelect = function(entityOrData)
            if not action then return end
            if type(entityOrData) == 'table' then
                return action(entityOrData.entity)
            end
            return action(entityOrData)
        end
    end
    return options
end

local function openOptionMenu(entity, options)
    if #options == 0 then return end

    if #options == 1 or not lib or not lib.registerContext then
        return options[1].onSelect(entity)
    end

    local menuId = ('nvkeys_interact_%s'):format(entity)
    local ctxOptions = {}
    for _, option in ipairs(options) do
        ctxOptions[#ctxOptions + 1] = {
            title = option.label or option.name or _T('context_menu.header'),
            icon = option.icon,
            onSelect = function()
                option.onSelect(entity)
            end
        }
    end

    lib.registerContext({
        id = menuId,
        title = _T('context_menu.header'),
        options = ctxOptions
    })
    lib.showContext(menuId)
end

local function addInteractionForEntity(entity, options)
    if not DoesEntityExist(entity) then return end
    local coords = GetEntityCoords(entity)
    local label = (options[1] and (options[1].label or options[1].name)) or _T('context_menu.header')
    local icon = options[1] and options[1].icon or 'fa-solid fa-key'

    local interactionId = interactExports:addInteractionPoint({
        coords = vector3(coords.x, coords.y, coords.z + 1.0),
        dist = 2.0,
        key = Config.Keys.locksmith and Config.Keys.locksmith.name or 'E',
        message = label,
        icon = icon,
        onPress = function()
            openOptionMenu(entity, options)
        end
    })

    if interactionId then
        activeInteractions[entity] = interactionId
    end
end

Target.AddLocalEntity = function(entities, options)
    options = Target.FixOptions(options or {})
    if type(entities) ~= 'table' then
        entities = { entities }
    end

    for _, entity in ipairs(entities) do
        addInteractionForEntity(entity, options)
    end
end

Target.RemoveLocalEntity = function(entities)
    if type(entities) ~= 'table' then
        entities = { entities }
    end

    for _, entity in ipairs(entities) do
        local interactionId = activeInteractions[entity]
        if interactionId then
            interactExports:removeInteractionPoint(interactionId)
            activeInteractions[entity] = nil
        end
    end
end

Target.AddGlobalPlayer = function()
    if Config.Debug then
        print('[nv_keys] nv_interact target module does not support AddGlobalPlayer')
    end
end

Target.AddGlobalVehicle = Target.AddGlobalPlayer
Target.RemoveGlobalVehicle = Target.AddGlobalPlayer
Target.AddModel = Target.AddGlobalPlayer
Target.AddBoxZone = Target.AddGlobalPlayer
Target.AddSphereZone = Target.AddGlobalPlayer
Target.RemoveZone = Target.AddGlobalPlayer
Target.RemoveModel = Target.AddGlobalPlayer
Target.AddGlobalPed = Target.AddGlobalPlayer
Target.RemoveGlobalPed = Target.AddGlobalPlayer
Target.AddNetworkedEntity = Target.AddGlobalPlayer
Target.RemoveNetworkedEntity = Target.AddGlobalPlayer

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for entity, interactionId in pairs(activeInteractions) do
        interactExports:removeInteractionPoint(interactionId)
        activeInteractions[entity] = nil
    end
end)

return Target

