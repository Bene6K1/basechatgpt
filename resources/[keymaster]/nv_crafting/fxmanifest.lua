fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Lyoz N E V A'
description 'NEVA Crafting System'
version '0.0.9'

shared_script {
    'config.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'client/client.lua',
    'client/nui.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
}

ui_page 'html/index.html'

files {
    'html/*',
    'html/**/*'
}

dependencies {
    'oxmysql',
    'nv_interact'
}

escrow_ignore {
    'config.lua'
}

dependency '/assetpacks'