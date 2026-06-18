frameworkObject = nil
scriptStartedCheck = false

Citizen.CreateThread(function()
    frameworkObject, Config.Framework = GetCore()
    while frameworkObject == nil do
        Citizen.Wait(0)
    end
end)

function DebugPrint(msg)
    if Config.Debug then
        print(('[pixel-advancedbanking - DEBUG] %s'):format(msg))
    end
end

Citizen.CreateThread(function()
    RegisterCallback('oph3z-bank:CheckAccountExistens', function(source, cb)
        local src = source
        local identifier = GetIdentifier(src)
        local attempts = 0

        while (not identifier or identifier == "") and attempts < 20 do
            Citizen.Wait(250)
            attempts = attempts + 1
            identifier = GetIdentifier(src)
        end
        
        if not identifier or identifier == "" then
            cb(false)
            return
        end
        
        local database = ExecuteSql("SELECT * FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")
        
        if database and #database > 0 then
            cb(true)
        else
            cb(false)
        end
    end)

    RegisterCallback('oph3z-bank:GetPlayerData', function(source, cb)
        local src = source
        local identifier = GetIdentifier(src)
        local data = ExecuteSql("SELECT * FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")

        if #data > 0 then
            DebugPrint("GetPlayerData - data is coming")
            local info = json.decode(data[1].info)
            local credit = json.decode(data[1].active_credits or '{"creditpoint":' .. Config.StartCreditPoint .. ',"activecredit":[]}')

            info.playerpp = ''

            DataTable = {
                PlayerInformation = {
                    Firstname = info.firstname,
                    Lastname = info.lastname,
                    ProfilePicture = info.playerpp,
                    ID = src,
                    IBAN = data[1].iban,
                    Balance = GetPlayerMoney(src, 'bank'),
                    Cash = GetPlayerMoney(src, 'cash'),
                    CryptoHoldings = json.decode(data[1].crypto_holdings or '[]'),
                    ActiveCredits = credit.activecredit,
                    CreditPoint = credit.creditpoint or data[1].credit_score or Config.StartCreditPoint,
                    ActiveSavingAccounts = json.decode(data[1].savings_accounts_data or '[]'),
                    Requests = json.decode(data[1].requests or '[]'),
                    Notification = json.decode(data[1].notifications or '[]'),
                    AccountUsed = json.decode(data[1].account_used or '{"loginlimit":' .. Config.HackSettings.LoginLimit .. ',"withdrawlimit":' .. Config.HackSettings.WithdrawLimit .. '}'),
                    AccountOwner = true,
                    AccountExist = true
                },
                Transactions = data[1].transactions
            }
            cb(DataTable)
            DebugPrint(json.encode(DataTable), 74)
        else
            DebugPrint("GetPlayerData - Data does not exist.")
        end
    end)

    RegisterCallback('oph3z-bank:GetTargetAccountData', function(source, cb, newData)
        local src = source
        local identifier = GetIdentifier(src)
        local data = ExecuteSql("SELECT `uuid`, `iban`, `password`, `account_used`, `info`, `transactions` FROM `nv_banking_data` WHERE `iban` = '"..newData.iban.."'")
        local result = ExecuteSql("SELECT `iban` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")

        local password = data[1].password
        if tonumber(result[1].iban) == tonumber(data[1].iban) then
            TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['atm_your_account'], 'error', 5000)
            return
        end

        if tonumber(password) == tonumber(newData.password) then
            local account_used = json.decode(data[1].account_used)
            if account_used.loginlimit > 0 then
                if #data > 0 then
                    local info = json.decode(data[1].info)
                    DataTable = {
                        PlayerInformation = {
                            Firstname = info.firstname,
                            Lastname = info.lastname,
                            ProfilePicture = info.playerpp,
                            ID = '-',
                            IBAN = data[1].iban,
                            Balance = GetPlayerMoneyOffline(data[1].uuid),
                            Cash = '-',
                            AccountOwner = false,
                            AccountUsed = json.decode(data[1].account_used),
                            AccountExist = nil
                        },
                        Transactions = data[1].transactions
                    }
                    account_used.loginlimit = account_used.loginlimit - 1
                    ExecuteSql("UPDATE `nv_banking_data` SET `account_used` = '"..json.encode(account_used).."' WHERE `iban` = '"..newData.iban.."'")
                    cb(DataTable)
                end
            else
                cb('account_used')
            end
        else
            cb('bilgi')
        end
    end)
end)

RegisterNetEvent('oph3z-bank:server:CreateAccount', function()
    local src = source
    local identifier = GetIdentifier(src)
    local database = ExecuteSql("SELECT * FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")
    
    if database and #database > 0 then
        TriggerClientEvent('oph3z-bank:OpenBank', src)
        return
    end
    
    local PlayerData = {
        Firstname = GetNameSeparately('firstname', src),
        Lastname = GetNameSeparately('lastname', src)
    }
    TriggerClientEvent('oph3z-bank:client:CreateAccount', src, PlayerData)
end)

RegisterNetEvent('oph3z-bank:RegisterAccount', function(password)
    local src = source
    RegisterAccount = {
        identifier = GetIdentifier(src),
        info = {
            firstname = GetNameSeparately('firstname', src),
            lastname = GetNameSeparately('lastname', src),
            playerpp = ''
        },
        credit = {
            creditpoint = Config.StartCreditPoint,
            activecredit = {}
        },
        transactions = {},
        crypto_holdings = {},
        savings_accounts_data = {},
        requests = {},
        notifications = {},
        iban = math.random(1000, 9999),
        password = password,
        account_used = {
            loginlimit = Config.HackSettings.LoginLimit,
            withdrawlimit = Config.HackSettings.WithdrawLimit
        }
    }
    TriggerClientEvent('oph3z-bank:CloseUI', src)
    ExecuteSql("INSERT INTO `nv_banking_data` (`uuid`, `info`, `active_credits`, `transactions`, `crypto_holdings`, `savings_balance`, `requests`, `notifications`, `iban`, `password`, `account_used`, `credit_score`) VALUES ('"..RegisterAccount.identifier.."', '"..json.encode(RegisterAccount.info).."', '"..json.encode(RegisterAccount.credit).."', '"..json.encode(RegisterAccount.transactions).."', '"..json.encode(RegisterAccount.crypto_holdings).."', 0, '"..json.encode(RegisterAccount.requests).."', '"..json.encode(RegisterAccount.notifications).."', '"..RegisterAccount.iban.."', '"..RegisterAccount.password.."', '"..json.encode(RegisterAccount.account_used).."', "..Config.StartCreditPoint..")")
    TriggerClientEvent('oph3z-bank:UpdateAccountStatus', src, true)
    Config.Notification(Locales[Config.Language]['account_created'], 'success', true, src)
end)

