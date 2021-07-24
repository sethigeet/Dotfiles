-- Load the globals object for user customization
require("globals")
local personal_config_file_path = CONFIG_PATH .. "/config.lua"
if vim.fn.filereadable(personal_config_file_path) == 1 then
  local status, _ = pcall(vim.cmd, "luafile " .. personal_config_file_path)
  if not status then
    print("There is a problem with the personal config")
  end
end

-- Load the core settings
require("general")
require("keymappings")
require("plugins")
-- NOTE: Make sure that `lsp` is loaded after `plugins` as it relies on some plugins
require("lsp")

-- TODO: Refactor `which_key`, `telescope` and `nvim_tree` config with the new structure
