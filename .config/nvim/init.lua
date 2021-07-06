-- Load global default settings
require("globals")

-- Load configs
require("general")
require("keymappings")
require("plugins")
-- NOTE: Make sure that `lsp` is loaded after `plugins` as it relies on some plugins
require("lsp")
