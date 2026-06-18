fx_version 'adamant'

game 'gta5'
author "N E V A"
description 'Shop'

lua54 'yes'

client_script {'client/*.lua'}

server_script {'@oxmysql/lib/MySQL.lua', 'server/main.lua'}

ui_page {"html/dist/index.html"}

files {
    "html/dist/index.html", "html/dist/assets/*.*", "html/dist/assets/**/*.*"
}

lua54 'yes'

shared_script 'shared/config.lua'

exports {'OpenShop'}