-- Load global default settings
require("globals")

-- Load user settings
vim.cmd("luafile " .. CONFIG_PATH .. "/settings.lua")

-- Load configs
require("general")
require("keymappings")
require("plugins")

