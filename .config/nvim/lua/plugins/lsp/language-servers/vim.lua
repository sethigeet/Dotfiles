-- npm install -g vim-language-server
require("lspconfig").vimls.setup({
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("vim", "vim-language-server"),
        "--stdio"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")(client, bufnr)
    end
})
