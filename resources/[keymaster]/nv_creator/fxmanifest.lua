fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Neva'
description 'Neva Character System : Creator / Manage players character(s).'
version '1.0.0'

dependencies {
    'oxmysql',
    'es_extended',
    'luacore'
}

shared_script 'Config.lua'

client_scripts {
    'client/modules/**/*',
    'client/Main.lua',
    'client/exports.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/modules/**/*',
    'server/*.lua'
}

ui_page 'web/dist/index.html'

files {
    'web/dist/**/*',
    'web/public/**/*'
}

escrow_ignore {
    'Config.lua',
    'web/node_modules/**',
    'web/node_modules/**/**',
    'web/node_modules/**/**/**',
    'web/src/**',
    'web/src/**/**',
    'web/public/**',
    'web/package.json',
    'web/package-lock.json',
    'web/tsconfig.json',
    'web/tsconfig.*.json',
    'web/vite.config.ts',
    'web/eslint.config.js',
    'web/.gitignore'
}