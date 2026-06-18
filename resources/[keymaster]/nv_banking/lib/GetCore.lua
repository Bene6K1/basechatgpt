function GetCore()
    local core = nil
    local framework = Config.Framework
    local retryCount = 0
    local maxRetries = 3
    local errorMessage = "^1[pixel-advancedbanking] - Framework is not selected in the config correctly if you're sure it's correct please check your events to get framework object^0"
    
    if framework == "oldesx" then
        while not core do
            TriggerEvent("esx:getSharedObject", function(obj)
                core = obj
            end)
            
            retryCount = retryCount + 1
            if retryCount == maxRetries then
                break
            end
            
            Citizen.Wait(1000)
        end
        
        if not core then
            print(errorMessage)
        end
    end
    
    if framework == "esx" then
        retryCount = 0
        local exportExists = pcall(function()
            exports.es_extended:getSharedObject()
        end)
        
        if exportExists then
            while not core do
                core = exports.es_extended:getSharedObject()
                
                retryCount = retryCount + 1
                if retryCount == maxRetries then
                    break
                end
                
                Citizen.Wait(1000)
            end
        end
        
        if not core then
            print(errorMessage)
        end
    end
    
    if framework == "qb" then
        retryCount = 0
        local exportExists = pcall(function()
            exports["qb-core"]:GetCoreObject()
        end)
        
        if exportExists then
            while not core do
                core = exports["qb-core"]:GetCoreObject()
                
                retryCount = retryCount + 1
                if retryCount == maxRetries then
                    break
                end
                
                Citizen.Wait(1000)
            end
        end
        
        if not core then
            print(errorMessage)
        end
    end
    
    if framework == "oldqb" then
        retryCount = 0
        
        while not core do
            retryCount = retryCount + 1
            
            TriggerEvent("QBCore:GetObject", function(obj)
                core = obj
            end)
            
            if retryCount == maxRetries then
                break
            end
            
            Citizen.Wait(1000)
        end
        
        if not core then
            print(errorMessage)
        end
    end
    
    if framework == "qbox" then
        retryCount = 0
        local exportExists = pcall(function()
            exports["qb-core"]:GetCoreObject()
        end)
        
        if exportExists then
            while not core do
                core = exports["qb-core"]:GetCoreObject()
                
                retryCount = retryCount + 1
                if retryCount == maxRetries then
                    break
                end
                
                Citizen.Wait(1000)
            end
        end
        
        if not core then
            print(errorMessage)
        end
    end
    
    return core, framework
end

