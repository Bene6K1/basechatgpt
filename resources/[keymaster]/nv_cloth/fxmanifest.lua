fx_version 'cerulean'
game 'gta5'

author 'Neva'
version '1.0.0'
lua54 'yes'

escrow 'yes'
ui_page 'web/index.html'


files {
    'web/index.html',
    'web/assets/*',
    'web/clothing/*.png',
    'web/logo.png',
    'web/sw.js'
}

client_scripts {
    'client/cl_*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_*.lua',
}

shared_scripts {
    'shared/config.lua',
}

escrow_ignore {
    'shared/config.lua'
}


dependency '/assetpacks'