ESX = nil
local isUiOpen = false
local currentShopType = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(100)
    end
end)

function OpenShop(shopType)
    currentShopType = shopType
    TriggerServerEvent('shop:requestItems', shopType)
end

RegisterNetEvent('shop:openMenu')
AddEventHandler('shop:openMenu', function(items, shopType)
    currentShopType = shopType
    local formattedItems = {}
    for _, item in pairs(items) do
        local displayQuantity = item.quantity or 1
        if item.defaultQuantity then
            displayQuantity = displayQuantity * item.defaultQuantity
        end
        local itemData = {
            label = item.label,
            name = item.name,
            price = item.price,
            categorie = item.categorie,
            type = item.type,
            image = item.image,
            quantity = displayQuantity,
            defaultQuantity = item.defaultQuantity
        }
        table.insert(formattedItems, itemData)
    end

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        items = formattedItems,
        shopType = shopType
    })
    isUiOpen = true
end)

RegisterNetEvent('shop:openShop')
AddEventHandler('shop:openShop', function(shopType)
    OpenShop(shopType)
end)

RegisterNUICallback('focusField', function(data, cb)    
    SetNuiFocus(true, true)
    cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    isUiOpen = false
    cb('ok')
end)

RegisterNUICallback('billClient', function(data, cb)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
    if closestDistance ~= -1 and closestDistance <= 3.0 then
        data.shopType = currentShopType
        data.targetId = GetPlayerServerId(closestPlayer)
        TriggerServerEvent('shop:billClient', data)
        cb('ok')
    else
        TriggerEvent('esx:showNotification', 'Il n\'y a personne à proximité')
        cb('error')
    end
end)

RegisterNUICallback('switchShop', function(data, cb)
    OpenShop(data.shopType)
    cb('ok')
end)

CreateThread(function()
    while true do
        Wait(0)
        if isUiOpen then
            if IsControlJustPressed(0, 177) then
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = 'close'
                })
                isUiOpen = false
            end
        end
    end
end)

RegisterNUICallback('checkMoney', function(data, cb)
    data.shopType = currentShopType
    TriggerServerEvent('shop:checkMoney', data)
    cb('ok')
end)

RegisterNetEvent('shop:checkoutResult')
AddEventHandler('shop:checkoutResult', function(success)
    if success then
        SendNUIMessage({
            action = 'clearCart'
        })
    else
        TriggerEvent('esx:showNotification', 'Vous n\'avez pas assez d\'argent.')
    end
end)