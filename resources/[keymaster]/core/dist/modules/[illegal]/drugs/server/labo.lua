CreateThread(function()
    local _LabsSystem = {}
    _LabsSystem.labsList = {}

    RegisterNetEvent('sunny:labs:requireLabsInteriors', function(e)
        _LabsSystem.labsList = e
    end)

    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS `illegal_laboratory` (
            `id` INT AUTO_INCREMENT PRIMARY KEY,
            name LONGTEXT DEFAULT NULL,
            type LONGTEXT DEFAULT NULL,
            interior LONGTEXT DEFAULT NULL,
            owner LONGTEXT DEFAULT NULL,
            pos VARCHAR(255) DEFAULT NULL
        );
    ]])

    function _LabsSystem:setPlayerInstance(src,id)
        SetPlayerRoutingBucket(src, id)
    end

    RegisterNetEvent('sunny:labs:enter', function(id)
        local source = source

        _LabsSystem:setPlayerInstance(source,id)
        TriggerClientEvent('sunny:labs:enter', source, drugs_laboratories[id].type, _LabsSystem.labsList[drugs_laboratories[id].type].exit, id)
    end)

    RegisterNetEvent('sunny:labs:exit', function(id)
        local source = source

        _LabsSystem:setPlayerInstance(source, 0)

        TriggerClientEvent('sunny:labs:exit', source, drugs_laboratories[id].type, drugs_laboratories[id].pos, id)
    end)
end)