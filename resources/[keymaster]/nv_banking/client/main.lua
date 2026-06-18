frameworkObject = nil

Citizen.CreateThread(function()
    frameworkObject, Config.Framework = GetCore()
    while not frameworkObject do
        Citizen.Wait(0)
    end
    Citizen.Wait(1500)
    SendNUIMessage({
        action = 'Setup',
        locales = Locales[Config.Language],
        credits = Config.AvailableCredits,
        fastactions = Config.FastActions,
        savingaccounts = Config.SavingAccounts,
        hacksettings = Config.HackSettings
    })
    Citizen.Wait(500)
    local hasStatus = RefreshAccountStatus()
    if not hasStatus then
        EnsureAccountStatus(6, 2000)
    end
    Citizen.Wait(100)
    OpenBank()
    CreateBlips()
end)

function CreateBlips()
    for k, v in pairs(Config.BankLocations) do
        blip = AddBlipForCoord(v.Coords.x, v.Coords.y, v.Coords.z)
        SetBlipSprite(blip, v.BlipType)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, v.BlipScale)
        SetBlipColour(blip, v.BlipColor)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Blipname)
        EndTextCommandSetBlipName(blip)
    end
end

RegisterNetEvent('oph3z-bank:CloseUI', function()
    SendNUIMessage({ action = 'CloseUI' })
    DisplayHUD(false)
end)

