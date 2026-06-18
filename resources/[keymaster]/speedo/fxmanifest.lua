fx_version "cerulean"

description "Speedometer"
author "NEVA"
version '1.0.1'

lua54 'yes'

games {
  "gta5",
  "rdr3"
}

ui_page 'web/build/index.html'

client_script "client/**/*"

files {
	'web/build/index.html',
	'web/build/**/*',
}