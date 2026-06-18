local cachedUniqueId = nil
local ACCOUNT_NAME = 'bank'

function getPlayerID()
    return cachedUniqueId or GetPlayerServerId(PlayerId())
end

local function getAccountBalance(accounts, targetAccount)
    if not accounts or not targetAccount then
        return 0
    end

    if accounts[targetAccount] then
        local account = accounts[targetAccount]
        if type(account) == 'table' then
            return tonumber(account.money or account.balance or account.total) or 0
        end

        return tonumber(account) or 0
    end

    for _, account in pairs(accounts) do
        if type(account) == 'table' and account.name == targetAccount then
            return tonumber(account.money or account.balance or account.total) or 0
        end
    end

    return 0
end

local function getCashFromAccounts(accounts)
    if not accounts then
        return nil
    end

    local moneyAccount = accounts.money or accounts.cash
    if type(moneyAccount) == 'table' then
        return tonumber(moneyAccount.money or moneyAccount.balance) or 0
    elseif moneyAccount ~= nil then
        return tonumber(moneyAccount) or 0
    end

    for _, account in pairs(accounts) do
        if type(account) == 'table' and (account.name == 'money' or account.name == 'cash') then
            return tonumber(account.money or account.balance) or 0
        end
    end

    return nil
end

local function getPlayerDisplayName(playerData)
    if not playerData then
        return GetPlayerName(PlayerId())
    end

    local firstName = playerData.firstName or playerData.firstname
    local lastName = playerData.lastName or playerData.lastname

    if firstName and lastName then
        return string.format("%s %s", firstName, lastName)
    end

    if playerData.name and playerData.name ~= '' then
        return playerData.name
    end

    if playerData.charinfo and playerData.charinfo.firstname and playerData.charinfo.lastname then
        return string.format("%s %s", playerData.charinfo.firstname, playerData.charinfo.lastname)
    end

    return GetPlayerName(PlayerId())
end

local function getJobLabel(jobData)
    if not jobData then
        return 'Sans emploi'
    end

    if jobData.grade_label and jobData.grade_label ~= '' then
        return jobData.grade_label
    end

    if jobData.label and jobData.label ~= '' then
        return jobData.label
    end

    if jobData.name and jobData.name ~= '' then
        return jobData.name
    end

    return 'Sans emploi'
end

function BuildPauseMenuPlayerInfo(playerDataOverride)
    local playerData = playerDataOverride

    if not playerData and ESX and ESX.GetPlayerData then
        playerData = ESX.GetPlayerData()
    end

    local cash = 0
    local bankMoney = 0

    if playerData then
        cash = tonumber(playerData.money) or cash
        bankMoney = getAccountBalance(playerData.accounts, ACCOUNT_NAME)

        if not playerData.money then
            local cashFromAccounts = getCashFromAccounts(playerData.accounts)
            if cashFromAccounts ~= nil then
                cash = cashFromAccounts
            end
        end
    end

    return {
        id = getPlayerID(),
        cash = math.floor(cash + 0.5),
        money = math.floor(bankMoney + 0.5),
        job = getJobLabel(playerData and playerData.job),
        playerName = getPlayerDisplayName(playerData)
    }
end

CreateThread(function()
    while not ESX do
        Wait(100)
    end

    ESX.TriggerServerCallback('nv_pausemenu:getUniqueId', function(uniqueId)
        cachedUniqueId = uniqueId
    end)
end)