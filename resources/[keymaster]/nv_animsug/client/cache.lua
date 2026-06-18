local cacheStorage = {}

function SaveCache(key, data, ttl)
    cacheStorage[key] = {
        data = data,
        maxAge = GetGameTimer() + (ttl or 3000)
    }
end



function UseCache(key, callback, ttl)
    local cached = cacheStorage[key]
    
    if not cached or cached.maxAge < GetGameTimer() then
        local result = {callback()}
        SaveCache(key, result, ttl)
        return table.unpack(result)
    end
    
    return table.unpack(cached.data)
end