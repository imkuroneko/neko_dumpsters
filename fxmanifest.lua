
fx_version 'cerulean'
game 'gta5'
description 'Sistema de búsqueda en basureros para qb-core'
version '1.0.0'

client_scripts {
    'config.lua',
    'client.lua',
}

server_scripts {
    'config.lua',
    'server.lua',
}

dependencies {
	'qb-core',
	'qb-target',
}