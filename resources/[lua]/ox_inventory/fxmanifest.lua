fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
name 'ox_inventory'
author 'Overextended'
version '2.44.8'
repository 'github.com/communityox/ox_inventory'
description 'Inventory N E V A'

dependencies {
    '/server:6116',
    '/onesync',
    'oxmysql',
    'ox_lib',
}

shared_script '@ox_lib/init.lua'

ox_libs {
    'locale',
    'table',
    'math',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'init.lua',
}

client_script 'init.lua'

ui_page 'web/build/index.html'

files {
    'client.lua',
    'server.lua',
    'locales/*.json',
    'web/clothes/*.svg',
    'web/build/index.html',
    'web/build/assets/*.js',
    'web/build/assets/*.css',
    'web/*.svg',
    'web/build/*.svg',
    'web/images/*.png',
    'modules/**/shared.lua',
    'modules/**/client.lua',
    'modules/bridge/**/client.lua',
    'modules/clothing/*.lua',
    'data/*.lua',
    'config/*.lua',
}

escrow_ignore {
    'data/*.lua',
    'modules/**/*.lua',
    'setup/convert.lua',
    'client.lua',
    'init.lua',
    'server.lua'
}
dependency '/assetpacks'