fx_version 'cerulean'
game 'gta5'

author 'eth'
version '1.0.0'
lua54 'yes'

escrow 'yes'
ui_page 'web/index.html'

files {
    'web/index.html',
    'web/assets/**',
    'web/img/**/*.png'
}

client_scripts {
    'client/cl_*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_*.lua',
}

shared_scripts {
    'shared/sh_*.lua',
    'esx.lua'
}

dependency '/assetpacks'