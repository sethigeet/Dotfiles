-- ./scripts/install-language-server -n html
-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").html.setup({
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("html", "html-languageserver",
                                                                "node"), "--stdio"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")(client, bufnr)
    end,
    capabilities = capabilities
})

