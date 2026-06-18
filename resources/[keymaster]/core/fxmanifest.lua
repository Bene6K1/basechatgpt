fx_version 'cerulean'
game 'gta5'
this_is_a_map 'yes'
author "Sunny"

lua54 'yes'

version '5.0.86'

escrow_ignore {
    "fr.lua",
    "logs.lua",
    "peds.lua",
    "zones.lua",
    "config/**",
    "config/**/**",
    "config/**/**/**",
}
ui_page 'dist/nui-main/index.html'

files {
    'dist/UI/index.html',
    'dist/UI/*.css',
    'dist/UI/*.js',
    'dist/UI/images/*.png',
    'dist/UI/images/*.gif',
    'dist/UI/img/*.png',
    'dist/UI/img/*.svg',
    'dist/UI/img/*.webp',
    'dist/UI/sounds/*.ogg',
    'dist/UI/fonts/*.ttf',
    'dist/nui-main/index.html',
    'dist/cardealer/index.html',
    'dist/cardealer/css/*.css',
    'dist/cardealer/js/*.js',
    'dist/cardealer/assets/*.png',
    'dist/cardealer/fond.png',
    'dist/modules/[World]/vehicles/nui/index.html',
    'dist/modules/[World]/vehicles/nui/style.css',
    'dist/modules/[World]/vehicles/nui/script.js',
    'dist/modules/[World]/vehicles/nui/js/*.js',
    'dist/modules/[World]/vehicles/nui/fonts/*.ttf',
    'dist/modules/[World]/vehicles/nui/assets/*.png',
    'dist/modules/[World]/nv_keys/web/build/*.*',
    'dist/modules/[World]/nv_keys/web/build/**/*.*',
    'dist/modules/[World]/nv_keys/locales/*.json',
    'dist/modules/[Activity]/afk/html/index.html',
    'dist/modules/[Activity]/afk/html/script.js',
    'dist/modules/[Activity]/afk/html/style.css',
}

shared_script '@ox_lib/init.lua'

shared_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'config/Config.lua',
    'config/**/**/*.lua',
    'dist/modules/[World]/nv_keys/config/*.lua',
    'dist/modules/[World]/nv_keys/shared/locales.lua',
    'dist/modules/**/shared/*.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@es_extended/locale.lua',

    -- ---- ---- ---- NEW RageUI NEVA ---- ---- ---- --
       "dist/RageUI/Font/importFont.lua",
       "dist/RageUI/init.lua",
       "dist/RageUI/RMenu.lua",
       "dist/RageUI/menu/RageUI.lua",
       "dist/RageUI/menu/Menu.lua",
       "dist/RageUI/menu/MenuController.lua",
       "dist/RageUI/components/*.lua",
       "dist/RageUI/menu/elements/*.lua",
       "dist/RageUI/menu/items/*.lua",
       "dist/RageUI/menu/panels/*.lua",
       "dist/RageUI/menu/windows/*.lua",

    -- ---- ---- ---- OLD RageUI NEVA ---- ---- ---- --
    --    "dist/RageUInv/Font/importFont.lua",
    --    "dist/RageUInv/init.lua",
    --    "dist/RageUInv/RMenu.lua",
    --    "dist/RageUInv/menu/RageUI.lua",
    --    "dist/RageUInv/menu/Menu.lua",
    --    "dist/RageUInv/menu/MenuController.lua",
    --    "dist/RageUInv/components/*.lua",
    --    "dist/RageUInv/menu/elements/ItemsBadge.lua",
    --    "dist/RageUInv/menu/elements/*.lua",
    --    "dist/RageUInv/menu/items/*.lua",
    --    "dist/RageUInv/menu/panels/*.lua",
    --    "dist/RageUInv/menu/windows/*.lua",

    -- ---- ---- ---- RageUI Rework CoraUI ---- ---- ---- --
    -- "dist/RageUIv2/RMenu.lua",
    -- "dist/RageUIv2/menu/RageUI.lua",
    -- "dist/RageUIv2/menu/Menu.lua",
    -- "dist/RageUIv2/menu/MenuController.lua",
    -- "dist/RageUIv2/components/*.lua",
    -- "dist/RageUIv2/menu/elements/*.lua",
    -- "dist/RageUIv2/menu/items/*.lua",
    -- "dist/RageUIv2/menu/panels/*.lua",
    -- "dist/RageUIv2/menu/windows/*.lua",

    -- ---- ---- ---- RageUI Rework FlashFA ---- ---- ---- --
    -- "dist/RageUIFlashFA/RMenu.lua",
    -- "dist/RageUIFlashFA/menu/RageUI.lua",
    -- "dist/RageUIFlashFA/menu/Menu.lua",
    -- "dist/RageUIFlashFA/menu/MenuController.lua",
    -- "dist/RageUIFlashFA/components/*.lua",
    -- "dist/RageUIFlashFA/menu/elements/*.lua",
    -- "dist/RageUIFlashFA/menu/items/*.lua",
    -- "dist/RageUIFlashFA/menu/panels/*.lua",
    -- "dist/RageUIFlashFA/menu/windows/*.lua",

    -- -- ---- ---- ---- RageUI Rework Sensity ---- ---- ---- --
    -- "dist/RageUISensity/RMenu.lua",
    -- "dist/RageUISensity/menu/RageUI.lua",
    -- "dist/RageUISensity/menu/Menu.lua",
    -- "dist/RageUISensity/menu/MenuController.lua",
    -- "dist/RageUISensity/components/*.lua",
    -- "dist/RageUISensity/menu/elements/*.lua",
    -- "dist/RageUISensity/menu/items/*.lua",
    -- "dist/RageUISensity/menu/panels/*.lua",
    -- "dist/RageUISensity/menu/windows/*.lua",

    "config/safezone/*.lua",
    'dist/init/cl_esx.lua',
    'fr.lua',

    'dist/functions/functions.lua',
    'dist/modules/[Utils]/utils/client/*.lua',
    'dist/modules/**/client/*.lua',
    'dist/modules/**/**/client.lua',
    'dist/modules/async/client/main.lua',
    
    'zones.lua',
    'peds.lua',
    'dist/UI/client/*.lua',
}

server_scripts {
    '@es_extended/locale.lua',
    '@oxmysql/lib/MySQL.lua',
    'dist/init/sv_esx.lua',
    'fr.lua',
    'logs.lua',

    'config/afk/config.lua',
    'dist/modules/**/server/*.lua',
    'dist/modules/**/**/server.lua',
    'dist/thread/thread.lua',

    'dist/UI/server/*.lua',
}

exports {
    'getBoutiquePoint',
    'cl_GetWeaponPerm',
    'sv_GetWeaponPerm',

}
dependencies {
    '/assetpacks',
    'nv_me'
}