RegisterNetEvent('oph3z-bank:DepositMoney', function(amount)
    local src = source
    local Player = GetPlayer(src)
    local PlayerMoney = GetPlayerMoney(src, 'cash')

    local creditCheck = CheckPlayerCredits(src)
    if creditCheck.hasOverdue then
        TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['overdue_credit_error'], 'error', 5000)
        return
    end

    if tonumber(amount) > 0 then
        if tonumber(PlayerMoney) >= tonumber(amount) then
            RemoveMoney(src, 'cash', tonumber(amount))
            AddMoney(src, 'bank', tonumber(amount))
            SendTransactions(GetIdentifier(src), {
                type = 'add',
                action = 'deposit',
                label = Locales[Config.Language]['deposit'],
                date = os.date("%d.%m.%Y"),
                description = Locales[Config.Language]['transaction_deposited']:gsub('${amount}', '$' .. amount),
                amount = amount,
                source = 'deposit'
            }, src)
            TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
        end
    end
end)

RegisterNetEvent('oph3z-bank:WithdrawMoney', function(amount)
    local src = source
    local Player = GetPlayer(src)
    local PlayerMoney = GetPlayerMoney(src, 'bank')
    
    local creditCheck = CheckPlayerCredits(src)
    if creditCheck.hasOverdue then
        TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['overdue_credit_error'], 'error', 5000)
        return
    end

    if tonumber(amount) > 0 then
        if tonumber(PlayerMoney) >= tonumber(amount) then
            RemoveMoney(src, 'bank', tonumber(amount))
            AddMoney(src, 'cash', tonumber(amount))
            SendTransactions(GetIdentifier(src), {
                type = 'remove',
                action = 'withdraw',
                label = Locales[Config.Language]['withdraw'],
                date = os.date("%d.%m.%Y"),
                description = Locales[Config.Language]['transaction_withdrawn']:gsub('${amount}', '$' .. amount),
                amount = amount,
                source = 'withdraw'
            }, src)
            TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
        end
    end
end)

RegisterNetEvent('oph3z-bank:TransferMoneyByIBAN', function(data)
    local src = source
    local amount = tonumber(data.amount)
    local description = data.description
    local iban = data.iban
    local playerIBAN = data.playerIBAN
    local PlayerMoney = GetPlayerMoney(src, 'bank')

    local creditCheck = CheckPlayerCredits(src)
    if creditCheck.hasOverdue then
        TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['overdue_credit_error'], 'error', 5000)
        return
    end

    if amount > 0 then
        if tonumber(PlayerMoney) >= amount then
            local targetData = ExecuteSql("SELECT identifier, info FROM `nv_banking_data` WHERE `iban` = '"..iban.."' LIMIT 1")
            if targetData and #targetData > 0 then
                if tonumber(iban) ~= tonumber(playerIBAN) then
                    RemoveMoney(src, 'bank', amount)
                    local targetPlayerSource = GetPlayerSourceByIdentifier(tostring(targetData[1].identifier))
                    if tonumber(targetPlayerSource) ~= 0 then
                        AddMoney(targetPlayerSource, 'bank', amount)
                    else
                        AddBankMoneyOffline(targetData[1].identifier, amount)
                    end
                    TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['transfer_success'], 'success', 2000)
                    local targetInfo = json.decode(targetData[1].info)
                    SendTransactions(GetIdentifier(src), {
                        type = 'remove',
                        action = 'transfer',
                        label = Locales[Config.Language]['transfer'],
                        date = os.date("%d.%m.%Y"),
                        description = 'You sent $' .. amount .. ' to ' .. targetInfo.firstname .. ' ' .. targetInfo.lastname,
                        transferDescription = targetInfo.firstname .. ' ' .. targetInfo.lastname .. ' - ' .. iban,
                        amount = amount,
                        source = 'transfer-given'
                    }, src)
                    SendTransactions(targetData[1].identifier, {
                        type = 'add',
                        action = 'transfer',
                        label = Locales[Config.Language]['transfer'],
                        date = os.date("%d.%m.%Y"),
                        description = description,
                        transferDescription = GetName(src) .. ' - ' .. playerIBAN,
                        amount = amount,
                        source = 'transfer-income'
                    })
                    TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
                else
                    TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['cannot_send_to_self'], 'error', 2000)
                end
            else
                TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['player_not_found_iban'], 'error', 2000)
            end
        end
    end
end)

