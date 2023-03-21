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
