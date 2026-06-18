local FRAMEWORK = 'esx'
local ACCOUNT_NAME = 'bank'
function getAccountMoney(player)
    if FRAMEWORK ~= 'esx' then
        return 0
    end

    local xPlayer = ESX.GetPlayerFromId(player)
    if not xPlayer then
        return 0
    end

    local accountData = xPlayer.getAccount(ACCOUNT_NAME)
    if not accountData then
        return 0
    end

    return accountData.money or 0
end

if FRAMEWORK == 'esx' then
    ESX.RegisterServerCallback('nv_pausemenu:getUniqueId', function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then
            cb(nil)
            return
        end

        local uniqueId = nil
        if xPlayer.getUniqueID then
            uniqueId = xPlayer.getUniqueID()
        elseif xPlayer.UniqueID then
            uniqueId = xPlayer.UniqueID
        end

        if not uniqueId and xPlayer.getIdentifier then
            uniqueId = xPlayer.getIdentifier()
        end

        cb(uniqueId)
    end)
end
