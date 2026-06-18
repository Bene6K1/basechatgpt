function sendMessage(action, data)
    if not action then return end

    SendNUIMessage({
        action = action,
        data = data
    })
end

function Focus(isFocused)
    SetNuiFocus(isFocused, isFocused)
end