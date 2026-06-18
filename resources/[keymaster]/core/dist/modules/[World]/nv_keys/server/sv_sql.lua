local Config <const> = require 'dist.modules.[World].nv_keys.config.main'

local QB_DATABASES = {
    ["player_vehicles"] = [[
        ALTER TABLE player_vehicles
            ADD COLUMN `key_id` int DEFAULT 0
    ]],
}

local function ensureQBDatabaseUpdates()
    if not Config.AutoRunSQL then return end

    Debug('info', 'Checking QB database updates...')
    for tableName, alterSQL in pairs(QB_DATABASES) do
        local result = MySQL.query.await("SHOW COLUMNS FROM ?? LIKE 'key_id'", { tableName })

        if result and #result > 0 then
            Debug('info', "QB Database Already Updated: %s", tableName)
        else
            MySQL.query.await(alterSQL)
            Debug('info', "Updated QB Database Table: %s", tableName)
        end
    end
    Debug('info', 'QB database updates checked')
end

local ESX_DATABASES = {
    ["owned_vehicles"] = [[
        ALTER TABLE owned_vehicles
            ADD COLUMN `key_id` int DEFAULT 0
    ]],
}

local function ensureESXDatabaseUpdates()
    if not Config.AutoRunSQL then return end

    Debug('info', 'Checking ESX database updates...')
    for tableName, alterSQL in pairs(ESX_DATABASES) do
        local result = MySQL.query.await("SHOW COLUMNS FROM ?? LIKE 'key_id'", { tableName })

        if result and #result > 0 then
            Debug('info', "ESX Database Already Updated: %s", tableName)
        else
            MySQL.query.await(alterSQL)
            Debug('info', "Updated ESX Database Table: %s", tableName)
        end
    end
    Debug('info', 'ESX database updates checked')
end

AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        local frameworkName = Framework.GetFrameworkName()

        if frameworkName == "es_extended" then
            ensureESXDatabaseUpdates()
        else
            ensureQBDatabaseUpdates()
        end
    end
end)
