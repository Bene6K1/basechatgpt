bot_Token = ""

local Caches = {
    Avatars = {}
}

bot_Token = bot_Token or ""
local FormattedToken = "Bot " .. bot_Token
function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest(
        "https://discordapp.com/api/" .. endpoint,
        function(errorCode, resultData, resultHeaders)
            data = { data = resultData, code = errorCode, headers = resultHeaders }
        end,
        method,
        #jsondata > 0 and json.encode(jsondata) or "",
        { ["Content-Type"] = "application/json", ["Authorization"] = FormattedToken }
    )

    while data == nil do
        Citizen.Wait(0)
    end

    return data
end

function GetDiscordAvatar(user)
    local discordId = nil
    local imgURL = nil
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end

    if discordId then
        if Caches.Avatars[discordId] == nil then
            local endpoint = ("users/%s"):format(discordId)
            local member = DiscordRequest("GET", endpoint, {})

            if member.code == 200 then
                local data = json.decode(member.data)
                if data ~= nil and data.avatar ~= nil then
                    if (data.avatar:sub(1, 1) and data.avatar:sub(2, 2) == "_") then
                        imgURL = "https://media.discordapp.net/avatars/" .. discordId .. "/" .. data.avatar .. ".gif"
                    else
                        imgURL = "https://media.discordapp.net/avatars/" .. discordId .. "/" .. data.avatar .. ".png"
                    end
                end
            end
            Caches.Avatars[discordId] = imgURL
        else
            imgURL = Caches.Avatars[discordId]
        end
    end
    return imgURL
end

Citizen.CreateThread(function()
    while frameworkObject == nil do
        Citizen.Wait(0)
    end

    RegisterCallback('oph3z-bank:server:GetPlayerBilling', function(source, cb)
        local src = source
        local identifier = GetIdentifier(src)
        local billTable = {}
        if Config.BillingScript == 'qbdefault' then
            local result = ExecuteSql("SELECT * FROM `phone_invoices` WHERE `citizenid` = '"..identifier.."'")
            if result and result[1] then
                for i = 1, #result do
                    local data = {}
                    data.id = result[i].id or '-'
                    data.identifier = result[i].citizenid or '-'
                    data.description = result[i].society or result[i].sender or result[i].sendercitizenid or '-'
                    data.amount = result[i].amount or '-'
                    data.label = result[i].invoicelabel or result[i].society or 'Invoice'
                    data.date = result[i].date or 'Unknown date'
                    table.insert(billTable, data)
                end
                cb(billTable)
            else
                cb(billTable)
            end
        elseif Config.BillingScript == 'esxdefault' then
            local result = ExecuteSql("SELECT * FROM `billing` WHERE `identifier` = '"..identifier.."'")
            if result and result[1] then
                for i = 1, #result do
                    local data = {}
                    data.id = result[i].id or '-'
                    data.identifier = result[i].identifier or '-'
                    data.description = result[i].name or result[i].target or result[i].sender or '-'
                    data.amount = result[i].amount or '-'
                    data.label = result[i].label or result[i].target or 'Invoice'
                    data.date = result[i].date or 'Unknown date'
                    table.insert(billTable, data)
                end
                cb(billTable)
            else
                cb(billTable)
            end
        end
    end)
end)

if Config.BillingScript == 'qbdefault' then
    RegisterNetEvent('oph3z-bank:payBill', function(billData)
        local src = source
        if billData then
            local result = ExecuteSql("SELECT * FROM `phone_invoices` WHERE `id` = '"..billData.id.."'")
            if result and result[1] then
                RemoveMoney(src, 'bank', tonumber(billData.amount))
                if Config.newManagementSystem then
                    local account_money = exports["qb-banking"]:GetAccount(result[1].society)
                    if account_money and account_money.account_balance then
                        exports["qb-banking"]:AddMoney(result[1].society, tonumber(billData.amount))
                    else
                        if Config.CreateJobAccount then
                            exports["qb-banking"]:CreateJobAccount(result[1].society, 0)
                            Wait(350)
                            exports["qb-banking"]:AddMoney(result[1].society, tonumber(billData.amount))
                        end
                    end
                else
                    exports['qb-management']:AddMoney(result[1].society, tonumber(billData.amount))
                end
                ExecuteSql("DELETE FROM `phone_invoices` WHERE `id` = '" .. billData.id .. "'")
                SendTransactions(GetIdentifier(src), {
                    type = 'remove',
                    action = 'billing',
                    label = 'Billing',
                    date = os.date("%d.%m.%Y"),
                    description = Locales[Config.Language]['transaction_bill_paid']:gsub('${amount}', '$' .. billData.amount),
                    amount = billData.amount,
                    source = 'otherexpenses'
                }, src)
                TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
                TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['bill_paid_success'], 'success', 2000)
            end
        end
    end)
elseif Config.BillingScript == 'esxdefault' then
    RegisterNetEvent('oph3z-bank:payBill', function(billData)
        local src = source
        if billData then
            TriggerEvent('esx_billing:payBill', src, billData.id)
            RemoveMoney(src, 'bank', tonumber(billData.amount))
            TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
            TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['bill_paid_success'], 'success', 2000)
            SendTransactions(GetIdentifier(src), {
                type = 'remove',
                action = 'billing',
                label = 'Billing',
                date = os.date("%d.%m.%Y"),
                description = Locales[Config.Language]['transaction_bill_paid']:gsub('${amount}', '$' .. billData.amount),
                amount = billData.amount,
                source = 'otherexpenses'
            }, src)
        end
    end)
end