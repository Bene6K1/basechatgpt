fx_version 'cerulean'
game 'gta5'

author 'nevaaa'
description 'Système de mission de GoFast'
version '1.0.0'

dependency 'nv_interact'

shared_scripts {
    'config.lua'
}

client_scripts {
    'utils/sound_manager.lua',
    'client/cl_gofast.lua'
}

server_scripts {
    'server/sv_gofast.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/contact.png',
    'html/me.png'
}

escrow_ignore {
    'config.lua'
}

lua54 'yes'