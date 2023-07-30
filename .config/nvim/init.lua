-- Load the global variables
require("globals")

-- Load the core settings
require("general")
require("keymappings")
require("diagnostic")

-- Load plugins
require("plugins").bootstrap_plugin_manager()

-- NOTE: Load `ui` before `lsp` as some of lsp features require `ui`
require("ui")
require("lsp")

--[[
-- Disable semantic token highlighting
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
end
--]]
