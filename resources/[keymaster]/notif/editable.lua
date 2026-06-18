local resourceName = GetCurrentResourceName()

local replacements = {
    -- Codes avec ~
    ["~r~"] = "<span style='color:rgb(224, 50, 50);'>",
    ["~g~"] = "<span style='color:rgb(114, 204, 114);'>",
    ["~b~"] = "<span style='color:rgb(93, 182, 229);'>",
    ["~f~"] = "<span style='color:rgb(93, 182, 229);'>",
    ["~y~"] = "<span style='color:rgb(240, 200, 80);'>",
    ["~c~"] = "<span style='color:rgb(140, 140, 140);'>",
    ["~t~"] = "<span style='color:rgb(140, 140, 140);'>",
    ["~o~"] = "<span style='color:rgb(255, 133, 85);'>",
    ["~p~"] = "<span style='color:rgb(132, 102, 226);'>",
    ["~q~"] = "<span style='color:rgb(203, 54, 148);'>",
    ["~m~"] = "<span style='color:rgb(100, 100, 100);'>",
    ["~l~"] = "<span style='color:rgb(0, 0, 0);'>",
    ["~d~"] = "<span style='color:rgb(47, 92, 115);'>",
    ["~h~"] = "<b>",
    ["~bold~"] = "<b>",
    ["~italic~"] = "<i>",
    ["~wanted_star~"] = "★︎",
    ["~ws~"] = "★︎",
    ["~EX_R*~"] = "R⭐",
    ["~s~"] = "</span>",
    ["~w~"] = "</span>",
    ["~nrt*~"] = "<br>",
    ["~n~"] = "<br>",
    ["\n"] = "<br>",
    -- Codes avec ^ (FiveM standard)
    ["^0"] = "</span>", -- Reset
    ["^1"] = "<span style='color:rgb(255, 0, 0);'>", -- Red
    ["^2"] = "<span style='color:rgb(0, 255, 0);'>", -- Green
    ["^3"] = "<span style='color:rgb(255, 255, 0);'>", -- Yellow
    ["^4"] = "<span style='color:rgb(0, 0, 255);'>", -- Blue
    ["^5"] = "<span style='color:rgb(0, 255, 255);'>", -- Cyan
    ["^6"] = "<span style='color:rgb(255, 0, 255);'>", -- Magenta
    ["^7"] = "<span style='color:rgb(255, 255, 255);'>", -- White
    ["^8"] = "<span style='color:rgb(128, 128, 128);'>", -- Grey
    ["^9"] = "<span style='color:rgb(192, 192, 192);'>", -- Light Grey
}

local gtaPicturesPattern = { -- Gta Icons for Notifications 
    "CHAR_",
    "DIA_",
    "HC_N_",
    "WEB_"
}

local notificationsVisible = true

local function convertMessage(str)
    str = tostring(str)
    
    -- Fermer d'abord tous les spans ouverts avant un nouveau code couleur
    -- Remplacer les codes ^ en premier (ordre important)
    str = string.gsub(str, "%^0", "</span>")
    str = string.gsub(str, "%^1", "</span><span style='color:rgb(255, 0, 0);'>")
    str = string.gsub(str, "%^2", "</span><span style='color:rgb(0, 255, 0);'>")
    str = string.gsub(str, "%^3", "</span><span style='color:rgb(255, 255, 0);'>")
    str = string.gsub(str, "%^4", "</span><span style='color:rgb(0, 0, 255);'>")
    str = string.gsub(str, "%^5", "</span><span style='color:rgb(0, 255, 255);'>")
    str = string.gsub(str, "%^6", "</span><span style='color:rgb(255, 0, 255);'>")
    str = string.gsub(str, "%^7", "</span><span style='color:rgb(255, 255, 255);'>")
    str = string.gsub(str, "%^8", "</span><span style='color:rgb(128, 128, 128);'>")
    str = string.gsub(str, "%^9", "</span><span style='color:rgb(192, 192, 192);'>")
    
    -- Ensuite, remplacer les autres codes
    for pattern, value in pairs(replacements) do
        -- Sauter les codes ^ déjà traités
        if not string.find(pattern, "^%^") then
            str = string.gsub(str, pattern, value)
        end
    end
    
    -- Fermer le dernier span ouvert à la fin si nécessaire
    -- (mais seulement si on a ouvert un span)
    if string.find(str, "<span") and not string.find(str, "</span>%s*$") then
        str = str .. "</span>"
    end
    
    return str
end

local function GetImage(_type)
    local image = nil
    if _type == 'success' then
        image = "nui://" .. resourceName .. "/images/success.png"
    elseif _type == 'error' then
        image = "nui://" .. resourceName .. "/images/error.png"
    elseif _type == 'warn' or _type == 'warning' then
        image = "nui://" .. resourceName .. "/images/warning.png"
    elseif _type == 'info' or _type == 'inform' then
        image = "nui://" .. resourceName .. "/images/info.png"
    else
        image = nil
    end
    return image
end

local Send = function(text, time, _type, image)
    if not notificationsVisible then return end

    if type(time) ~= "number" or time >= 100 then
        time = 8.5
    end

    if not image then
        image = GetImage(_type)
    else
        local isGtaIcon = false
        if type(image) == "string" then
            for _, pattern in ipairs(gtaPicturesPattern) do
                if string.find(image:upper(), pattern) then
                    isGtaIcon = true
                    break
                end
            end
            if isGtaIcon then
                image = "nui://" .. resourceName .. "/icons/" .. image:upper() .. ".png"
            end
        end
    end
    SendReactMessage('SendNotif:Classic', { content = convertMessage(text), time = time, image = image })
end

exports('Send', Send)

local SendAdvanced = function(text, sender, subject, image, _type, time, image_mid, image_bottom, hex_color_badge, text_badge, hex_color_footer_badge, text_footer_badge)
    if not notificationsVisible then return end

    if type(time) ~= "number" or time >= 100 then
        time = 8.5
    end

    if not image then
        image = GetImage(_type)
    else
        local isGtaIcon = false
        if type(image) == "string" then
            for _, pattern in ipairs(gtaPicturesPattern) do
                if string.find(image:upper(), pattern) then
                    isGtaIcon = true
                    break
                end
            end
            if isGtaIcon then
                image = "nui://" .. resourceName .. "/icons/" .. image:upper() .. ".png"
            end
        end
    end
    SendReactMessage('SendNotif:Big', {
        content = '',
        time = time,
        icontop = image,
        texttop = sender or '',
        iconmid = image_mid,
        textmid = subject or '',
        iconbottom = image_bottom,
        textbottom = convertMessage(text) or '',
        colorbadge = hex_color_badge or '#272a307a',
        textbadge = text_badge,
        footerbadgecolor = hex_color_footer_badge or 'false',
        footerbadgetext = text_footer_badge or 'false',
    })
end

exports('SendAdvanced', SendAdvanced)

local HideNotifications = function()
    notificationsVisible = false
    SendReactMessage('Notifications:Hide', {})
end

local ShowNotifications = function()
    notificationsVisible = true
    SendReactMessage('Notifications:Show', {})
end

local AreNotificationsVisible = function()
    return notificationsVisible
end

exports('HideNotifications', HideNotifications)
exports('ShowNotifications', ShowNotifications)
exports('AreNotificationsVisible', AreNotificationsVisible)