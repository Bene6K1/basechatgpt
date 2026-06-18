function cl_isitemperm(item)
    local isperm = false
    
    for _, permItem in ipairs(config.Perm) do
        if permItem == item then
            isperm = true
            break
        end
    end
    
    return isperm
end

exports("cl_isitemperm", cl_isitemperm)
