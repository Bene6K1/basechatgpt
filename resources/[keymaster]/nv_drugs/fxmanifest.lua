fx_version 'cerulean'
game 'gta5'
this_is_a_map 'yes'
author 'Lyoz'
version '1.0.0'
lua54 'yes'

escrow_ignore {
  "config.lua",
  "phone/config_phone.lua",
  "RageUI/RMenu.lua",
  "RageUI/menu/RageUI.lua",
  "RageUI/menu/Menu.lua",
  "RageUI/menu/MenuController.lua",
  "RageUI/components/*.lua",
  "RageUI/menu/elements/*.lua",
  "RageUI/menu/items/*.lua",
  "RageUI/menu/panels/*.lua",
  "RageUI/menu/windows/*.lua",
}


shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/locale.lua',
    'config.lua',
}

client_scripts {
    "RageUI/menu/init_globals.lua",
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",
    "locales/*.lua",
    "config.lua",
    "crew/cl_crew.lua",
    "drug/cl_drug.lua",
    "map/*.lua",
    "territories/cl_territories.lua",
    "phone/cl_phone.lua",
    "phone/cl_retail.lua",
    "phone/config_phone.lua",
}

before_level_meta_data_file 'stream/[font]/FontStyle.gfx'

server_scripts {
    "@es_extended/locale.lua",
    "@oxmysql/lib/MySQL.lua",
    "locales/*.lua",
    "config.lua",
    "crew/sv_discord.lua",
    "crew/sv_crew.lua",
    "drug/sv_drug.lua",
    "drug/sv_police.lua",
    "territories/sv_territories.lua",
    "phone/config_phone.lua",
    "phone/sv_phone.lua",
}

ui_page 'html/index.html'

files {
  'MINIMAP_LOADER.gfx',
  'html/territories/*.webp',
  'html/logo/*.webp',
  'html/index.html',
  'html/style.css',
  'html/script.js',
  'territories/territories.json',
  'html/css/*.css',
  'html/css/jquery/*.css',
  'html/js/*.js',
  'html/js/jquery/*.js',
  'html/img/*.png',
  'html/img/inventory/*.png',
  'html/audio/*.mp3'
}

exports {
    'OpenTerritoryDashboard',
    'IsPlayerInTerritory'
}

dependency '/assetpacks'