require("plugins.lsp.config.lsp-config")

vim.cmd("source " .. vim.fn.stdpath("config") ..
            "/lua/plugins/lsp/config/lsp-config.vim")
