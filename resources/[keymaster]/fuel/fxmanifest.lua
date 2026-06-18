version "1.1.0"

fx_version "cerulean"
game "gta5"
lua54 "yes"

shared_script "config.lua"

server_scripts {
    "source/server.lua",
}
client_scripts {
    "source/client.lua"
}

exports {
    'SetFuel',
    'GetFuel'
}

escrow_ignore {
    'config.lua'
}

dependencies {
    'nv_interact'
}