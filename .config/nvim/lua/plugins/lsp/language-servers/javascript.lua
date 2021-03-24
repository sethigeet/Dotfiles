-- ./scripts/install-language-server -n js
require("lspconfig").tsserver.setup({
    root_dir = require("plugins.lsp.helpers.root_dir"),
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("typescript",
                                                                "typescript-language-server", "node"),
        "--stdio"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")(client, bufnr)
    end
})

