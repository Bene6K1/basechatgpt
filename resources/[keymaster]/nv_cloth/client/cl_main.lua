Citizen.CreateThread(function()
    for shopKey, shop in pairs(Config.Shops) do
        if shop.coords then
            for _, shopCoords in pairs(shop.coords) do
                local blip = AddBlipForCoord(shopCoords.x, shopCoords.y, shopCoords.z)
                local blipStyle = (shop.blip and shop.blip.style) or 73
                local blipColor = (shop.blip and shop.blip.color) or 81
                local blipSize = (shop.blip and shop.blip.size) or 0.5
                local blipName = (shop.blip and shop.blip.name) or shop.label or "Boutique"
                SetBlipSprite(blip, blipStyle)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, blipSize)
                SetBlipColour(blip, blipColor)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blipName)
                EndTextCommandSetBlipName(blip)
            end
        end
    end

    local interactionIds = {}
    while true do
        local waitTime = 1000
        local playerPos = GetEntityCoords(PlayerPedId())
        for shopKey, shop in pairs(Config.Shops) do
            interactionIds[shopKey] = interactionIds[shopKey] or {}
            for idx, shopCoords in ipairs(shop.coords) do
                local distance = #(playerPos - shopCoords)
                if distance < 50.0 then
                    waitTime = 0
                end
                local activeId = interactionIds[shopKey][idx]
                if distance < 3.0 then
                    if not activeId and not opened then
                        interactionIds[shopKey][idx] = exports['nv_interact']:addInteractionPoint({
                            coords = shopCoords,
                            dist = 2.0,
                            key = 'E',
                            message = shop.label,
                            icon = 'fa-store',
                            onPress = function()
                                if not opened then
                                    openClothShop(shop.label, shop.categories)
                                end
                            end
                        })
                    end
                else
                    if activeId then
                        exports['nv_interact']:removeInteractionPoint(activeId)
                        interactionIds[shopKey][idx] = nil
                    end
                end
            end
        end
        Wait(waitTime)
    end
end)