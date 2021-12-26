local LanguageServer = require("lsp.helpers.language_server")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

local ls = LanguageServer:create({
  server_name = "jsonls",
  filetypes = { "json", "jsonc" },
  formatters = "prettierd",
  on_attach = function(client, _)
    -- Disable formatting in the lsp server as `null-ls` handles formatting
    client.resolved_capabilities.document_formatting = false
  end,
  custom = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
    capabilities = capabilities,

    settings = {
      json = {
        -- Schemas https://www.schemastore.org
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
})

return ls
