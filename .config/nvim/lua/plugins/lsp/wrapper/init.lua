require("plugins.lsp.wrapper.lsp-wrapper")

vim.cmd("source " .. vim.fn.stdpath("config") ..
            "/lua/plugins/lsp/wrapper/lsp-wrapper.vim")