RegisterNetEvent('oph3z-bank:TransferMoneyByID', function(data)
    local src = source
    local amount = tonumber(data.amount)
    local description = data.description
    local targetSource = tonumber(data.id)
    local PlayerMoney = GetPlayerMoney(src, 'bank')

    local creditCheck = CheckPlayerCredits(src)
    if creditCheck.hasOverdue then
        TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Config.Locales[Config.Language]["overdue_credit_error"], 'error', 5000)
        return
    end

    if amount > 0 then
        if tonumber(PlayerMoney) >= amount then
            local targetPlayer = GetPlayer(targetSource)
            if targetPlayer then
                local targetIdentifier = GetIdentifier(targetSource)
                local targetData = ExecuteSql("SELECT `iban` FROM `nv_banking_data` WHERE `uuid` = '"..targetIdentifier.."'")
                local playerData = ExecuteSql("SELECT `iban` FROM `nv_banking_data` WHERE `uuid` = '"..GetIdentifier(src).."'")
                if targetData and #targetData > 0 and playerData and #playerData > 0 then
                    if targetSource ~= tonumber(src) then
                        RemoveMoney(src, 'bank', amount)
                        AddMoney(targetSource, 'bank', amount)
                        TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], 'Başarı ile para gönderdin.', 'success', 2000)
                        SendTransactions(GetIdentifier(src), {
                            type = 'remove',
                            action = 'transfer',
                            label = Locales[Config.Language]['transfer'],
                            date = os.date("%d.%m.%Y"),
                            description = 'You sent $' .. amount .. ' to ' .. GetName(targetSource),
                            transferDescription = GetName(targetSource) .. ' - ' .. targetData[1].iban,
                            amount = amount,
                            source = 'transfer-given'
                        }, src)
                        SendTransactions(GetIdentifier(targetSource), {
                            type = 'add',
                            action = 'transfer',
                            label = Locales[Config.Language]['transfer'],
                            date = os.date("%d.%m.%Y"),
                            description = description,
                            transferDescription = GetName(src) .. ' - ' .. playerData[1].iban,
                            amount = amount,
                            source = 'transfer-income'
                        })
                        TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
                    else
                        TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['cannot_send_to_self'], 'error', 2000)
                    end
                else
                    TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['player_no_bank_account'], 'error', 2000)
                end
            else
                TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['player_not_found_id'], 'error', 2000)
            end
        end
    end
end)

RegisterNetEvent('oph3z-bank:RequestMoneyByIBAN', function(data)
    local src = source
    local amount = tonumber(data.amount)
    local iban = data.iban
    local playerIBAN = data.playerIBAN
    
    if amount > 0 then
        local targetData = ExecuteSql("SELECT `requests`, `info`, `identifier` FROM `nv_banking_data` WHERE `iban` = '"..iban.."'")
        if targetData and #targetData > 0 then
            if tonumber(playerIBAN) ~= tonumber(iban) then
                local requests = json.decode(targetData[1].requests)
                local info = json.decode(targetData[1].info)
                table.insert(requests, {
                    sender = playerIBAN,
                    name = GetName(src),
                    amount = amount,
                    pfp = ''
                })
                ExecuteSql("UPDATE `nv_banking_data` SET `requests` = '"..json.encode(requests).."' WHERE `iban` = '"..iban.."'")
                TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['money_request_sent'], 'success', 2000)
                SendNotification(GetIdentifier(src), {
                    label = Locales[Config.Language]['notification_request'],
                    description = Locales[Config.Language]['notification_sent_money_request']:gsub('${name}', info.firstname .. ' ' .. info.lastname)
                }, src)
                SendNotification(targetData[1].identifier, {
                    label = Locales[Config.Language]['notification_request'],
                    description = Locales[Config.Language]['notification_got_transfer_request']:gsub('${name}', GetName(src))
                })
                TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
            else
                TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], 'Kendine gönderemzsin.', 'error', 2000)
            end
        else
            TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['player_not_found_iban'], 'error', 2000)
        end
    end
end)

RegisterNetEvent('oph3z-bank:RequestMoneyByID', function(data)
    local src = source
    local amount = tonumber(data.amount)
    local targetSource = tonumber(data.id)
    
    if amount > 0 then
        local targetPlayer = GetPlayer(targetSource)
        if targetPlayer then
            local targetIdentifier = GetIdentifier(targetSource)
            local targetData = ExecuteSql("SELECT `requests` FROM `nv_banking_data` WHERE `uuid` = '"..targetIdentifier.."'")
            if targetData and #targetData > 0 then
                if targetSource ~= tonumber(src) then
                    local requests = json.decode(targetData[1].requests)
                    table.insert(requests, {
                        sender = GetPlayerIBAN(src),
                        name = GetName(src),
                        amount = amount,
                        pfp = ''
                    })
                    ExecuteSql("UPDATE `nv_banking_data` SET `requests` = '"..json.encode(requests).."' WHERE `uuid` = '"..targetIdentifier.."'")
                    TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['money_request_sent'], 'success', 2000)
                    SendNotification(GetIdentifier(src), {
                        label = Locales[Config.Language]['notification_request'],
                        description = Locales[Config.Language]['notification_sent_money_request']:gsub('${name}', GetName(targetSource))
                    }, src)
                    SendNotification(GetIdentifier(targetSource), {
                        label = Locales[Config.Language]['notification_request'],
                        description = Locales[Config.Language]['notification_got_transfer_request']:gsub('${name}', GetName(src))
                    })
                    TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
                else
                    TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['cannot_request_from_self'], 'error', 2000)
                end
            else
                TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['player_no_bank_account'], 'error', 2000)
            end
        else
            TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['player_not_found_id'], 'error', 2000)
        end
    end
end)

function GetPlayerPassword(iban)
    local result = ExecuteSql("SELECT `password` FROM `nv_banking_data` WHERE `iban` = '"..iban.."'")
    if #result > 0 then
        return result[1].password
    end
end

exports('GetPlayerPassword', function(iban)
    return GetPlayerPassword(iban)
end)

function GetPlayerIBAN(source)
    local Player = GetPlayer(source)
    if Player then
        local playerIdentifier = GetIdentifier(source)
        local result = ExecuteSql("SELECT `iban` FROM `nv_banking_data` WHERE `uuid` = '"..playerIdentifier.."'")
        return result[1].iban
    else
        return nil
    end
end

exports('GetPlayerIBAN', function(source)
    return GetPlayerIBAN(source)
end)

