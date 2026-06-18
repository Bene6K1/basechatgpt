fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'NEVA'
description ''
version '1.0.1'

escrow 'yes'

dependencies {
    'es_extended',
    'ox_inventory',
    'ui'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

escrow_ignore {
    'config.lua'
}

client_scripts {
    'client/main.lua',
    'client/equipment_manager.lua',
    'client/ped_preview.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/equipment_tracker.lua',
    'audio/**/._*.js',
}

