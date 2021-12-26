-- TODO: Remove this with the corresponding plugin after the PR is merged
require("impatient")

-- Load the global variables
require("globals")

-- Load the core settings
require("general")
require("keymappings")
require("ui")

-- Only load `lsp` if plugins are available as `lsp` requires some plugins right now
if vim.fn.filereadable(CONFIG_PATH .. "/plugin/packer_compiled.lua") == 1 then
  require("lsp")
end