function SendTransactions(identifier, data, source)
    local src = source
    local result = ExecuteSql("SELECT `transactions` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")
    if result and #result > 0 then
        local transactions = json.decode(result[1].transactions)
        table.insert(transactions, {
            type = data.type,
            action = data.action,
            label = data.label,
            date = data.date,
            description = data.description,
            transferDescription = data.transferDescription or '',
            amount = data.amount,
            source = data.source
        })
        ExecuteSql("UPDATE `nv_banking_data` SET `transactions` = '"..json.encode(transactions).."' WHERE `uuid` = '"..identifier.."'")
        if src then
            TriggerClientEvent('oph3z-bank:UpdateUITransactions', src, transactions)
        end
    end
end

exports('SendBankTransaction', function(identifier, data, source)
    return SendTransactions(identifier, data, source)
end)

function GiveCreditPoints(identifier, amount, source)
    local src = source
    local result = ExecuteSql("SELECT `active_credits` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")
    if result and #result > 0 then
        local credit = json.decode(result[1].active_credits)
        credit.creditpoint = tonumber(credit.creditpoint) + tonumber(amount)
        ExecuteSql("UPDATE `nv_banking_data` SET `active_credits` = '"..json.encode(credit).."' WHERE `uuid` = '"..identifier.."'")
        if src and src ~= 0 then
            TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
        end
    end
end

exports('GiveCreditPoints', function(identifier, amount, source)
    return GiveCreditPoints(identifier, amount, source)
end)

function SendNotification(identifier, data, src)
    local src = source
    local result = ExecuteSql("SELECT `notifications` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")
    if result and #result > 0 then
        local notifications = json.decode(result[1].notifications)
        table.insert(notifications, {
            label = data.label,
            description = data.description
        })
        ExecuteSql("UPDATE `nv_banking_data` SET `notifications` = '"..json.encode(notifications).."' WHERE `uuid` = '"..identifier.."'")
        if src then
            TriggerClientEvent('oph3z-bank:UpdateUINotifications', src, notifications)
        end
    end
end

function CheckPlayerCredits(src)
    local identifier = GetIdentifier(src)
    local result = ExecuteSql("SELECT `active_credits` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")
    
    if result and #result > 0 then
        local credit = json.decode(result[1].active_credits)
        if credit.activecredit and #credit.activecredit > 0 then
            for i, activeCredit in ipairs(credit.activecredit) do
                if activeCredit.boughtTime then
                    local boughtTime = activeCredit.boughtTime
                    local creditName = activeCredit.name
                    
                    for j, availableCredit in ipairs(Config.AvailableCredits) do
                        if availableCredit.name == creditName then
                            local paybackTime = availableCredit.paybackTime
                            local day, month, year = string.match(boughtTime, "(%d+)%.(%d+)%.(%d+)")
                            
                            if day and month and year then
                                local deadlineDate = os.time({year = 2000 + tonumber(year), month = tonumber(month), day = tonumber(day)}) + (paybackTime * 7 * 24 * 60 * 60)
                                local todayTime = os.time()
                                
                                if todayTime > deadlineDate then
                                    return {
                                        hasOverdue = true,
                                        overdueCredit = availableCredit.label,
                                        playerName = GetName(src)
                                    }
                                end
                            end
                            break
                        end
                    end
                end
            end
        end
        
        return {
            hasOverdue = false,
            credit = credit
        }
    end
    
    return {
        hasOverdue = false,
        credit = nil
    }
end

RegisterNetEvent('oph3z-bank:buyCredit', function(data)
    local src = source
    local identifier = GetIdentifier(src)
    local result = ExecuteSql("SELECT `active_credits` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")

    if result and #result > 0 then
        local credit = json.decode(result[1].active_credits)
        local today = os.date("%d.%m.%y")
        local creditCheck = CheckPlayerCredits(src)
        
        if creditCheck.hasOverdue then
            TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['overdue_credit_buy_error']:gsub('${credit}', creditCheck.overdueCredit), 'error', 5000)
            return
        end

        local creditName = data.name
        local remainingDebt = data.remainingDebt
        for i, availableCredit in ipairs(Config.AvailableCredits) do
            if availableCredit.name == creditName then
                local requiredCreditPoint = availableCredit.requiredCreditPoint
                if credit.creditpoint and credit.creditpoint >= requiredCreditPoint then
                    local newCredit = {
                        name = creditName,
                        remainingDebt = remainingDebt,
                        boughtTime = today
                    }
                    table.insert(credit.activecredit, newCredit)
                    credit.creditpoint = credit.creditpoint - requiredCreditPoint
                    ExecuteSql("UPDATE `nv_banking_data` SET `active_credits` = '"..json.encode(credit).."' WHERE `uuid` = '"..identifier.."'")
                    AddMoney(src, 'bank', availableCredit.price)
                    TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['credit_purchased_success']:gsub('${points}', requiredCreditPoint), 'success', 2000)
                    TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
                else
                    TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['insufficient_credit_points']:gsub('${required}', requiredCreditPoint):gsub('${available}', credit.creditpoint or 0), 'error', 2000)
                end
                break
            end
        end
    end
end)

RegisterNetEvent('oph3z-bank:payAllDebt', function(amount)
    local src = source
    local identifier = GetIdentifier(src)
    local result = ExecuteSql("SELECT `active_credits` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")

    if result and #result > 0 then
        local PlayerMoney = GetPlayerMoney(src, 'bank')
        if tonumber(PlayerMoney) >= tonumber(amount) then
            local credit = json.decode(result[1].active_credits)
            RemoveMoney(src, 'bank', tonumber(amount))
            credit.activecredit = {}
            ExecuteSql("UPDATE `nv_banking_data` SET `active_credits` = '"..json.encode(credit).."' WHERE `uuid` = '"..identifier.."'")
            TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['credit_paid_success'], 'success', 2000)
            GiveCreditPoints(identifier, Config.GiveCreditPoint.debtPaid)
            TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
        else
            TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['insufficient_funds'], 'error', 2000)
        end
    end
end)

