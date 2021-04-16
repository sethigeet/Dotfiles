-- Load global default settings
require("globals")

-- Load user settings
vim.cmd("luafile " .. CONFIG_PATH .. "/settings.lua")

-- Load configs
require("general")
require("keymappings")
require("plugins")

-- TODO: fix this!
vim.cmd("source " .. CONFIG_PATH .. "/lua/plugins/configs/whichkey.vim")

-- TODO: Add emmet-ls as lsp instead of using emmet-vim plugin

