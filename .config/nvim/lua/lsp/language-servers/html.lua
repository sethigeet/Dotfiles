-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").html.setup({
    root_dir = require("lsp.helpers.root_dir"),
    on_attach = function(client, bufnr)
        require("lsp.helpers.document_highlight")(client)
        require("lsp.helpers.auto_format")("html", client)
    end,
    capabilities = capabilities,
    handlers = {
        ["textDocument/publishDiagnostics"] = require(
            "lsp.helpers.diagnostics_handler")("html")
    }
})

