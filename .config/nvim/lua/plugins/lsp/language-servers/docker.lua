-- ./scripts/install-language-server -n docker
require("lspconfig").dockerls.setup({
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("docker", "docker-langserver",
                                                                "node"), "--stdio"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")("docker", client)
    end,
    handlers = {
        ["textDocument/publishDiagnostics"] = require("plugins.lsp.helpers.diagnostics_handler")(
            "docker")
    }
})

