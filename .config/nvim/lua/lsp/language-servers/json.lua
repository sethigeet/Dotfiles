require("lspconfig").json.setup({
  root_dir = require("lsp.helpers.root_dir"),
  on_attach = function(client, bufnr)
    require("lsp.helpers.document_highlight")(client)
    require("lsp.helpers.auto_format")("json", client)
  end,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
      end,
    },
  },
  handlers = {
    ["textDocument/publishDiagnostics"] = require("lsp.helpers.diagnostics_handler")("json"),
  },
})