RegisterNetEvent('oph3z-bank:PayAPart', function(data)
    local src = source
    local identifier = GetIdentifier(src)
    local result = ExecuteSql("SELECT `active_credits` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")
    if result and #result > 0 then
        local credit = json.decode(result[1].active_credits)
        local PlayerMoney = GetPlayerMoney(src, 'bank')
        if tonumber(PlayerMoney) >= tonumber(data.amount) then
            for i, activeCredit in ipairs(credit.activecredit) do
                if activeCredit.name == data.loan then
                    if tonumber(data.amount) > tonumber(activeCredit.remainingDebt) then
                        TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['payment_amount_too_high']:gsub('${debt}', activeCredit.remainingDebt), 'error', 3000)
                        return
                    end
                    local newRemainingDebt = tonumber(activeCredit.remainingDebt) - tonumber(data.amount)
                    if newRemainingDebt <= 0 then
                        table.remove(credit.activecredit, i)
                        TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['credit_fully_paid'], 'success', 2000)
                        GiveCreditPoints(identifier, Config.GiveCreditPoint.debtPaid)
                    else
                        activeCredit.remainingDebt = newRemainingDebt
                        TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['credit_partially_paid']:gsub('${amount}', data.amount):gsub('${remaining}', newRemainingDebt), 'success', 2000)
                    end
                    RemoveMoney(src, 'bank', tonumber(data.amount))
                    ExecuteSql("UPDATE `nv_banking_data` SET `active_credits` = '"..json.encode(credit).."' WHERE `uuid` = '"..identifier.."'")
                    TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
                    break
                end
            end
        else
            TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['insufficient_funds'], 'error', 2000)
        end
    end
end)

RegisterNetEvent('oph3z-bank:payDebt', function(data)
    local src = source
    local identifier = GetIdentifier(src)
    local result = ExecuteSql("SELECT `active_credits` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")
    
    if result and #result > 0 then
        local credit = json.decode(result[1].active_credits)
        for i, activeCredit in ipairs(credit.activecredit) do
            if activeCredit.name == data then
                local remainingDebt = tonumber(activeCredit.remainingDebt)
                local PlayerMoney = GetPlayerMoney(src, 'bank')
                if tonumber(PlayerMoney) >= remainingDebt then
                    table.remove(credit.activecredit, i)
                    RemoveMoney(src, 'bank', remainingDebt)
                    ExecuteSql("UPDATE `nv_banking_data` SET `active_credits` = '"..json.encode(credit).."' WHERE `uuid` = '"..identifier.."'")
                    TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['credit_fully_paid'], 'success', 2000)
                    GiveCreditPoints(identifier, Config.GiveCreditPoint.debtPaid)
                    TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
                else
                    TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['insufficient_funds_with_amount']:gsub('${required}', remainingDebt):gsub('${available}', PlayerMoney), 'error', 2000)
                end
                break
            end
        end
    end
end)

RegisterNetEvent('oph3z-bank:BuySavingAccount', function(data)
    local src = source
    local identifier = GetIdentifier(src)
    local result = ExecuteSql("SELECT `savings_accounts_data` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")

    local creditCheck = CheckPlayerCredits(src)
    if creditCheck.hasOverdue then
        TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['overdue_credit_error'], 'error', 5000)
        return
    end

    if result and #result > 0 then
        local savings_accounts_data = json.decode(result[1].savings_accounts_data or '[]')
        if not savings_accounts_data then
            savings_accounts_data = {}
        end
        local selectedAccount = nil
        for i, account in ipairs(Config.SavingAccounts) do
            if account.name == data then
                selectedAccount = account
                break
            end
        end
        if selectedAccount then
            local PlayerMoney = GetPlayerMoney(src, 'bank')
            local cost = selectedAccount.cost
            if tonumber(PlayerMoney) >= tonumber(cost) then
                RemoveMoney(src, 'bank', tonumber(cost))

                local currentDateTime = os.date("%d.%m.%Y %H:%M:%S")
                local newSavingAccount = {
                    name = data,
                    boughtTime = currentDateTime
                }
                
                table.insert(savings_accounts_data, newSavingAccount)
                ExecuteSql("UPDATE `nv_banking_data` SET `savings_accounts_data` = '"..json.encode(savings_accounts_data).."' WHERE `uuid` = '"..identifier.."'")
                TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['saving_account_purchased'], 'success', 2000)
                TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
            else
                TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['insufficient_funds_with_amount']:gsub('${required}', cost):gsub('${available}', PlayerMoney), 'error', 2000)
            end
        end
    end
end)

RegisterNetEvent('oph3z-bank:cancelSavingAccount', function(data)
    local src = source
    local identifier = GetIdentifier(src)
    local result = ExecuteSql("SELECT `savings_accounts_data` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")

    if result and #result > 0 then
        local savings_accounts_data = json.decode(result[1].savings_accounts_data or '[]')
        if not savings_accounts_data then
            savings_accounts_data = {}
        end
        local selectedAccount = nil
        for k, v in ipairs(Config.SavingAccounts) do
            if v.name == data then
                selectedAccount = v
                break
            end
        end

        if selectedAccount then
            for i, account in ipairs(savings_accounts_data) do
                if account.name == data then
                    table.remove(savings_accounts_data, i)
                    break
                end
            end
            AddMoney(src, 'bank', tonumber(selectedAccount.cost))
            ExecuteSql("UPDATE `nv_banking_data` SET `savings_accounts_data` = '"..json.encode(savings_accounts_data).."' WHERE `uuid` = '"..identifier.."'")
            TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
            TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['saving_account_cancelled'], 'success', 2000)
        end
    end
end)

