-- Load global default settings
require("globals")
vim.cmd("luafile " .. CONFIG_PATH .. "/config.lua")

-- Load configs
require("general")
require("keymappings")
require("plugins")
-- NOTE: Make sure that `lsp` is loaded after `plugins` as it relies on some plugins
require("lsp")

-- TODO: Refactor `telescope` and `nvim_tree` config with the new structure
-- TODO: Add `yp` mapping
