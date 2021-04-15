-- ./scripts/install-language-server -n graphql
require("lspconfig").graphql.setup({
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("graphql", "graphql-lsp", "node"),
        "server", "-m", "stream"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")("graphql", client)
    end,
    handlers = {
        ["textDocument/publishDiagnostics"] = require("plugins.lsp.helpers.diagnostics_handler")(
            "graphql")
    }
})

