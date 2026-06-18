fx_version 'cerulean'
games { 'gta5' }

lua54 'yes'


server_scripts {
	'server/**.lua',
}
client_scripts {
	'client/**.lua',
}

escrow_ignore {
	'config.lua',
	'README.lua',
	'server/declaesx.lua',
}


shared_script 'config.lua'