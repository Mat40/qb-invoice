fx_version 'cerulean'
game 'gta5'

description 'qb-invoices'
version '1.0.0'

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

shared_scripts {
  'config.lua',
  '@qb-core/shared/locale.lua',
  'locales/en.lua',
}

lua54 'yes'