fx_version 'adamant'
game 'gta5'

author 'NEVA'
description 'SECURITY Deathscreen'

ui_page 'source/index.html'

client_scripts {
    'config.lua',
    'config_ui.lua',
    'resource/client.lua'
}

server_scripts {
    'config.lua',
    'resource/server.lua',
}

files {
    'source/*',
    'source/images/*',
    'source/fonts/*'
}

escrow_ignore {
    'config.lua',
    'config_ui.lua'
}

lua54 'yes'