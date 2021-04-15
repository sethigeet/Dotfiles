-- ./scripts/install-language-server -n bash
require("lspconfig").bashls.setup({
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("bash", "bash-language-server",
                                                                "node"), "start"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")("sh", client)
    end,
    handlers = {
        ["textDocument/publishDiagnostics"] = require("plugins.lsp.helpers.diagnostics_handler")(
            "sh")
    }
})
