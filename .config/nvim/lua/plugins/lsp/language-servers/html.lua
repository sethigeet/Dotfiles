require("plugins.lsp.helpers.install_langserver")("html")

-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").html.setup({
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")("html", client)
    end,
    capabilities = capabilities,
    handlers = {
        ["textDocument/publishDiagnostics"] = require(
            "plugins.lsp.helpers.diagnostics_handler")("html")
    }
})

