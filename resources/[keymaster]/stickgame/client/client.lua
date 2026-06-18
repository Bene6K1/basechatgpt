t = 0
stat = nil
control = false

RegisterNUICallback("complete", function()
    SetNuiFocus(false, false)
    TriggerEvent("chatMessage", "SYSTEM", "success", "Stick Game completed!")
    stat = true
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("error", function()
    SetNuiFocus(false, false)
    stat = false
end)



function stickGame(callback, duration, header, text, level,rotationSpeed)
    control = true
    stat = nil
    t = 0

    SendNUIMessage({
        action = "STICK_GAME_OPEN", 
        time = duration, 
        header = header, 
        text = text, 
        level = level,
        speed = rotationSpeed
    })

    SetNuiFocus(true, true)

    while control do 
        Wait(1000)

        t = t + 1

        if t >= duration and not stat then
            SetNuiFocus(false, false)
            control = false
            t = 0
        end

        if stat == false then 
            callback(false)  
            control = false
        end 

        if stat == true then 
            callback(true)
            Wait(1000)
            control, t = false, 0
        end

        if stat == nil then 
            control = true 
        end

    end
end

exports('stickGame', stickGame)
