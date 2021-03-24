-- npm install -g typescript typescript-language-server
require("lspconfig").tsserver.setup({
    root_dir = require("plugins.lsp.helpers.root_dir"),
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("typescript",
                                                                "typescript-language-server"),
        "--stdio"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")(client, bufnr)
    end
})

