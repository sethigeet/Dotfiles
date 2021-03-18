-- npm install -g vscode-css-languageserver-bin
require("lspconfig").cssls.setup({
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")(client, bufnr)
    end
})
