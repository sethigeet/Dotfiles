-- npm install -g vscode-css-languageserver-bin
require("lspconfig").cssls.setup({
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("css", "css-languageserver"),
        "--stdio"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")(client, bufnr)
    end
})
