-- npm install -g graphql-language-service-cli
require("lspconfig").graphql.setup({
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("graphql", "graphql-lsp"), "server",
        "-m", "stream"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")(client, bufnr)
    end
})

