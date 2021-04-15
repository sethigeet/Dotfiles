-- ./scripts/install-language-server -n yaml
require("lspconfig").yamlls.setup({
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("yaml", "yaml-language-server",
                                                                "node"), "--stdio"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")("yaml", client)
    end,
    handlers = {
        ["textDocument/publishDiagnostics"] = require("plugins.lsp.helpers.diagnostics_handler")(
            "yaml")
    }
})
