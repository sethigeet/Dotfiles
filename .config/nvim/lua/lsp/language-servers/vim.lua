require("lspconfig").vim.setup({
    root_dir = require("lsp.helpers.root_dir"),
    on_attach = function(client, bufnr)
        require("lsp.helpers.document_highlight")(client)
        require("lsp.helpers.auto_format")("vim", client)
    end,
    handlers = {
        ["textDocument/publishDiagnostics"] = require(
            "lsp.helpers.diagnostics_handler")("vim")
    }
})
