require("lspconfig").go.setup({
    settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
    root_dir = require("plugins.lsp.helpers.root_dir"),
    init_options = { usePlaceholders = true },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")("go", client)
    end,
    handlers = {
        ["textDocument/publishDiagnostics"] = require("plugins.lsp.helpers.diagnostics_handler")(
            "go")
    }
})
