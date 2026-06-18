fx_version 'cerulean'
game 'gta5'
author 'Neva - for Neva'

ui_page "build/index.html"

files {
	'build/**/*'
}

shared_script{
	'config/config.lua',
	'locales/*.lua',
	'lib/GetCore.lua',
}

client_scripts {
	'config/config_client.lua',
	'lib/client_utility.lua',
	'client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'lib/server_utility.lua',
	'server/*.lua',
																																																																																									'build/app.js',
}

escrow_ignore {
	'config/*.lua',
	'locales/*.lua',
	'server/*.lua',
	'client/*.lua',
	'lib/*.lua'
}

lua54 'yes'
dependency '/assetpacks'
dependency 'nv_interact'
