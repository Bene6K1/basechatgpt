fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'N E V A'
description ''
version '1.3.0'

shared_scripts {
	'locale.lua',
	'config.lua'
}

client_script "client/**/*"
server_script{
	"server/utils.lua",
	"server/*.lua"
}

ui_page 'web/build/index.html'
files {
	'web/build/index.html',
	'web/build/**/*',
}

escrow_ignore {
	"config.lua",
	"locale.lua",
	"client/**/*",
	"server/**/*"
}
dependency '/assetpacks'

