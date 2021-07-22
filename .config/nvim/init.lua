-- Load the globals object for user customization
require("globals")
vim.cmd("luafile " .. CONFIG_PATH .. "/config.lua")

-- Load the core settings
require("general")
require("keymappings")
require("plugins")
-- NOTE: Make sure that `lsp` is loaded after `plugins` as it relies on some plugins
require("lsp")

-- TODO: Refactor `which_key`, `telescope` and `nvim_tree` config with the new structure
