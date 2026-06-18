local function Content(source,data)
    local retval = false
    local items = (data and data.item) or {}
    local price = tonumber((data and data.price) or 0) or 0
    local method = (data and data.method) or nil
    local xPlayer = GetPlayer(source)
    if not xPlayer then print("Error Code 18, Open ticket") return false end
    if type(items) ~= 'table' or price <= 0 or not method then return false end
    local checkMoney = RemoveMoney(source, method, price)
    if not checkMoney then return false end
    for _, j in pairs(items) do
        local itemLabel = j and j.name
        local itemCount = tonumber(j and j.count) or 1
        if itemLabel and itemCount > 0 then
            for k, v in pairs(XMR.Items) do
                if v and itemLabel == v.label then
                    if AddItem(source, k, itemCount) then
                        retval = true
                    end
                    break
                end
            end
        end
    end
    return retval
end

if XMR.Framework == "qb" then
    QBCore.Functions.CreateCallback("cas-server:BuyProducts",function(source,cb,data) 
        local check = Content(source, data)
        cb(check)
    end)
elseif XMR.Framework == "esx" then
    ESX.RegisterServerCallback("cas-server:BuyProducts",function(source,cb,data) 
        local check = Content(source, data)
        cb(check)
    end)
end
