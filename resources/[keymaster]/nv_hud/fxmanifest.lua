fx_version 'cerulean'
lua54 'yes'
game 'gta5'

author 'NEVA'
description 'NEVA HUD - Server Info + Player Status'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/normalize.css',
    'html/css/style.css',
    'html/js/hud.js',
    'html/assets/images/image.png',
    'html/assets/fonts/Gilroy-Bold.ttf',
    'html/assets/fonts/Gilroy-Medium.ttf',
    'html/assets/fonts/Gilroy-SemiBold.ttf',
    'html/assets/fonts/AGENCYB.TTF'
}

client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts {
    'server.lua'
}

escrow_ignore {
    'config.lua'
}
