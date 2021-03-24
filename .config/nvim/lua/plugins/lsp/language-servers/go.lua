-- require("lspconfig").gopls.setup({
--     on_attach = function(client, bufnr)
--         require("plugins.lsp.helpers.document_highlight")(client)
--         require("plugins.lsp.helpers.auto_format")(client, bufnr)
--     end
-- })
require("lspconfig").gopls.setup({
    cmd = {"gopls", "serve"},
    settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}},
    root_dir = require("plugins.lsp.helpers.root_dir"),
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")(client, bufnr)
    end
})
