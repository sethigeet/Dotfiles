-- npm i -g pyright
require("lspconfig").pyright.setup({
    root_dir = require("plugins.lsp.helpers.root_dir"),
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("python", "pyright-langserver"),
        "--stdio"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")(client, bufnr)
    end
})
