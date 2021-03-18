-- npm install -g graphql-language-service-cli
require("lspconfig").graphql.setup({
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")(client, bufnr)
    end
})

