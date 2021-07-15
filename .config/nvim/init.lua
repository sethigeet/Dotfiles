-- Disable some unused built-in Neovim plugins
local disable_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  -- "man",
  -- "matchit",
  -- "matchparen",
  -- "shada_plugin",
}
for _, built_in in ipairs(disable_built_ins) do
  vim.g["loaded_" .. built_in] = true
end

-- Load the globals object for user customization
require("globals")
vim.cmd("luafile " .. CONFIG_PATH .. "/config.lua")

-- Load the core settings
require("general")
require("keymappings")
require("plugins")
-- NOTE: Make sure that `lsp` is loaded after `plugins` as it relies on some plugins
require("lsp")

-- TODO: Refactor `telescope` and `nvim_tree` config with the new structure
