-- Load the global variables
require("globals")

-- Load the core settings
require("general")
require("keymappings")

-- Load plugins
require("plugins").bootstrap_plugin_manager()

require("ui")
require("lsp")

-- Setup Custom Commands
require("commands")