RegisterNetEvent('oph3z-bank:client:CreateAccount', function(data)
    SendNUIMessage({
        action = 'CreateAccount',
        data = data
    })
    SetNuiFocus(true, true)
    DisplayHUD(true)
    
    local playerPed = PlayerPedId()
    local animDict = "amb@world_human_clipboard@male@base"
    local animName = "base"
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
    local prop = CreateObject(GetHashKey("prop_notepad_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.1, 0.02, 0.08, 10.0, 0.0, 0.0, true, true, false, true, 1, true)
    TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 49, 0, false, false, false)
end)

RegisterNUICallback('CloseUI', function()
    SetNuiFocus(false, false)
    local playerPed = PlayerPedId()
    ClearPedTasks(playerPed)
    ClearPedSecondaryTask(playerPed)
    local prop = GetClosestObjectOfType(GetEntityCoords(playerPed), 1.0, GetHashKey("prop_notepad_01"), false, false, false)
    if prop ~= 0 then
        DeleteObject(prop)
    end
    DisplayHUD(false)
end)

RegisterNUICallback('RegisterAccount', function(data)
    TriggerServerEvent('oph3z-bank:RegisterAccount', tonumber(data))
end)

RegisterNetEvent('oph3z-bank:OpenBank', function()
    local PlayerData = TriggerCallback('oph3z-bank:GetPlayerData')
    local InovicesTable = TriggerCallback('oph3z-bank:server:GetPlayerBilling')
    local EnterpriseAccounts = TriggerCallback('oph3z-bank:GetEnterpriseAccounts')
    if PlayerData and InovicesTable then
        local transactions = PlayerData.Transactions
        if type(transactions) == "string" then
            transactions = json.decode(transactions) or {}
        elseif not transactions then
            transactions = {}
        end

        local invoices = InovicesTable
        if type(invoices) == "string" then
            invoices = json.decode(invoices) or {}
        elseif not invoices then
            invoices = {}
        end

        local enterprises = EnterpriseAccounts or {}

        SendNUIMessage({
            action = 'OpenBank',
            PlayerInformation = PlayerData.PlayerInformation,
            Transactions = transactions,
            Invoices = invoices,
            EnterpriseAccounts = enterprises
        })
        SetNuiFocus(true, true)
        DisplayHUD(true)
    end
end)

RegisterNetEvent('oph3z-bank:LoginToAnotherAccount', function(data)
    local PlayerData = TriggerCallback('oph3z-bank:GetTargetAccountData', data)

    if PlayerData == 'bilgi' then
        TriggerEvent('oph3z-bank:SendUINotify', Locales[Config.Language]['error'], Locales[Config.Language]['invalid_credentials'], 'error', 2000)
        return
    end

    if PlayerData == 'accountused' then
        TriggerEvent('oph3z-bank:SendUINotify', Locales[Config.Language]['error'], Locales[Config.Language]['account_too_hacked'], 'error', 2000)
        return
    end

    if PlayerData then
        local transactions = PlayerData.Transactions
        if type(transactions) == "string" then
            transactions = json.decode(transactions) or {}
        elseif not transactions then
            transactions = {}
        end

        SendNUIMessage({
            action = 'OpenBank',
            PlayerInformation = PlayerData.PlayerInformation,
            Transactions = transactions,
            Invoices = {}
        })
        SetNuiFocus(true, true)
        DisplayHUD(true)
    end
end)

RegisterNUICallback('DepositMoney', function(data)
    TriggerServerEvent('oph3z-bank:DepositMoney', data)
end)

RegisterNUICallback('WithdrawMoney', function(data)
    print(json.encode(data))
    TriggerServerEvent('oph3z-bank:WithdrawMoney', data)
end)

RegisterNUICallback('TransferMoneyByIBAN', function(data)
    TriggerServerEvent('oph3z-bank:TransferMoneyByIBAN', data)
end)

RegisterNUICallback('TransferMoneyByID', function(data)
    TriggerServerEvent('oph3z-bank:TransferMoneyByID', data)
end)

RegisterNUICallback('RequestMoneyByIBAN', function(data)
    TriggerServerEvent('oph3z-bank:RequestMoneyByIBAN', data)
end)

RegisterNUICallback('RequestMoneyByID', function(data)
    TriggerServerEvent('oph3z-bank:RequestMoneyByID', data)
end)

RegisterNetEvent('oph3z-bank:SendUINotify', function(label, description, type, ms)
end)

RegisterNetEvent('oph3z-bank:ReceiveUpdatedData', function(PlayerData)
    if PlayerData then
        local transactions = PlayerData.Transactions
        if type(transactions) == "string" then
            transactions = json.decode(transactions) or {}
        elseif not transactions then
            transactions = {}
        end
        
        local invoices = PlayerData.Invoices
        if type(invoices) == "string" then
            invoices = json.decode(invoices) or {}
        elseif not invoices then
            invoices = {}
        end

        SendNUIMessage({
            action = 'UpdatePlayerInformation',
            PlayerInformation = PlayerData.PlayerInformation,
            Transactions = transactions,
            Invoices = invoices
        })
    end
end)

RegisterNetEvent('oph3z-bank:UpdateUITransactions', function(table)
    SendNUIMessage({
        action = 'UpdateTransactions',
        data = table
    })
end)

RegisterNetEvent('oph3z-bank:UpdateUINotifications', function(table)
    SendNUIMessage({
        action = 'UpdateNotifications',
        data = table
    })
end)

RegisterNetEvent('oph3z-bank:SendUpdatedData', function()
    TriggerServerEvent('oph3z-bank:SendUpdatedData')
end)

RegisterNUICallback('PayInvoice', function(data)
    TriggerServerEvent('oph3z-bank:payBill', data)
end)

RegisterNUICallback('buyCredit', function(data)
    TriggerServerEvent('oph3z-bank:buyCredit', data)
end)

RegisterNUICallback('payAllDebt', function(data)
    TriggerServerEvent('oph3z-bank:payAllDebt', data)
end)

RegisterNUICallback('PayAPart', function(data)
    TriggerServerEvent('oph3z-bank:PayAPart', data)
end)

RegisterNUICallback('payDebt', function(data)
    TriggerServerEvent('oph3z-bank:payDebt', data)
end)

RegisterNUICallback('CloseUIEvent', function()
    TriggerEvent('oph3z-bank:CloseUI')
end)

RegisterNUICallback('BuySavingAccount', function(data)
    TriggerServerEvent('oph3z-bank:BuySavingAccount', data)
end)

RegisterNUICallback('cancelSavingAccount', function(data)
    TriggerServerEvent('oph3z-bank:cancelSavingAccount', data)
end)

RegisterNUICallback('changePassword', function(data)
    TriggerServerEvent('oph3z-bank:changePassword', data)
end)

RegisterNUICallback('clearNotifications', function()
    TriggerServerEvent('oph3z-bank:clearNotifications')
end)

RegisterNUICallback('clearTransactions', function()
    TriggerServerEvent('oph3z-bank:clearTransactions')
end)

RegisterNUICallback('acceptRequest', function(data)
    TriggerServerEvent('oph3z-bank:acceptRequest', data)
end)

RegisterNUICallback('rejectRequest', function(data)
    TriggerServerEvent('oph3z-bank:rejectRequest', data)
end)

RegisterNetEvent('oph3z-bank:OpenPlayerATM', function(data)
    SendNUIMessage({
        action = 'OpenPlayerAtm',
        data = data
    })
    SetNuiFocus(true, true)
    DisplayHUD(true)
end)

RegisterNUICallback('normalATMLogin', function()
    TriggerEvent('oph3z-bank:OpenBank')
end)

RegisterNUICallback('LoginToAnotherAccount', function(data)
    TriggerEvent('oph3z-bank:LoginToAnotherAccount', data)
end)

RegisterNUICallback('WithdrawMoneyNonOwner', function(data)
    TriggerServerEvent('oph3z-bank:WithdrawMoneyNonOwner', data)
end)

RegisterNetEvent('oph3z-bank:UpdateHackedAccountUI', function(data)
    SendNUIMessage({
        action = 'UpdateHackedAccountUI',
        data = data
    })
end)

RegisterNetEvent('oph3z-bank:OpenATMWithoutAccount', function(data)
    SendNUIMessage({
        action = 'OpenATMWithoutAccount',
        data = data
    })
    SetNuiFocus(true, true)
end)

RegisterNetEvent('oph3z-bank:UpdateAccountUsedInUI', function(data)
    SendNUIMessage({
        action = 'UpdateAccountUsedInUI',
        data = data
    })
end)

-- Enterprise callbacks
RegisterNUICallback('EnterpriseDeposit', function(data)
    TriggerServerEvent('oph3z-bank:EnterpriseDeposit', data)
end)

RegisterNUICallback('EnterpriseWithdraw', function(data)
    TriggerServerEvent('oph3z-bank:EnterpriseWithdraw', data)
end)

RegisterNetEvent('oph3z-bank:UpdateEnterpriseAccounts', function(data)
    SendNUIMessage({
        action = 'UpdateEnterpriseAccounts',
        data = data
    })
end)

RegisterNetEvent('oph3z-bank:UpdateEnterpriseData', function(jobName, balance, transactions)
    SendNUIMessage({
        action = 'UpdateEnterpriseData',
        jobName = jobName,
        balance = balance,
        transactions = transactions
    })
end)