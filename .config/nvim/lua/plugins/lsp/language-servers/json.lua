require("plugins.lsp.helpers.install_langserver")("json")

require("lspconfig").json.setup({
    on_attach = function(client, bufnr)
        require("plugins.lsp.helpers.document_highlight")(client)
        require("plugins.lsp.helpers.auto_format")("json", client)
    end,
    commands = {
        Format = {
            function()
                vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
            end
        }
    },
    handlers = {
        ["textDocument/publishDiagnostics"] = require(
            "plugins.lsp.helpers.diagnostics_handler")("json")
    }
})

