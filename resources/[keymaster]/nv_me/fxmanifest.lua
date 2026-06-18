fx_version 'cerulean'
game 'gta5'

author 'N E V A'
version '1.0.0'
lua54 'yes'

escrow 'yes'
ui_page 'web/index.html'


files {
    'web/index.html',
    'web/assets/*',
    'web/icon/arrow.png',
}

client_scripts {
    'client/cl_*.lua',
}

server_scripts {
    'server/sv_*.lua',
}

shared_scripts {
    'shared/config.lua',
}

escrow_ignore {
    'shared/config.lua'
}


dependency '/assetpacks'

