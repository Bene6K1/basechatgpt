---@diagnostic disable: duplicate-set-field
local Config <const> = require 'dist.modules.[World].nv_keys.config.main'

local resourceName = 'notif'
local configValue = Config.Notify

local shouldLoad = false
if configValue == 'auto' then
    shouldLoad = GetResourceState(resourceName) == 'started'
else
    shouldLoad = configValue == resourceName
end

if not shouldLoad or GetResourceState(resourceName) ~= 'started' then return end

Notify = Notify or {}

local typeMap = {
    success = 'success',
    info = 'info',
    primary = 'info',
    error = 'error',
    warning = 'warning',
    warn = 'warning'
}

local function convertType(_type)
    if not _type then return 'info' end
    local key = string.lower(_type)
    return typeMap[key] or 'info'
end

Notify.GetResourceName = function()
    return resourceName
end

Notify.SendNotify = function(message, _type, time)
    local notifyTime = (time or 3000) / 1000
    if notifyTime >= 100 then
        notifyTime = 8.5
    end
    return exports[resourceName]:Send(message, notifyTime, convertType(_type))
end

RegisterNetEvent(Scriptname .. ':client:Notify', function(message, _type, time)
    Notify.SendNotify(message, _type, time)
end)

return Notify

