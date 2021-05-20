require("lspconfig").typescript.setup({
    root_dir = require("lsp.helpers.root_dir"),
    on_attach = function(client, bufnr)
        -- Disable formatting in the lsp server as prettier formats the code
        client.resolved_capabilities.document_formatting = false
        require("lsp.helpers.document_highlight")(client)
        require("lsp.helpers.auto_format")("typescript", client)
    end,
    handlers = {
        ["textDocument/publishDiagnostics"] = require(
            "lsp.helpers.diagnostics_handler")("typescript")
    }
})
