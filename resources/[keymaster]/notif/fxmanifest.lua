fx_version "cerulean"
lua54 'yes'
game 'gta5'

author "NEVA"
description 'Notification system for Neva Framework'
version '1.0.0'

ui_page 'web/build/index.html'

files {
	'web/build/index.html',
	'web/build/**/*',
	'images/*.png',
	'icons/**/*'
}

client_scripts {
	'editable.lua',
	'utils.lua'
}

escrow_ignore {
	'editable.lua',
	'utils.lua'
}
dependency '/assetpacks'

