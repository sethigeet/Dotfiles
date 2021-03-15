-- source the polyglot config before loading the acutal plugin!
require("plugins.configs.polyglot")

vim.cmd("source " .. vim.fn.stdpath("config") .. "/lua/plugins/plugins.vim")

require("plugins.configs")
require("plugins.lsp")
