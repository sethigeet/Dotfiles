local LanguageServer = require("lsp.language_server")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

-- Schemas https://www.schemastore.org
local schemas = require("schemastore").json.schemas()
table.insert(schemas, {
  name = "Sumneko Lua Settings",
  url = "https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json",
  fileMatch = { ".luarc.json", ".luarc.jsonc" },
})

local ls = LanguageServer:create({
  server_name = "jsonls",
  filetypes = { "json", "jsonc" },
  formatters = "prettierd",
  custom = {
    commands = {
      Format = {
        function() vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 }) end,
      },
    },
    capabilities = capabilities,

    settings = {
      json = {
        schemas = schemas,
      },
    },
  },

  formatting = false,
})

return ls
