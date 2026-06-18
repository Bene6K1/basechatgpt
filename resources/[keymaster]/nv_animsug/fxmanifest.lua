fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
author 'N E V A'
description 'Animations suggestions'
version '1.0.1'
ui_page 'nui/index.html'
files {
    'nui/*.html',
    'nui/js/*.js',
}
server_scripts {
    'server/server.lua',
}
client_scripts {
    'config.lua',
    'locale.lua',
    'client/constants.lua',
    'client/settings.lua',
    'client/functions.lua',
    'client/cache.lua',
    'client/client.lua',
    'client/editable/client.lua',
}
escrow_ignore {
    'config.lua',
    'locale.lua',
    'client/editable/*.lua',
}
