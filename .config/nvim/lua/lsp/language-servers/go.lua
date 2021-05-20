require("lspconfig").go.setup({
    settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}},
    root_dir = require("lsp.helpers.root_dir"),
    init_options = {usePlaceholders = true},
    on_attach = function(client, bufnr)
        require("lsp.helpers.document_highlight")(client)
        require("lsp.helpers.auto_format")("go", client)
    end,
    handlers = {
        ["textDocument/publishDiagnostics"] = require(
            "lsp.helpers.diagnostics_handler")("go")
    }
})
