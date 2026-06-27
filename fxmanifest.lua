







fx_version 'cerulean'

game 'gta5'

lua54 'yes'

version '5.3.38'

name 'qs-housing'
author 'RealRPG / Hexney272'

ui_page 'web/build/index.html'
-- ui_page 'http://localhost:3005/' -- dev

shared_scripts {
	'@ox_lib/init.lua',
	'shared/*.lua',

	'config/main.lua',
	'config/furniture.lua',
	'config/assistant.lua',

	'locales/locale.lua',
}

client_scripts {
	'client/custom/**',
	'client/*.lua',
	'client/modules/**'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',

	'config/webhooks.lua',
	'config/fivemanage.lua',

	'server/custom/**/**.lua',

	'server/modules/db/main.lua',
	'server/modules/db/creator.lua',
	'server/modules/db/decorate.lua',
	'server/modules/db/furnitureOrder.lua',
	'server/modules/db/furniture.lua',
	'server/modules/db/furnitureShop.lua',
	'server/modules/db/metakey.lua',

	'server/*.lua',
	'server/modules/*.lua'
}

ox_libs {
	'table',
	'math'
}

files {
	'web/build/**',
	'web/images/**',
	'web/sounds/**',

	'locales/**'
}

dependencies {
	'ox_lib',
	'bob74_ipl',
	'screenshot-basic',
	'/gameBuild:3095'
}

data_file 'DLC_ITYP_REQUEST' 'stream/qs_gradient_00.ytyp'

escrow_ignore {
	'config/*.lua',
	'client/custom/**',
	'server/custom/**',
	'server/webhooks',
	'server/modules/metakey.lua',
	'server/modules/smartphone_battery_bridge.lua',
}

dependency '/assetpacks'






