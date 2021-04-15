-- ./scripts/install-language-server -n css
require("lspconfig").cssls.setup({
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("css", "css-languageserver", "node"),
        "--stdio"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")("css", client)
    end,
    handlers = {
        ["textDocument/publishDiagnostics"] = require("plugins.lsp.helpers.diagnostics_handler")(
            "css")
    }
})