function CheckMaturedSavingAccounts()
    local allPlayers = ExecuteSql("SELECT `uuid`, `savings_accounts_data` FROM `nv_banking_data` WHERE `savings_accounts_data` != '[]' AND `savings_accounts_data` != 'null'")
    
    if allPlayers and #allPlayers > 0 then
        for i, playerData in ipairs(allPlayers) do
            local identifier = playerData.uuid
            local savings_accounts_data = json.decode(playerData.savings_accounts_data)
            if savings_accounts_data and #savings_accounts_data > 0 then
                local accountsToRemove = {}
                local totalPayout = 0
                
                for j, account in ipairs(savings_accounts_data) do
                    if account.name and account.boughtTime then
                        local accountConfig = nil
                        for k, configAccount in ipairs(Config.SavingAccounts) do
                            if configAccount.name == account.name then
                                accountConfig = configAccount
                                break
                            end
                        end
                        
                        if accountConfig then
                            local day, month, year, hour, minute, second = string.match(account.boughtTime, "(%d+)%.(%d+)%.(%d+) (%d+):(%d+):(%d+)") 
                            if day and month and year and hour and minute and second then
                                local boughtDate = os.time({
                                    year = tonumber(year), 
                                    month = tonumber(month), 
                                    day = tonumber(day),
                                    hour = tonumber(hour),
                                    min = tonumber(minute),
                                    sec = tonumber(second)
                                })
                                local currentTime = os.time()
                                local hoursElapsed = math.floor((currentTime - boughtDate) / (60 * 60))
                                if hoursElapsed >= accountConfig.time then
                                    local payout = accountConfig.cost + (accountConfig.cost * accountConfig.percent / 100)
                                    totalPayout = totalPayout + payout
                                    table.insert(accountsToRemove, j)
                                end
                            end
                        end
                    end
                end
                
                if totalPayout > 0 then
                    local playerSource = GetPlayerSourceByIdentifier(identifier)
                    if playerSource and playerSource ~= 0 then
                        AddMoney(playerSource, 'bank', totalPayout)
                    else
                        AddBankMoneyOffline(identifier, totalPayout)
                    end
                    for j = #accountsToRemove, 1, -1 do
                        table.remove(savings_accounts_data, accountsToRemove[j])
                    end
                    ExecuteSql("UPDATE `nv_banking_data` SET `savings_accounts_data` = '"..json.encode(savings_accounts_data).."' WHERE `uuid` = '"..identifier.."'")
                    SendNotification(identifier, {
                        label = Locales[Config.Language]["saving_account"],
                        description = Locales[Config.Language]['notification_saving_account_matured']:gsub('${amount}', totalPayout .. '$')
                    })
                end
            end
        end
    end
end

RegisterNetEvent('oph3z-bank:clearNotifications', function()
    local src = source
    local identifier = GetIdentifier(src)
    ExecuteSql("UPDATE `nv_banking_data` SET `notifications` = '[]' WHERE `uuid` = '"..identifier.."'")
    TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['all_notifications_cleared'], 'success', 2000)
    TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
end)

RegisterNetEvent('oph3z-bank:clearTransactions', function()
    local src = source
    local identifier = GetIdentifier(src)
    ExecuteSql("UPDATE `nv_banking_data` SET `transactions` = '[]' WHERE `uuid` = '"..identifier.."'")
    TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['all_history_cleared'], 'success', 2000)
    TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
end)

Citizen.CreateThread(function()
    while true do
        local currentTime = os.date("*t")
        while frameworkObject == nil do
            Citizen.Wait(0)
        end
        if not scriptStartedCheck then
            CheckMaturedSavingAccounts()
            scriptStartedCheck = true
        end
        if currentTime.hour == 0 and currentTime.min == 0 then
            CheckMaturedSavingAccounts()
            Citizen.Wait(60000)
        else
            Citizen.Wait(3600000)
        end
    end
end)

RegisterNetEvent('oph3z-bank:SendUpdatedData', function()
    local src = source
    local identifier = GetIdentifier(src)
    local data = ExecuteSql("SELECT * FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")
    
    if #data > 0 then
        local info = json.decode(data[1].info)
        local credit = json.decode(data[1].active_credits or '{"creditpoint":' .. Config.StartCreditPoint .. ',"activecredit":[]}')
        local transactions = json.decode(data[1].transactions) or {}
        local invoices = json.decode(data[1].invoices) or {}
        
        local PlayerData = {
            PlayerInformation = {
                Firstname = info.firstname,
                Lastname = info.lastname,
                ProfilePicture = info.playerpp,
                ID = src,
                IBAN = data[1].iban,
                Balance = GetPlayerMoney(src, 'bank'),
                Cash = GetPlayerMoney(src, 'cash'),
                CryptoHoldings = json.decode(data[1].crypto_holdings or '[]'),
                ActiveCredits = credit.activecredit or {},
                CreditPoint = credit.creditpoint or data[1].credit_score or Config.StartCreditPoint,
                ActiveSavingAccounts = json.decode(data[1].savings_accounts_data or '[]'),
                Requests = json.decode(data[1].requests or '[]'),
                Notification = json.decode(data[1].notifications or '[]'),
                AccountUsed = json.decode(data[1].account_used or '{"loginlimit":' .. Config.HackSettings.LoginLimit .. ',"withdrawlimit":' .. Config.HackSettings.WithdrawLimit .. '}'),
                AccountExist = true,
                AccountOwner = true
            },
            Transactions = transactions,
            Invoices = invoices
        }

        TriggerClientEvent('oph3z-bank:ReceiveUpdatedData', src, PlayerData)
    end
end)

RegisterNetEvent('oph3z-bank:changePassword', function(data)
    local src = source
    local identifier = GetIdentifier(src)
    local result = ExecuteSql("SELECT `password`, `account_used` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")
    
    if result and #result > 0 then
        local currentPassword = result[1].password
        local newPassword = tonumber(data)
        if tonumber(currentPassword) ~= newPassword then
            ExecuteSql("UPDATE `nv_banking_data` SET `password` = '"..newPassword.."', `account_used` = '"..json.encode({ loginlimit = Config.HackSettings.LoginLimit, withdrawlimit = Config.HackSettings.WithdrawLimit }).."' WHERE `uuid` = '"..identifier.."'")
            TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['password_changed_success'], 'success', 2000)
            TriggerClientEvent('oph3z-bank:UpdateAccountUsedInUI', src, {loginlimit = Config.HackSettings.LoginLimit, withdrawlimit = Config.HackSettings.WithdrawLimit})
        else
            TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['new_password_same'], 'error', 2000)
        end
    end
