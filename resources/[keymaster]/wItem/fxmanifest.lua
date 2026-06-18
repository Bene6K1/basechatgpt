fx_version 'cerulean'
game 'gta5'

author 'NEVA'
description 'wItem - Item usage system'
version '1.0.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
    'client/cl_item.lua'
}

server_scripts {
    'server/sv_item.lua',
}

dependencies {
    'es_extended',
    'ox_lib'
}
