-- Anti-duplication: Track pending transactions per player
local pendingTransactions = {}

-- Cooldown en millisecondes entre transactions
local TRANSACTION_COOLDOWN = 1000

-- Fonction utilitaire pour vérifier si le joueur peut effectuer une transaction
local function canProcessTransaction(source)
    local currentTime = GetGameTimer()

    if pendingTransactions[source] then
        local lastTransaction = pendingTransactions[source]
        if currentTime - lastTransaction < TRANSACTION_COOLDOWN then
            return false
        end
    end

    pendingTransactions[source] = currentTime
    return true
end

-- Nettoyer les transactions pending quand le joueur se déconnecte
AddEventHandler('playerDropped', function()
    local source = source
    pendingTransactions[source] = nil
end)

-- Handler pour le dépôt d'argent (cash -> banque)
RegisterNetEvent('bank:deposit', function(amount)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    -- Validation du montant
    amount = tonumber(amount)
    if not amount or amount <= 0 then
        TriggerClientEvent('esx:showNotification', source, '~r~Montant invalide')
        return
    end

    -- Arrondir le montant pour éviter les problèmes de décimales
    amount = math.floor(amount)

    -- Anti-duplication: vérifier le cooldown
    if not canProcessTransaction(source) then
        TriggerClientEvent('esx:showNotification', source, '~r~Veuillez patienter entre chaque transaction')
        return
    end

    -- Vérifier si le joueur a assez d'argent en cash
    local cashAccount = xPlayer.getAccount('cash')
    if not cashAccount or cashAccount.money < amount then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas assez d\'argent sur vous')
        pendingTransactions[source] = nil -- Reset le cooldown en cas d'échec
        return
    end

    -- IMPORTANT: Retirer l'argent AVANT d'ajouter à la banque (ordre atomique)
    xPlayer.removeAccountMoney('cash', amount)
    xPlayer.addAccountMoney('bank', amount)

    TriggerClientEvent('esx:showNotification', source, ('~g~Vous avez déposé ~b~%s$~g~ sur votre compte'):format(ESX.Math.GroupDigits(amount)))

    -- Log de la transaction
    if sendLog then
        sendLog(('Dépôt bancaire (%s - %s)'):format(xPlayer.name, xPlayer.UniqueID), {
            author = 'Banque',
            fields = {
                {title = 'Joueur', subtitle = xPlayer.name},
                {title = 'ID Unique', subtitle = tostring(xPlayer.UniqueID)},
                {title = 'Montant déposé', subtitle = tostring(amount) .. '$'},
                {title = 'Nouveau solde banque', subtitle = tostring(xPlayer.getAccount('bank').money) .. '$'},
            },
            channel = 'bank_deposit'
        })
    end
end)

-- Handler pour le retrait d'argent (banque -> cash)
RegisterNetEvent('bank:withdraw', function(amount)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    -- Validation du montant
    amount = tonumber(amount)
    if not amount or amount <= 0 then
        TriggerClientEvent('esx:showNotification', source, '~r~Montant invalide')
        return
    end

    -- Arrondir le montant pour éviter les problèmes de décimales
    amount = math.floor(amount)

    -- Anti-duplication: vérifier le cooldown
    if not canProcessTransaction(source) then
        TriggerClientEvent('esx:showNotification', source, '~r~Veuillez patienter entre chaque transaction')
        return
    end

    -- Vérifier si le joueur a assez d'argent en banque
    local bankAccount = xPlayer.getAccount('bank')
    if not bankAccount or bankAccount.money < amount then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas assez d\'argent en banque')
        pendingTransactions[source] = nil -- Reset le cooldown en cas d'échec
        return
    end

    -- IMPORTANT: Retirer l'argent AVANT d'ajouter au cash (ordre atomique)
    xPlayer.removeAccountMoney('bank', amount)
    xPlayer.addAccountMoney('cash', amount)

    TriggerClientEvent('esx:showNotification', source, ('~g~Vous avez retiré ~b~%s$~g~ de votre compte'):format(ESX.Math.GroupDigits(amount)))

    -- Log de la transaction
    if sendLog then
        sendLog(('Retrait bancaire (%s - %s)'):format(xPlayer.name, xPlayer.UniqueID), {
            author = 'Banque',
            fields = {
                {title = 'Joueur', subtitle = xPlayer.name},
                {title = 'ID Unique', subtitle = tostring(xPlayer.UniqueID)},
                {title = 'Montant retiré', subtitle = tostring(amount) .. '$'},
                {title = 'Nouveau solde banque', subtitle = tostring(xPlayer.getAccount('bank').money) .. '$'},
            },
            channel = 'bank_withdraw'
        })
    end
end)
