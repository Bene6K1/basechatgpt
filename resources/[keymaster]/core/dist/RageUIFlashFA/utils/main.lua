function RenderRectangle(X, Y, Width, Height, R, G, B, A)
    local X, Y, Width, Height = (tonumber(X) or 0) / 1920, (tonumber(Y) or 0) / 1080, (tonumber(Width) or 0) / 1920, (tonumber(Height) or 0) / 1080
    DrawRect(X + Width * 0.5, Y + Height * 0.5, Width, Height, tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
end

---@param TextureDictionary string
---@param TextureName string
---@param X number
---@param Y number
---@param Width number
---@param Height number
---@param Heading number
---@param R number
---@param G number
---@param B number
---@param A number
---@return nil
---@public
function RenderSprite(TextureDictionary, TextureName, X, Y, Width, Height, Heading, R, G, B, A)
    ---@type number
    local X, Y, Width, Height = (tonumber(X) or 0) / 1920, (tonumber(Y) or 0) / 1080, (tonumber(Width) or 0) / 1920, (tonumber(Height) or 0) / 1080
    if not HasStreamedTextureDictLoaded(TextureDictionary) then RequestStreamedTextureDict(TextureDictionary, true) end
    DrawSprite(TextureDictionary, TextureName, X + Width * 0.5, Y + Height * 0.5, Width, Height, Heading or 0, tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
end

---@param str string
function StringToArray(str)
    local charCount = #str
    local strCount = math.ceil(charCount / 99)
    local strings = {}
    for i = 1, strCount do
        local start = (i - 1) * 99 + 1
        local clamp = math.clamp(#string.sub(str, start), 0, 99)
        local finish = ((i ~= 1) and (start - 1) or 0) + clamp
        strings[i] = string.sub(str, start, finish)
    end
    return strings
end

---@param str string
---@param font number
---@param scale number
---@return _G
---@public
function MeasureStringWidth(str, font, scale)
    BeginTextCommandWidth('CELL_EMAIL_BCON')
    AddTextComponentSubstringPlayerName(str)
    SetTextFont(font or 0)
    SetTextScale(1.0, scale or 0)
    return EndTextCommandGetWidth(true) * 1920
end

---@param str string
function AddText(str)
    local str = tostring(str)
    local charCount = #str
    if charCount < 100 then
        AddTextComponentSubstringPlayerName(str)
    else
        local strings = StringToArray(str)
        for s = 1, #strings do
            AddTextComponentSubstringPlayerName(strings[s])
        end
    end
end

---@param Text string
---@param X number
---@param Y number
---@param Font number
---@param Scale number
---@param R number
---@param G number
---@param B number
---@param A number
---@param Alignment string
---@param DropShadow boolean
---@param Outline boolean
---@param WordWrap number
---@return function
---@public
function GetLineCount(Text, X, Y, Font, Scale, R, G, B, A, Alignment, DropShadow, Outline, WordWrap)
    ---@type table
    local Text, X, Y = tostring(Text), (tonumber(X) or 0) / 1920, (tonumber(Y) or 0) / 1080
    SetTextFont(Font or 0)
    SetTextScale(1.0, Scale or 0)
    SetTextColour(tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
    if DropShadow then
        SetTextDropShadow()
    end
    if Outline then
        SetTextOutline()
    end
    if Alignment ~= nil then
        if Alignment == 1 or Alignment == 'Center' or Alignment == 'Centre' then
            SetTextCentre(true)
        elseif Alignment == 2 or Alignment == 'Right' then
            SetTextRightJustify(true)
        end
    end
    if tonumber(WordWrap) and tonumber(WordWrap) ~= 0 then
        if Alignment == 1 or Alignment == 'Center' or Alignment == 'Centre' then
            SetTextWrap(X - ((WordWrap / 1920) / 2), X + ((WordWrap / 1920) / 2))
        elseif Alignment == 2 or Alignment == 'Right' then
            SetTextWrap(0, X)
        else
            SetTextWrap(X, X + (WordWrap / 1920))
        end
    else
        if Alignment == 2 or Alignment == 'Right' then
            SetTextWrap(0, X)
        end
    end
    BeginTextCommandLineCount('CELL_EMAIL_BCON')
    AddText(Text)
    return GetTextScreenLineCount(X, Y)
end

---@param Text string
---@param X number
---@param Y number
---@param Font number
---@param Scale number
---@param R number
---@param G number
---@param B number
---@param A number
---@param Alignment string
---@param DropShadow boolean
---@param Outline boolean
---@param WordWrap number
---@return nil
---@public
function RenderText(Text, X, Y, Font, Scale, R, G, B, A, Alignment, DropShadow, Outline, WordWrap)
    ---@type table
    local Text, X, Y = tostring(Text), (tonumber(X) or 0) / 1920, (tonumber(Y) or 0) / 1080
    SetTextFont(Font or 0)
    SetTextScale(1.0, Scale or 0)
    SetTextColour(tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
    if DropShadow then
        SetTextDropShadow()
    end
    if Outline then
        SetTextOutline()
    end
    if Alignment ~= nil then
        if Alignment == 1 or Alignment == 'Center' or Alignment == 'Centre' then
            SetTextCentre(true)
        elseif Alignment == 2 or Alignment == 'Right' then
            SetTextRightJustify(true)
        end
    end
    if tonumber(WordWrap) and tonumber(WordWrap) ~= 0 then
        if Alignment == 1 or Alignment == 'Center' or Alignment == 'Centre' then
            SetTextWrap(X - ((WordWrap / 1920) / 2), X + ((WordWrap / 1920) / 2))
        elseif Alignment == 2 or Alignment == 'Right' then
            SetTextWrap(0, X)
        else
            SetTextWrap(X, X + (WordWrap / 1920))
        end
    else
        if Alignment == 2 or Alignment == 'Right' then
            SetTextWrap(0, X)
        end
    end
    BeginTextCommandDisplayText('CELL_EMAIL_BCON')
    AddText(Text)
    EndTextCommandDisplayText(X, Y)
end

---@class Enum
local enums = {
    __index = function(table, key)
        if rawget(table.enums, key) then
            return key
        end
    end
}
---Enum
---@param t table
---@return Enum
function RageUI.Enum(t)
    local e = { enums = t }
    return setmetatable(e, enums)
end

---@param Library string
---@param Sound string
---@param IsLooped boolean
---@return nil
---@public
function RageUI.PlaySound(Library, Sound, IsLooped)
    local audioId
    if not IsLooped then
        PlaySoundFrontend(-1, Sound, Library, true)
    else
        if not audioId then
            CreateThread(function()
                audioId = GetSoundId()
                PlaySoundFrontend(audioId, Sound, Library, true)
                Wait(0.01)
                StopSound(audioId)
                ReleaseSoundId(audioId)
                audioId = nil
            end)
        end
    end
end

function RageUI.Info(data)
    local title = data.title or nil
    local info = data.info or {}
    local leftText = info.left or {}
    local rightText = info.right or {}
    local texture = data.texture or nil
    local lineCount = math.max(#leftText, #rightText)
    if title then
        RenderText("~h~" .. title .. "~s~", 330 + 20 + 100, 7, 0, 0.30, 255, 255, 255, 255, 0)
    end
    if #leftText > 0 then
        RenderText(table.concat(leftText, "\n"), 330 + 20 + 100, title and 37 or 7, 0, 0.25, 255, 255, 255, 255, 0)
    end
    if #rightText > 0 then
        RenderText(table.concat(rightText, "\n"), 330 + 432 + 100, title and 37 or 7, 0, 0.25, 255, 255, 255, 255, 2)
    end
    local rectangleHeight = title and 50 + (lineCount * 20) or ((lineCount + 1) * 20)
    RenderRectangle(330 + 10 + 100, 0, 432, rectangleHeight, 20, 24, 28, 255)
    if texture and texture.dictName and texture.txtName then
        -- lib.print.print("Attempting to load texture:", texture.dictName, texture.txtName)
        local textureWidth = texture.width or 432
        local textureHeight = texture.height or 100
        local textureX = 330 + 10 + 100
        local textureY = rectangleHeight
        RenderSprite(texture.dictName, texture.txtName, textureX, textureY, textureWidth, textureHeight, 0, 255, 255, 255, 255)
    else
        lib.print.error("[MENU.Info] No valid texture data provided")
    end
end

Visual = Visual or {}

local function AddLongString(txt)
    for i = 100, string.len(txt), 99 do
        local sub = string.sub(txt, i, i + 99)
        AddTextComponentSubstringPlayerName(sub)
    end
end

function Visual.Subtitle(text, time)
    ClearPrints()
    BeginTextCommandPrint('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandPrint(time and math.ceil(time) or 0, true)
end

function Visual.FloatingHelpText(text, sound, loop)
    BeginTextCommandDisplayHelp('jamyfafi')
    AddTextComponentSubstringPlayerName(text)
    if string.len(text) > 99 then
        AddLongString(text)
    end
    EndTextCommandDisplayHelp(0, loop or 0, sound or true, -1)
end

function Visual.Prompt(text, spinner)
    BeginTextCommandBusyspinnerOn('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandBusyspinnerOn(spinner or 1)
end

function Visual.PromptDuration(duration, text, spinner)
    CreateThread(function()
        Wait(0)
        Visual.Prompt(text, spinner)
        Wait(duration)
        if (BusyspinnerIsOn()) then
            BusyspinnerOff()
        end
    end)
end

RegisterNetEvent('Visual:Popup')
AddEventHandler('Visual:Popup', function(array)
    RageUI.Popup(array)
end)

function Visual.Popup(array)
    ClearPrints()
    if (array.colors == nil) then
        SetNotificationBackgroundColor(140)
    else
        SetNotificationBackgroundColor(array.colors)
    end
    SetNotificationTextEntry('STRING')
    if (array.message == nil) then
        error('Missing arguments, message')
    else
        AddTextComponentString(tostring(array.message))
    end
    DrawNotification(false, true)
    if (array.sound ~= nil) then
        if (array.sound.audio_name ~= nil) then
            if (array.sound.audio_ref ~= nil) then
                PlaySoundFrontend(-1, array.sound.audio_name, array.sound.audio_ref, true)
            else
                error('Missing arguments, audio_ref')
            end
        else
            error('Missing arguments, audio_name')
        end
    end
end

function Visual.Text(array)
    ClearPrints()
    SetTextEntry_2('STRING')
    if (array.message ~= nil) then
        AddTextComponentString(tostring(array.message))
    else
        error('Missing arguments, message')
    end
    if (array.time_display ~= nil) then
        DrawSubtitleTimed(tonumber(array.time_display), 1)
    else
        DrawSubtitleTimed(6000, 1)
    end
    if (array.sound ~= nil) then
        if (array.sound.audio_name ~= nil) then
            if (array.sound.audio_ref ~= nil) then
                PlaySoundFrontend(-1, array.sound.audio_name, array.sound.audio_ref, true)
            else
                error('Missing arguments, audio_ref')
            end
        else
            error('Missing arguments, audio_name')
        end
    end
end

-- Commandes de test
RegisterCommand('test_subtitle', function()
    Visual.Subtitle('Bienvenue dans le serveur !', 5000)
end, true)

RegisterCommand('test_helptext', function()
    Visual.FloatingHelpText('pour interagir.', true, false)
end, true)

RegisterCommand('test_prompt', function()
    Visual.Prompt('Chargement en cours...', 1)
    Wait(3000)
    if BusyspinnerIsOn() then
        BusyspinnerOff()
    end
end, true)

RegisterCommand('test_promptduration', function()
    Visual.PromptDuration(5000, 'Connexion au serveur...', 1)
end, true)

RegisterCommand('test_popup', function()
    Visual.Popup({
        message = 'Bienvenue dans le serveur !',
        colors = 1,
        sound = {audio_name = 'CONFIRM_BEEP', audio_ref = 'HUD_MINI_GAME_SOUNDSET'}
    })
end, true)

RegisterCommand('test_text', function()
    Visual.Text({
        message = 'Chargement terminé !',
        time_display = 5000,
        sound = {audio_name = 'CONFIRM_BEEP', audio_ref = 'HUD_MINI_GAME_SOUNDSET'}
    })
end, true)

RegisterCommand('test_event_popup', function()
    TriggerEvent('Visual:Popup', {
        message = 'Notification déclenchée via événement.',
        colors = 140,
        sound = {audio_name = 'CONFIRM_BEEP', audio_ref = 'HUD_MINI_GAME_SOUNDSET'}
    })
end, true)