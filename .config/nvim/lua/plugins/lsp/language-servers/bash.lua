-- npm i -g bash-language-server
require("lspconfig").bashls.setup({
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("bash", "bash-language-server"),
        "start"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")(client, bufnr)
    end
})
