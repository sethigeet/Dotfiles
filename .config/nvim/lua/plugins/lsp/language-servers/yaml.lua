-- npm install -g yaml-language-server
require("lspconfig").yamlls.setup({
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("yaml", "yaml-language-server"),
        "--stdio"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")(client, bufnr)
    end
})
