local LanguageServer = require("lsp.language_server")

local ls = LanguageServer:create({
  server_name = "tsserver",
  formatters = {
    "prettierd",
    prefer_local = "node_modules/.bin",
  },
  code_actions = "eslint_d",
  linters = {
    "eslint_d",
    condition = function(utils) return utils.root_has_file(".eslintrc.json") or utils.root_has_file(".eslintrc.js") end,
    prefer_local = "node_modules/.bin",
  },
  formatting = false,
  debugger_name = "jsnode",
  -- debugger_config = {
  -- adapters = {},
  -- configurations = {},
  -- },
})

return ls
