categories = {}
categories.tshirt = {type = "component", index = 8}
categories.torso = {type = "component", index = 11}
categories.pants = {type = "component", index = 4}
categories.shoes = {type = "component", index = 6}
categories.arms = {type = "component", index = 3}
categories.chains = {type = "component", index = 7}
categories.mask = {type = "component", index = 1}
categories.bags = {type = "component", index = 5}
categories.hat = {type = "prop", index = 0}
categories.glasses = {type = "prop", index = 1}
categories.earrings = {type = "prop", index = 2}
categories.watches = {type = "prop", index = 6}
categories.bproof = {type = "component", index = 9}

opened = false
local hasInitialized = false
saveClothes = {}


function openClothShop(shopLabel, shopCategories)
    opened = not opened
    if opened then
        if Config.Inventory == "qs-inventory" then
            exports["qs-inventory"]:setInClothing(true)
        end
    end
    local playerPed = PlayerPedId()
    if Config.AppearanceRessource == 'skinchanger' then
        local p = promise.new()
        TriggerEvent('skinchanger:getSkin', function(skin)
            p:resolve(skin)
        end)
        local skin = Citizen.Await(p)
        local model = GetEntityModel(playerPed)
        local maleHash = GetHashKey('mp_m_freemode_01')
        local femaleHash = GetHashKey('mp_f_freemode_01')
        if model ~= maleHash and model ~= femaleHash then
            TriggerEvent('skinchanger:loadDefaultModel', skin.sex == 0)
            local attempts = 0
            while attempts < 50 do
                model = GetEntityModel(PlayerPedId())
                if model == maleHash or model == femaleHash then
                    break
                end
                attempts = attempts + 1
                Wait(100)
            end
        end
    end
    for categoryName, category in pairs(categories) do
        if category.type == "component" then
            saveClothes[categoryName] = {
                drawable = GetPedDrawableVariation(playerPed, category.index),
                texture = GetPedTextureVariation(playerPed, category.index)
            }
        elseif category.type == "prop" then
            saveClothes[categoryName] = {
                drawable = GetPedPropIndex(playerPed, category.index),
                texture = GetPedPropTextureIndex(playerPed, category.index)
            }
        end
    end
    SetNuiFocus(opened, opened)
    DisplayRadar(not opened)
    local clothingCounts = {}
    for categoryName, category in pairs(categories) do
        if category.type == "component" then
            clothingCounts[categoryName] = GetNumberOfPedDrawableVariations(playerPed, category.index)
        elseif category.type == "prop" then
            clothingCounts[categoryName] = GetNumberOfPedPropDrawableVariations(playerPed, category.index)
        end
    end
    if not hasInitialized then

        SendNUIMessage({
            type = "openClothShop",
            value = opened,
            prices = Config.Prices,
            label = shopLabel,
            categories = shopCategories,
            translations = Config.Translations[Config.Lang],
            counts = clothingCounts
        })
        hasInitialized = true
    else
        SendNUIMessage({
            type = "openClothShop",
            value = opened,
            label = shopLabel,
            categories = shopCategories,
            counts = clothingCounts
        })
    end
    SendNUIMessage({
        type = "clothingCounts",
        counts = clothingCounts
    })
    if not opened then
        DestroySkinCam()
    else
        CreateSkinCam("body")
    end
end

RegisterCommand("clothShop", openClothShop, false)

RegisterNUICallback("closeMenu", function(data, callback)
    opened = false
    SetNuiFocus(false, false)
    DestroySkinCam()
    DisplayRadar(true)
    if Config.Inventory == "qs-inventory" then
        exports["qs-inventory"]:setInClothing(false)
    end
    setOutfit(saveClothes)
    callback("ok")
end)

RegisterNetEvent("nvCloth:closeMenu")
AddEventHandler("nvCloth:closeMenu", function()
    opened = false
    SetNuiFocus(false, false)
    DestroySkinCam()
    DisplayRadar(true)
    if Config.Inventory == "qs-inventory" then
        exports["qs-inventory"]:setInClothing(false)
    end
    -- Restaurer la tenue originale si le menu est fermé sans achat
    setOutfit(saveClothes)
end)