end)

RegisterNetEvent('oph3z-bank:acceptRequest', function(data)
    local src = source
    local identifier = GetIdentifier(src)
    local result = ExecuteSql("SELECT `requests` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")
    local targetPlayer = ExecuteSql("SELECT `identifier` FROM `nv_banking_data` WHERE `iban` = '"..data.sender.."'")

    local creditCheck = CheckPlayerCredits(src)
    if creditCheck.hasOverdue then
        TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['overdue_credit_error'], 'error', 5000)
        return
    end
    
    if result and #result > 0 and targetPlayer and #targetPlayer > 0 then
        local requests = json.decode(result[1].requests)
        if data.id and data.id >= 0 and data.id < #requests then
            local targetIdentifier = targetPlayer[1].identifier
            local targetSource = GetPlayerSourceByIdentifier(targetIdentifier)
            local PlayerMoney = GetPlayerMoney(src, 'bank')
            if tonumber(PlayerMoney) >= tonumber(data.amount) then
                RemoveMoney(src, 'bank', tonumber(data.amount))
                if targetSource and targetSource ~= 0 then
                    AddMoney(targetSource, 'bank', tonumber(data.amount))
                else
                    AddBankMoneyOffline(targetIdentifier, tonumber(data.amount))
                end
                table.remove(requests, data.id + 1)
                ExecuteSql("UPDATE `nv_banking_data` SET `requests` = '"..json.encode(requests).."' WHERE `uuid` = '"..identifier.."'")
                    SendNotification(identifier, {
                        label = Locales[Config.Language]['notification_request_accepted'],
                        description = Locales[Config.Language]['notification_accepted_money_request']:gsub('${amount}', '$' .. data.amount)
                    }, src)
                    SendNotification(targetIdentifier, {
                        label = Locales[Config.Language]['notification_request_accepted'],
                        description = Locales[Config.Language]['notification_request_accepted_received']:gsub('${amount}', '$' .. data.amount)
                    })
                TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['success'], Locales[Config.Language]['money_request_accepted'], 'success', 2000)
                TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
            else
                TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['insufficient_funds'], 'error', 2000)
            end
        end
    end
end)

RegisterNetEvent('oph3z-bank:rejectRequest', function(data)
    local src = source
    local identifier = GetIdentifier(src)
    local result = ExecuteSql("SELECT `requests` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")
    local targetPlayer = ExecuteSql("SELECT `identifier` FROM `nv_banking_data` WHERE `iban` = '"..data.iban.."'")
    
    if result and #result > 0 then
        local requests = json.decode(result[1].requests)
        if data.id and data.id >= 0 and data.id < #requests then
            table.remove(requests, data.id + 1)
            ExecuteSql("UPDATE `nv_banking_data` SET `requests` = '"..json.encode(requests).."' WHERE `uuid` = '"..identifier.."'")
            if targetPlayer and #targetPlayer > 0 then
                local targetIdentifier = targetPlayer[1].identifier
                SendNotification(targetIdentifier, {
                    label = Locales[Config.Language]['notification_request_rejected'],
                    description = Locales[Config.Language]['notification_request_rejected']
                })
            end
            TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
        end
    end
end)

RegisterNetEvent('oph3z-bank:OpenATM', function()
    local src = source
    local identifier = GetIdentifier(src)
    local result = ExecuteSql("SELECT `iban` FROM `nv_banking_data` WHERE `uuid` = '"..identifier.."'")

    if #result > 0 then
        TriggerClientEvent('oph3z-bank:OpenPlayerATM', src, {
            firstname = GetNameSeparately('firstname', src),
            lastname = GetNameSeparately('lastname', src),
            playerpp = '',
            iban = result[1].iban,
            AccountExist = true,
            AccountOwner = true
        })
    else
        TriggerClientEvent('oph3z-bank:OpenATMWithoutAccount', src, {
            AccountExist = false,
            AccountOwner = false
        })
    end
end)

RegisterNetEvent('oph3z-bank:WithdrawMoneyNonOwner', function(data)
    local src = source
    local result = ExecuteSql("SELECT `identifier`, `account_used`, `transactions` FROM `nv_banking_data` WHERE `iban` = '"..data.iban.."'")

    if #result > 0 then
        local account_used = json.decode(result[1].account_used)
        if account_used.withdrawlimit > 0 then
            local amount = data.amount
            if tonumber(account_used.withdrawlimit) >= tonumber(amount) then
                if tonumber(GetPlayerMoneyOffline(result[1].identifier)) >= tonumber(amount) then
                    AddMoney(src, 'cash', tonumber(amount))
                    RemoveBankMoneyOffline(result[1].identifier, tonumber(amount))
                    SendTransactions(result[1].identifier, {
                        type = 'remove',
                        action = 'withdraw',
                        label = Locales[Config.Language]['withdraw'],
                        date = os.date("%d.%m.%Y"),
                        description = '$' .. amount .. ' withdrawn.',
                        amount = amount,
                        source = 'withdraw'
                    })
                    Citizen.Wait(200)
                    TriggerClientEvent('oph3z-bank:UpdateHackedAccountUI', src, {
                        Balance = GetPlayerMoneyOffline(result[1].identifier),
                        Transactions = json.decode(result[1].transactions)
                    })
                    account_used.withdrawlimit = tonumber(account_used.withdrawlimit) - tonumber(amount)
                    ExecuteSql("UPDATE `nv_banking_data` SET `account_used` = '"..json.encode(account_used).."' WHERE `uuid` = '"..result[1].identifier.."'")
                else
                    TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['insufficient_account_funds'], 'error', 2000)
                end
            else
                TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['account_limit_exceeded'], 'error', 2000)
            end
        else
            TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['account_limit_expired'], 'error', 2000)
        end
    end
end)

-- ==================== ENTERPRISE FUNCTIONS ====================

function GetSocietyMoney(jobName)
    return 0
