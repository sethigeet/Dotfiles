-- ./scripts/install-language-server -n json
require("lspconfig").jsonls.setup({
    cmd = {
        require("plugins.lsp.helpers.get_language_server_path")("json",
                                                                "vscode-json-languageserver", "node"),
        "--stdio"
    },
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")("json", client)
    end,
    commands = {
        Format = {function() vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0}) end}
    },
    handlers = {
        ["textDocument/publishDiagnostics"] = require("plugins.lsp.helpers.diagnostics_handler")(
            "json")
    }
})

