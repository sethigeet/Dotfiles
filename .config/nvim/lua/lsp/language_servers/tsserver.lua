local LanguageServer = require("lsp.language_server")

local ls = LanguageServer:create({
  server_name = "tsserver",
  formatters = {
    "prettierd",
    prefer_local = "node_modules/.bin",
  },
  code_actions = "eslint",
  linters = {
    "eslint",
    condition = function(utils)
      return utils.root_has_file(".eslintrc.json") or utils.root_has_file(".eslintrc.js")
    end,
    prefer_local = "node_modules/.bin",
  },
  on_attach = function(client, _)
    -- Disable formatting in the lsp server as `null-ls` handles formatting
    client.resolved_capabilities.document_formatting = false
  end,

  debugger_name = "jsnode",
  -- debugger_config = {
  -- adapters = {},
  -- configurations = {},
  -- },
})

return ls
