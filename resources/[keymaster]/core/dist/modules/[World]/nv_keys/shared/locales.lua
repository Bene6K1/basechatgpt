local Config <const> = require 'dist.modules.[World].nv_keys.config.main'

local function LoadLocaleFile(locale)
    local path = ('dist/modules/[World]/nv_keys/locales/%s.json'):format(locale)
    return LoadResourceFile(GetCurrentResourceName(), path)
end

local function LoadLocales()
    local file = LoadLocaleFile(Config.Locale)
    if not file then
        print(('[nv_keys] Locale "%s" introuvable, utilisation du fallback "en".'):format(Config.Locale))
        file = LoadLocaleFile('en')
        if not file then
            error('[nv_keys] Impossible de charger les locales "en".')
        end
    end

    if file == '' then
        error('[nv_keys] Fichier de locale vide.')
    end

    local success, content = pcall(json.decode, file)
	if not success then
        error(('[nv_keys] Erreur de décodage JSON: %s'):format(content))
    end

    if type(content) ~= 'table' then
        error('[nv_keys] Format de locale invalide (table attendue).')
    end

    return {
        LUA = content.LUA or {},
        NUI = content.NUI or {}
    }
end

local LocaleData = LoadLocales()
NVKeysLocales = LocaleData.LUA or {}
NVKeysLocalesNUI = LocaleData.NUI or {}

function _T(key, ...)
    local parts = {}
    for part in string.gmatch(key, "[^.]+") do
        parts[#parts+1] = part
    end

    local value = NVKeysLocales
    for i=1, #parts do
        if value[parts[i]] then
            value = value[parts[i]]
        else
            return key
        end
    end

    if type(value) == "string" then
        return value:format(...)
    end

    return key
end
