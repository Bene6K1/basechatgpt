local Core = nil

CreateThread(function()
    Core = GetCore()
end)

function TriggerCallback(callbackName, callbackData)
    local callbackResult = false
    local callbackStatus = "UNKNOWN"
    local timeoutCounter = 0
    
    while Core == nil do
        Wait(0)
    end
    
    if Config.Framework == "esx" then
        Core.TriggerServerCallback(callbackName, function(result)
            callbackStatus = "SUCCESS"
            callbackResult = result
        end, callbackData)
    else
        Core.Functions.TriggerCallback(callbackName, function(result)
            callbackStatus = "SUCCESS"
            callbackResult = result
        end, callbackData)
    end
    
    CreateThread(function()
        while callbackStatus == "UNKNOWN" do
            Wait(1000)
            
            if timeoutCounter == 4 then
                callbackStatus = "FAILED"
                callbackResult = false
                break
            end
            
            timeoutCounter = timeoutCounter + 1
        end
    end)
    
    while callbackStatus == "UNKNOWN" do
        Wait(0)
    end
    
    return callbackResult
end

exports("TriggerCallback", TriggerCallback)

