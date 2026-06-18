fx_version 'cerulean'
game 'gta5'

author 'N E V A'
version '1.0.1'
lua54 'yes'

escrow 'yes'
ui_page 'web/dist/index.html'


files {
    'web/dist/index.html',
    'web/dist/**',
}

client_scripts {
    'client/framework.lua',
    'client/pause.lua',
}

server_scripts {
    'server/pause.lua',
    'server/framework.lua',
}

shared_scripts {
    'shared/config.lua',
    'esx.lua'
}

escrow_ignore {
    'shared/config.lua',
    'esx.lua',
}

dependency '/assetpacks'