end

function AddSocietyMoney(jobName, amount)
    return false
end

function RemoveSocietyMoney(jobName, amount)
    return false
end

-- Helper function to get enterprise transactions
function GetEnterpriseTransactions(jobName)
    local result = ExecuteSql("SELECT `transactions` FROM `nv_banking_enterprise` WHERE `job_name` = '"..jobName.."'")
    if result and #result > 0 then
        return json.decode(result[1].transactions) or {}
    end
    return {}
end

-- Helper function to send enterprise transaction
function SendEnterpriseTransaction(jobName, data, src)
    local result = ExecuteSql("SELECT `transactions` FROM `nv_banking_enterprise` WHERE `job_name` = '"..jobName.."'")
    local transactions = {}

    if result and #result > 0 then
        transactions = json.decode(result[1].transactions) or {}
    else
        -- Create entry if not exists
        ExecuteSql("INSERT INTO `nv_banking_enterprise` (`job_name`, `transactions`) VALUES ('"..jobName.."', '[]')")
    end

    table.insert(transactions, {
        type = data.type,
        action = data.action,
        label = data.label,
        date = data.date,
        description = data.description,
        playerName = data.playerName or '',
        amount = data.amount,
        source = data.source
    })

    ExecuteSql("UPDATE `nv_banking_enterprise` SET `transactions` = '"..json.encode(transactions).."' WHERE `job_name` = '"..jobName.."'")

    return transactions
end

-- Callback to get enterprise accounts for a player
RegisterCallback('oph3z-bank:GetEnterpriseAccounts', function(source, cb)
    local src = source
    local player = GetPlayer(src)
    local enterprises = {}

    if player then
        local jobName = nil
        local jobLabel = nil
        local gradeLabel = nil
        local gradeName = nil

        if Config.Framework == "esx" or Config.Framework == "oldesx" then
            jobName = player.job.name
            jobLabel = player.job.label
            gradeLabel = player.job.grade_label
            gradeName = player.job.grade_name
        else
            jobName = player.PlayerData.job.name
            jobLabel = player.PlayerData.job.label
            gradeLabel = player.PlayerData.job.grade.name
            gradeName = player.PlayerData.job.grade.name
        end

        -- Check if player is boss or has access
        if gradeName == 'boss' or gradeName == 'patron' or gradeName == 'chef' or gradeName == 'directeur' or gradeName == 'manager' or gradeName == 'sous-boss' then
            local balance = GetSocietyMoney(jobName)
            local transactions = GetEnterpriseTransactions(jobName)

            table.insert(enterprises, {
                jobName = jobName,
                label = jobLabel,
                gradeLabel = gradeLabel,
                balance = balance,
                transactions = transactions
            })
        end

        -- Check job2 if exists (secondary job)
        if Config.Framework == "esx" or Config.Framework == "oldesx" then
            if player.job2 and player.job2.name and player.job2.name ~= 'unemployed2' then
                local job2GradeName = player.job2.grade_name
                if job2GradeName == 'boss' or job2GradeName == 'patron' or job2GradeName == 'chef' or job2GradeName == 'directeur' or job2GradeName == 'manager' or job2GradeName == 'sous-boss' then
                    local balance = GetSocietyMoney(player.job2.name)
                    local transactions = GetEnterpriseTransactions(player.job2.name)

                    table.insert(enterprises, {
                        jobName = player.job2.name,
                        label = player.job2.label,
                        gradeLabel = player.job2.grade_label,
                        balance = balance,
                        transactions = transactions
                    })
                end
            end
        end
    end

    cb(enterprises)
end)

-- Deposit money to enterprise
RegisterNetEvent('oph3z-bank:EnterpriseDeposit', function(data)
    local src = source
    local amount = tonumber(data.amount)
    local jobName = data.jobName
    local PlayerCash = GetPlayerMoney(src, 'cash')

    if amount > 0 and tonumber(PlayerCash) >= amount then
        RemoveMoney(src, 'cash', amount)
        AddSocietyMoney(jobName, amount)

        local playerName = GetName(src)
        local transactions = SendEnterpriseTransaction(jobName, {
            type = 'add',
            action = 'deposit',
            label = Locales[Config.Language]['deposit'] or 'Depot',
            date = os.date("%d.%m.%Y"),
            description = '$' .. amount .. ' deposes',
            playerName = playerName,
            amount = amount,
            source = 'deposit'
        }, src)

        local newBalance = GetSocietyMoney(jobName)
        TriggerClientEvent('oph3z-bank:UpdateEnterpriseData', src, jobName, newBalance, transactions)
        TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
    else
        TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['not_enough_cash'] or 'Pas assez d\'argent', 'error', 2000)
    end
end)

-- Withdraw money from enterprise
RegisterNetEvent('oph3z-bank:EnterpriseWithdraw', function(data)
    local src = source
    local amount = tonumber(data.amount)
    local jobName = data.jobName
    local societyBalance = GetSocietyMoney(jobName)

    if amount > 0 and societyBalance >= amount then
        RemoveSocietyMoney(jobName, amount)
        AddMoney(src, 'cash', amount)

        local playerName = GetName(src)
        local transactions = SendEnterpriseTransaction(jobName, {
            type = 'remove',
            action = 'withdraw',
            label = Locales[Config.Language]['withdraw'] or 'Retrait',
            date = os.date("%d.%m.%Y"),
            description = '$' .. amount .. ' retires',
            playerName = playerName,
            amount = amount,
            source = 'withdraw'
        }, src)

        local newBalance = GetSocietyMoney(jobName)
        TriggerClientEvent('oph3z-bank:UpdateEnterpriseData', src, jobName, newBalance, transactions)
        TriggerClientEvent('oph3z-bank:SendUpdatedData', src)
    else
        TriggerClientEvent('oph3z-bank:SendUINotify', src, Locales[Config.Language]['error'], Locales[Config.Language]['insufficient_funds'] or 'Solde insuffisant', 'error', 2000)
    end
end)