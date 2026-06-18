lua54 'yes'

fx_version('bodacious')
game('gta5')
version '1.10.0'  -- Version ESX (requise par ox_inventory >= 1.6.0)

lua54 'yes'

escrow_ignore {
	"config.lua",
	"config.weapons.lua",
	"server/*.lua",
	"server/classes/*.lua",
	"client/*.lua",
	"client/modules/*.lua",
	"translation.lua",
	"locale.lua",
}

shared_script '@ox_lib/init.lua'


server_scripts({
	"@core/dist/modules/async/client/main.lua",
	'@oxmysql/lib/MySQL.lua',

	'locale.lua',
	'locales/fr.lua',

	'config.lua',
	'config.weapons.lua',

	'server/common.lua',
	'translation.lua',
	'server/classes/*.lua',
	'server/functions.lua',
	'server/paycheck.lua',
	'server/main.lua',
	-- 'server/Sv_ServerData.lua',
	'server/commands.lua',
	'server/permsCommand.lua',

	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua'
})

client_scripts({
	'locale.lua',
	'locales/fr.lua',

	'config.lua',
	'config.weapons.lua',

	'client/common.lua',
	'translation.lua',
	'client/entityiter.lua',
	'client/functions.lua',
	'client/wrapper.lua',
	'client/commands.lua',
	'client/main.lua',
	-- 'client/Cl_ServerData.lua',
	-- 'client/blips.lua',

	'client/modules/death.lua',
	'client/modules/scaleform.lua',
	'client/modules/streaming.lua',
	'client/modules/density.lua',

	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/modules/blips.lua',
	'common/functions.lua'
})

ui_page('html/ui.html')

files({
	'locale.js',
	'html/ui.html',

	'html/css/app.css',

	'html/js/mustache.min.js',
	'html/js/wrapper.js',
	'html/js/app.js',

	'html/fonts/pdown.ttf',
	'html/fonts/bankgothic.ttf',

	'html/img/cash.png',
	'html/img/accounts/black_money.png',
	'html/img/accounts/bank.png',
	'*.json'
})


exports {'getSharedObject'}
server_exports {'getSharedObject'}
dependency '/assetpacks'

