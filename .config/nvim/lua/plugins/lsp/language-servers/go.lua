-- ./scripts/install-language-server -n go
require("lspconfig").gopls.setup({
    cmd = {require("plugins.lsp.helpers.get_language_server_path")("go", "gopls", "go"), "serve"},
    settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}},
    root_dir = require("plugins.lsp.helpers.root_dir"),
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")("go", client)
    end,
    handlers = {
        ["textDocument/publishDiagnostics"] = require("plugins.lsp.helpers.diagnostics_handler")(
            "go")
    }
})
