require("plugins.lsp.helpers.install_langserver")("dockerfile")

require("lspconfig").dockerfile.setup({
    root_dir = require("plugins.lsp.helpers.root_dir"),
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")("docker", client)
    end,
    handlers = {
        ["textDocument/publishDiagnostics"] = require(
            "plugins.lsp.helpers.diagnostics_handler")("docker")
    }
})

