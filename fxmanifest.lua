---@author Dezel

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Dezel#8203'
description 'Complete laboratory system'
version '1.0.0'

--Vendors
client_scripts {
    "src/vendors/ui/RMenu.lua",
    "src/vendors/ui/menu/RageUI.lua",
    "src/vendors/ui/menu/Menu.lua",
    "src/vendors/ui/menu/MenuController.lua",
    "src/vendors/ui/components/*.lua",
    "src/vendors/ui/menu/elements/*.lua",
    "src/vendors/ui/menu/items/*.lua",
    "src/vendors/ui/menu/panels/*.lua",
    "src/vendors/ui/menu/panels/*.lua",
    "src/vendors/ui/menu/windows/*.lua",
    "src/vendors/sound/client/main.lua"
}
server_script "@oxmysql/lib/MySQL.lua"
server_script "src/vendors/sound/server/main.lua"
ui_page "src/vendors/sound/client/html/index.html"
files {
    'src/vendors/sound/client/html/index.html',
    -- Begin Sound Files Here...
    -- client/html/sounds/ ... .ogg
    'src/vendors/sound/client/html/sounds/demo.ogg',
    'src/vendors/sound/client/html/sounds/methylamine.ogg',
    'src/vendors/sound/client/html/sounds/furnace.ogg',
    'src/vendors/sound/client/html/sounds/finish_sound_effect.ogg',
    'src/vendors/sound/client/html/sounds/gaz.ogg',
}


--Config
shared_script "config/_define.lua"
shared_script "config/*.lua"

--Locales
shared_script "locales/*.lua"

shared_script "src/bootstrap.lua"

--Enum
shared_script "src/enum/*.lua"

--Utils
shared_script "src/utils/**/shared/*.lua"
server_script "src/utils/**/server/*.lua"
client_script "src/utils/**/client/*.lua"

--Class
shared_script "src/class/*.lua"

--Modules
shared_script "src/modules/**/shared/*.lua"
server_script "src/modules/**/server/*.lua"
client_script "src/modules/**/client/*.lua"

--Commands
server_script "src/commands/server/*.lua"
client_script "src/commands/client/*.lua"